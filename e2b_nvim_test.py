#!/usr/bin/env python3
"""
E2B Neovim Config Troubleshooter

Spins up an E2B cloud sandbox, uploads your Neovim config,
installs Neovim, runs plugin installation, and reports any errors.
"""

import os
import time

from e2b import Sandbox

# ── Configuration ──────────────────────────────────────────────
NVIM_CONFIG_LOCAL = os.path.expanduser("~/.config/nvim")
NVIM_CONFIG_REMOTE = "/home/user/.config/nvim"
SANDBOX_TIMEOUT = 900  # 15 minutes (plugin sync can be very slow)
NVIM_VERSION = "nightly"  # Use nightly (0.12.0-dev) to match local setup

# Files/dirs to skip uploading (not needed in sandbox)
SKIP_PATTERNS = {
    ".git",
    ".claude",
    "node_modules",
    "__pycache__",
    ".DS_Store",
    "e2b_nvim_test.py",  # Don't upload this script itself
}


def collect_files(local_dir: str) -> list[dict]:
    """Recursively collect all files from the local nvim config directory."""
    files = []
    for root, dirs, filenames in os.walk(local_dir):
        # Filter out skipped directories in-place
        dirs[:] = [d for d in dirs if d not in SKIP_PATTERNS]

        for filename in filenames:
            if filename in SKIP_PATTERNS:
                continue

            local_path = os.path.join(root, filename)
            # Compute the relative path from the config root
            rel_path = os.path.relpath(local_path, local_dir)
            remote_path = f"{NVIM_CONFIG_REMOTE}/{rel_path}"

            try:
                with open(local_path, "rb") as f:
                    data = f.read()
                files.append({"path": remote_path, "data": data})
            except (PermissionError, OSError) as e:
                print(f"  ⚠ Skipping {rel_path}: {e}")

    return files


def run_cmd(sbx: Sandbox, cmd: str, label: str = "", allow_fail: bool = True) -> str:
    """Run a command in the sandbox and return combined output."""
    display = label or cmd
    print(f"\n{'─' * 60}")
    print(f"▶ {display}")
    print(f"{'─' * 60}")

    from e2b.sandbox.commands.command_handle import CommandExitException

    try:
        result = sbx.commands.run(cmd, timeout=600)
    except CommandExitException as e:
        # The SDK raises on non-zero exit codes; capture the output anyway
        print(f"  {e}")
        if not allow_fail:
            raise
        return str(e)

    output = ""
    if result.stdout:
        output += result.stdout
    if result.stderr:
        output += result.stderr

    if output.strip():
        # Truncate very long output
        lines = output.strip().split("\n")
        if len(lines) > 80:
            print("\n".join(lines[:40]))
            print(f"\n  ... ({len(lines) - 80} lines omitted) ...\n")
            print("\n".join(lines[-40:]))
        else:
            print(output.strip())
    else:
        print("  (no output)")

    if result.exit_code != 0:
        print(f"\n  ✘ Exit code: {result.exit_code}")
    else:
        print(f"\n  ✔ Exit code: 0")

    return output


