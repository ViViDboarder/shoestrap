#! /usr/bin/env python3
"""Derive colors determines colorschemes for various tools based on the
current terminal"""
import argparse
import os
import sys
import textwrap
from subprocess import PIPE, Popen, check_output
from typing import Tuple


TERM_VAR = "TERM_PROFILE"
VIM_VAR = "VIM_COLOR"
NVIM_VAR = "NVIM_COLOR"
BAT_VAR = "BAT_THEME"
TERMINAL_SETTINGS_SCRIPT = """
set current_tty to "{}"
tell application "Terminal"
    repeat with win in windows
        repeat with the_tab in tabs of win
            set tab_settings to the current settings of the_tab
            if current_tty is equal to the tty of the_tab then
                return the name of tab_settings
            end if
        end repeat
    end repeat
end tell
"""


def run_applescript(script: str) -> Tuple[int, str, str]:
    """Executes an applescript string and return the results"""
    with Popen(
        ['osascript', '-'],
        stdin=PIPE,
        stdout=PIPE,
        stderr=PIPE,
        universal_newlines=True,
    ) as proc:
        stdout, stderr = proc.communicate(script)
        return proc.returncode, str(stdout).strip(), str(stderr).strip()


def get_terminal_profile(force=False) -> str:
    """Returns the terminal profile from TERM_PROFILE or
    derrives through detecting the profile"""
    if not force and TERM_VAR in os.environ:
        return os.environ[TERM_VAR]

    # If over SSH, quit. Colorschemes should instead be forwarded
    if is_ssh():
        print(
            ("Warning: Cannot derive colors. "
                "SSH sessions won't allow detecting the terminal profile."
                f" Instead forward {TERM_VAR} from your source machine."),
            file=sys.stderr,
        )
        sys.exit(0)

    term_program = os.environ.get("TERM_PROGRAM")
    if term_program == "Apple_Terminal":
        tty_b = check_output(["tty"]).strip()
        tty = str(tty_b, encoding="utf-8")
        code, stdout, _ = run_applescript(
            TERMINAL_SETTINGS_SCRIPT.format(tty),
        )
        if code:
            raise SystemError("Could not get results from applescript")
        return stdout
    if term_program == "iTerm.app":
        if "ITERM_PROFILE" in os.environ:
            return os.environ["ITERM_PROFILE"]
        raise ValueError("Using iTerm but no profile found")
    if term_program == "Alacritty":
        return "Alacritty"

    if os.environ.get("GNOME_TERMINAL_SCREEN") is not None:
        return "Gnome Terminal"

    # If we got this far, we don't know what to do
    raise ValueError(f"Unknown terminal {term_program}")


def get_vim_colorscheme(
    terminal_profile: str,
    _force_dark=False,
    force=False,
) -> str:
    """Returns the best colorscheme for a given terminal profile"""
    if not force and VIM_VAR in os.environ:
        return os.environ[VIM_VAR]

    colorscheme = "wombat256mod"

    if terminal_profile in "Wombat":
        colorscheme = "wombat256mod"
    elif terminal_profile == "Alacritty":
        colorscheme = "wombat256mod"
    elif terminal_profile == "Yosemite Light":
        colorscheme = "morning"
    elif terminal_profile == "Yosemite Dark":
        colorscheme = "vividchalk"
    elif terminal_profile == "Basic":
        colorscheme = "default"
    elif "Solarized" in terminal_profile:
        colorscheme = "solarized"

    return colorscheme


def get_nvim_colorscheme(
    terminal_profile: str,
    _force_dark=False,
    force=False,
) -> str:
    """Returns the best colorscheme for a given terminal profile"""
    if not force and NVIM_VAR in os.environ:
        return os.environ[NVIM_VAR]

    colorscheme = "wombat"

    if terminal_profile in "Wombat":
        colorscheme = "wombat"
    elif terminal_profile == "Alacritty":
        colorscheme = "wombat"
    elif terminal_profile == "Yosemite Light":
        colorscheme = "morning"
    elif terminal_profile == "Yosemite Dark":
        colorscheme = "vividchalk"
    elif terminal_profile == "Basic":
        colorscheme = "default"
    elif "Solarized" in terminal_profile:
        colorscheme = "solarized"

    return colorscheme


