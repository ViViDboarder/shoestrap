#! /bin/bash

# Gets the current settings for the given terminal window
function get_terminal_settings {
    case "$TERM_PROGRAM" in
        Apple_Terminal)
            osascript <<EOD
        set current_tty to "$(tty)"
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
EOD
            ;;
        iTerm.app)
            echo "$ITERM_PROFILE"
            ;;
        *)
            echo "Unknown terminal $TERM_PROGRAM"
            exit 1
    esac
}

# Mappings of Terminal themes to color schemes
function get_vim_colorscheme {
    local term_theme="$1"
    case "$term_theme" in
        "Hotkey Window Wombat")
            echo "wombat256mod"
            ;;
        Wombat*)
            echo "wombat256mod"
            ;;
        Solarized*)
            echo "solarized"
            ;;
        "Yosemite Light"*)
            echo "morning"
            ;;
        "Yosemite Dark"*)
            echo "vividchalk"
            ;;
        *)
            echo "wombat256mod"
            ;;
    esac
}

get_vim_colorscheme "$(get_terminal_settings)"