def main():
    print("=" * 60)
    print("  E2B Neovim Config Troubleshooter")
    print("=" * 60)

    # ── Step 1: Collect local config files ─────────────────────
    print(f"\n📁 Collecting files from {NVIM_CONFIG_LOCAL}...")
    files = collect_files(NVIM_CONFIG_LOCAL)
    print(f"   Found {len(files)} files to upload")

    # ── Step 2: Create sandbox ─────────────────────────────────
    print("\n🚀 Creating E2B sandbox...")
    sbx = Sandbox.create(timeout=SANDBOX_TIMEOUT)
    print(f"   Sandbox ID: {sbx.sandbox_id}")

    try:
        # ── Step 3: Set up environment ─────────────────────────
        run_cmd(
            sbx,
            'export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 && echo "LANG=en_US.UTF-8" | sudo tee -a /etc/environment && echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment',
            "Setting locale to UTF-8",
        )

        # ── Step 4: Install system dependencies ───────────────
        # Kill any running apt processes and remove locks before installing
        run_cmd(
            sbx,
            "sudo killall apt-get 2>/dev/null; sudo killall dpkg 2>/dev/null; "
            "sudo rm -f /var/lib/apt/lists/lock /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend /var/cache/apt/archives/lock; "
            "sudo dpkg --configure -a 2>&1; "
            "sudo apt-get update 2>&1 && "
            "sudo apt-get install -y git curl ripgrep fd-find unzip build-essential npm locales "
            "imagemagick texlive-latex-base texlive-latex-extra texlive-fonts-recommended dvipng 2>&1",
            "Installing system dependencies (with lock cleanup)",
        )

        # Verify git is available (critical for lazy.nvim)
        run_cmd(sbx, "which git && git --version", "Verify git installation")
        run_cmd(
            sbx,
            'sudo sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && sudo locale-gen 2>&1',
            "Generating UTF-8 locale",
        )

        # ── Verify LaTeX dependencies for core.latex.renderer ──
        run_cmd(
            sbx,
            "which dvipng && dvipng --version | head -1 && which magick || which convert && echo 'ImageMagick available'",
            "Verify LaTeX renderer dependencies (dvipng + ImageMagick)",
        )

        # ── Step 5: Install Neovim via AppImage ───────────────
        run_cmd(
            sbx,
            f"curl -fsSL https://github.com/neovim/neovim/releases/download/{NVIM_VERSION}/nvim-linux-x86_64.tar.gz -o /tmp/nvim.tar.gz "
            f"&& sudo tar xzf /tmp/nvim.tar.gz -C /opt/ "
            f"&& sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim",
            f"Installing Neovim {NVIM_VERSION} from GitHub releases",
        )

        # Check Neovim version
        run_cmd(sbx, "nvim --version | head -5", "Neovim version")

        # ── Step 4: Upload config ──────────────────────────────
        print(f"\n📤 Uploading {len(files)} config files to sandbox...")
        upload_start = time.time()

        for i, file_info in enumerate(files):
            sbx.files.write(file_info["path"], file_info["data"])
            if (i + 1) % 20 == 0 or (i + 1) == len(files):
                print(f"   Uploaded {i + 1}/{len(files)} files...")

        elapsed = time.time() - upload_start
        print(f"   ✔ Upload complete in {elapsed:.1f}s")

        # Verify upload
        run_cmd(sbx, f"ls -la {NVIM_CONFIG_REMOTE}/", "Verify config directory")
        run_cmd(sbx, f"cat {NVIM_CONFIG_REMOTE}/init.lua", "Verify init.lua")

        # ── Step 5: Run Neovim headless - Plugin Install ───────
        print("\n" + "=" * 60)
        print("  PHASE 1: Plugin Installation (lazy.nvim bootstrap)")
        print("=" * 60)

        # Run Lazy sync as a background process and poll for completion
        # The approach: start nvim, run Lazy restore (uses lockfile for exact versions),
        # write a sentinel file when done, then quit
        print("\n  Starting Lazy restore in background (cloning ~50 plugins)...")
        sbx.commands.run(
            'LANG=en_US.UTF-8 TERM=xterm-256color HOME=/home/user '
            'nvim --headless -c \'lua require("lazy").restore({wait=true}); '
            'io.open("/tmp/lazy_done", "w"):close(); vim.cmd("qa!")\' '
            '>/tmp/lazy_output.txt 2>&1',
            background=True,
            timeout=0,  # No timeout for background process
        )

        # Poll for the sentinel file with a generous timeout
        max_wait = 540  # 9 minutes
        start_time = time.time()
        while time.time() - start_time < max_wait:
            try:
                check = sbx.commands.run("test -f /tmp/lazy_done && echo DONE || echo WAITING", timeout=10)
                if "DONE" in (check.stdout or ""):
                    print(f"  ✔ Lazy restore completed in {time.time() - start_time:.0f}s")
                    break
            except Exception:
                pass
            time.sleep(10)
            elapsed = int(time.time() - start_time)
            # Show progress
            try:
                progress = sbx.commands.run(
                    "ls /home/user/.local/share/nvim/lazy/ 2>/dev/null | wc -l",
                    timeout=10,
                )
                count = (progress.stdout or "0").strip()
                print(f"  ⏳ {elapsed}s elapsed... {count} plugins cloned so far")
            except Exception:
                print(f"  ⏳ {elapsed}s elapsed...")
        else:
            print(f"  ⚠ Lazy restore timed out after {max_wait}s — continuing with partial install")

        # Show Lazy output
        run_cmd(sbx, "cat /tmp/lazy_output.txt 2>/dev/null || echo 'No output captured'", "Lazy sync output")

        # ── Step 6: Run Neovim headless - Startup Test ─────────
        print("\n" + "=" * 60)
        print("  PHASE 2: Startup Error Check")
        print("=" * 60)

        run_cmd(
            sbx,
            'LANG=en_US.UTF-8 TERM=xterm-256color HOME=/home/user nvim --headless -c "lua print(\'Neovim started successfully\')" -c "messages" -c "qa!" 2>&1 || true',
            "Neovim headless startup test",
        )

        # ── Step 7: Check for error messages ───────────────────
        print("\n" + "=" * 60)
        print("  PHASE 3: Error Message Collection")
        print("=" * 60)

        run_cmd(
            sbx,
            'LANG=en_US.UTF-8 TERM=xterm-256color HOME=/home/user nvim --headless -c "redir! > /tmp/nvim_messages.txt" -c "silent messages" -c "redir END" -c "qa!" 2>&1; cat /tmp/nvim_messages.txt 2>/dev/null || true',
            "Collecting Neovim messages",
        )

        # ── Step 8: Check plugin status ────────────────────────
        print("\n" + "=" * 60)
        print("  PHASE 4: Plugin Status Check")
        print("=" * 60)

        run_cmd(
            sbx,
            """nvim --headless -c "lua local ok, lazy = pcall(require, 'lazy'); if ok then local plugins = lazy.plugins(); local loaded, errors = 0, 0; for name, plugin in pairs(plugins) do if plugin._.loaded then loaded = loaded + 1 else errors = errors + 1; print('NOT LOADED: ' .. name) end end; print('\\nTotal: ' .. vim.tbl_count(plugins) .. ' plugins, ' .. loaded .. ' loaded, ' .. errors .. ' not loaded') else print('ERROR: lazy.nvim not available') end" -c "qa!" 2>&1 || true""",
            "Plugin load status",
        )

        # ── Step 9: checkhealth ────────────────────────────────
        print("\n" + "=" * 60)
        print("  PHASE 5: Health Check")
        print("=" * 60)

        run_cmd(
            sbx,
            'LANG=en_US.UTF-8 TERM=xterm-256color HOME=/home/user nvim --headless -c "checkhealth" -c "w! /tmp/health.txt" -c "qa!" 2>&1; cat /tmp/health.txt 2>/dev/null | head -200 || true',
            "Neovim :checkhealth",
        )

        # ── Neorg + LaTeX Renderer Validation ─────────────────
        print("\n" + "=" * 60)
        print("  PHASE 5b: Neorg + core.latex.renderer Validation")
        print("=" * 60)

        run_cmd(
            sbx,
            'LANG=en_US.UTF-8 TERM=xterm-256color HOME=/home/user '
            'nvim --headless -c "lua '
            "local ok, neorg = pcall(require, 'neorg'); "
            "if ok then "
            "  print('Neorg loaded: YES'); "
            "  local cfg = neorg.modules and neorg.modules.loaded_modules or {}; "
            "  for name, _ in pairs(cfg) do "
            "    if name:match('latex') then print('  Module: ' .. name) end "
            "  end "
            "else "
            "  print('Neorg loaded: NO - ' .. tostring(neorg)) "
            'end" -c "qa!" 2>&1 || true',
            "Neorg module load check",
        )

        run_cmd(
            sbx,
            'LANG=en_US.UTF-8 TERM=xterm-256color HOME=/home/user '
            'nvim --headless -c "checkhealth neorg" -c "w! /tmp/neorg_health.txt" -c "qa!" 2>&1; '
            'cat /tmp/neorg_health.txt 2>/dev/null || echo "No neorg health output"',
            "Neorg :checkhealth",
        )

        # ── Step 10: Check LSP servers ─────────────────────────
        print("\n" + "=" * 60)
        print("  PHASE 6: LSP & Mason Status")
        print("=" * 60)

        run_cmd(
            sbx,
            'ls -la /home/user/.local/share/nvim/mason/bin/ 2>/dev/null || echo "Mason bin directory not found (no LSP servers installed yet)"',
            "Mason installed servers",
        )

        # ── Step 11: Check for common issues ───────────────────
        print("\n" + "=" * 60)
        print("  PHASE 7: Common Issue Scan")
        print("=" * 60)

        run_cmd(
            sbx,
            f'grep -rn "require" {NVIM_CONFIG_REMOTE}/lua/ 2>/dev/null | grep -i "error\\|fail\\|not found" || echo "No suspicious require patterns found"',
            "Scanning for broken requires",
        )

        run_cmd(
            sbx,
            'ls -la /home/user/.local/share/nvim/lazy/ 2>/dev/null | head -60 || echo "Lazy plugin directory not found"',
            "Installed plugin directories",
        )

        # ── Summary ────────────────────────────────────────────
        print("\n" + "=" * 60)
        print("  TROUBLESHOOTING COMPLETE")
        print("=" * 60)
        print(f"\n  Sandbox ID: {sbx.sandbox_id}")
        print(f"  The sandbox will stay alive for ~{SANDBOX_TIMEOUT}s")
        print("  You can connect to it for manual investigation if needed.\n")

    except Exception as e:
        print(f"\n❌ Error during troubleshooting: {e}")
        raise
    finally:
        # Ask before killing
        try:
            answer = input("\n🛑 Kill the sandbox? (y/N): ").strip().lower()
            if answer == "y":
                sbx.kill()
                print("  Sandbox terminated.")
            else:
                print(f"  Sandbox {sbx.sandbox_id} left running (will auto-terminate after timeout).")
        except (EOFError, KeyboardInterrupt):
            print("\n  Sandbox left running.")


if __name__ == "__main__":
    main()