def get_bat_theme(terminal_profile: str, force_dark=False, force=False) -> str:
    """Returns the best matched bat theme for the terminal"""
    if not force and BAT_VAR in os.environ:
        return os.environ[BAT_VAR]

    # Determine if this is a dark theme
    is_dark = force_dark or "dark" in terminal_profile.lower()

    bat_theme = "DarkNeon" if is_dark else "ansi-light"

    if "Wombat" in terminal_profile:
        bat_theme = "DarkNeon"
    elif terminal_profile == "Alacritty":
        bat_theme = "DarkNeon"
    elif "Solarized" in terminal_profile:
        if is_dark:
            bat_theme = "Solarized (dark)"
        else:
            bat_theme = "Solarized (light)"

    return bat_theme


def parse_args(**args) -> argparse.Namespace:
    """Parse and return args from the terminal"""
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=textwrap.dedent("""
            This tool inspects the current terminal to determine which
            colorschemes is in use and which themes should should be used by
            various other tools, like vim and bat.

            When running this command, the variables will be printed such
            that they can be sourced by your shell.

            If your terminal themes are not derrivable, or you'd like to
            hard code for performance reasons (detecting Terminal.app profiles
            is kinda slow), the variables to export are:

                TERM_PROFILE    Profile name of your current terminal. Used
                                to derive the other colorschemes.

                VIM_COLOR       Colorscheme to set in Vim. This can be used to
                                set your theme per example: (insert link)

                BAT_THEME       Theme to be used by bat when printing syntax
                                highlighted files.
        """),
        epilog=textwrap.dedent("""\
            To source all variable into your shell, run:
                eval $(derive_colors.py --export)
            If running fish, you must instead use:
                eval (derive_colors.py --export --fish)
        """))
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "--print-term",
        action="store_true",
        help="Print only the value of the terminal profile",
    )
    group.add_argument(
        "--print-vim",
        action="store_true",
        help="Print only the value of the vim colorscheme",
    )
    group.add_argument(
        "--print-bat",
        action="store_true",
        help="Print only the value of the bat theme",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Force reparsing all variables",
    )
    parser.add_argument(
        "--dark",
        action="store_true",
        help="Get dark versions of anything available",
    )
    parser.add_argument(
        "--fish",
        action="store_true",
        help="Print fish compatible env commands",
    )
    parser.add_argument(
        "--export",
        action="store_true",
        help="Print env variables to be exported",
    )
    return parser.parse_args(**args)


def print_all_env(force=False, force_dark=False, export=False, fish=False):
    """Print all variables in env format"""
    term_profile = get_terminal_profile(force=force)
    print_env(TERM_VAR, term_profile, export=export, fish=fish)

    vim_colors = get_vim_colorscheme(
        term_profile,
        _force_dark=force_dark,
        force=force,
    )
    print_env(VIM_VAR, vim_colors, export=export, fish=fish)

    nvim_colors = get_nvim_colorscheme(
        term_profile,
        _force_dark=force_dark,
        force=force,
    )
    print_env(NVIM_VAR, nvim_colors, export=export, fish=fish)

    bat_theme = get_bat_theme(term_profile, force_dark=force_dark, force=force)
    print_env(BAT_VAR, bat_theme, export=export, fish=fish)


def print_env(var: str, val: str, export=False, fish=False):
    """Print variable in env format"""
    if not fish:
        if export:
            print(f'export {var}="{val}"')
        else:
            print(f'{var}="{val}"')
    elif fish:
        if export:
            print(f'set -gx {var} "{val}";')
        else:
            print(f'set -g {var} "{val}";')


def is_ssh() -> bool:
    """Detect if we're in an SSH session"""
    if os.environ.get("SSH_TTY"):
        return True
    return False


def main():
    """Main function"""
    args = parse_args()
    if args.print_term:
        term_profile = get_terminal_profile(force=args.force)
        print(term_profile)
    elif args.print_vim:
        term_profile = get_terminal_profile(force=args.force)
        vim_colors = get_vim_colorscheme(
            term_profile,
            _force_dark=args.dark,
            force=args.force,
        )
        print(vim_colors)
        nvim_colors = get_nvim_colorscheme(
            term_profile,
            _force_dark=args.dark,
            force=args.force,
        )
        print(nvim_colors)
    elif args.print_bat:
        term_profile = get_terminal_profile(force=args.force)
        bat_theme = get_bat_theme(
            term_profile,
            force_dark=args.dark,
            force=args.force,
        )
        print(bat_theme)
    else:
        print_all_env(
            force=args.force,
            force_dark=args.dark,
            fish=args.fish,
            export=args.export,
        )


if __name__ == "__main__":
    main()
