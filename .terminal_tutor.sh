#!/usr/bin/env bash
set -e

# Resolve script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Route subcommands if called with arguments
case "$1" in
  i-installer)
    exec "$SCRIPT_DIR/.Bash-files/i-installer.sh"
    ;;
  man-pages)
    exec "$SCRIPT_DIR/.Bash-files/man.sh"
    ;;
esac

DESKTOP_FILE="$SCRIPT_DIR/bash-tools.desktop"
ICON_FILE="$SCRIPT_DIR/icons/Bash-tools.png"

# ---- Fix permissions for all tools ----
find "$SCRIPT_DIR" -type f \( -name "*.sh" -o -name "*.desktop" \) -exec chmod +x {} \;

# ---- Update .desktop icon dynamically ----
if [[ -f "$DESKTOP_FILE" ]]; then
    if grep -q "^Icon=" "$DESKTOP_FILE"; then
        sed -i "s|^Icon=.*|Icon=$ICON_FILE|" "$DESKTOP_FILE"
    else
        echo "Icon=$ICON_FILE" >> "$DESKTOP_FILE"
    fi
fi

# ---- Refresh icon cache (this is important) ----
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$SCRIPT_DIR" 2>/dev/null || true
fi

#this section above is ony to make things work.

clear
cat <<"EOF"
+=======================================================================================================================+
|   ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗    ████████╗ ██████╗     ████████╗██╗  ██╗███████╗   |
|   ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝    ╚══██╔══╝██╔═══██╗    ╚══██╔══╝██║  ██║██╔════╝   |
|   ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗         ██║   ██║   ██║       ██║   ███████║█████╗     |
|   ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝         ██║   ██║   ██║       ██║   ██╔══██║██╔══╝     |
|   ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗       ██║   ╚██████╔╝       ██║   ██║  ██║███████╗   |
|    ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝       ╚═╝    ╚═════╝        ╚═╝   ╚═╝  ╚═╝╚══════╝   |
|   ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗         ████████╗██╗   ██╗████████╗ ██████╗ ██████╗    |
|   ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║         ╚══██╔══╝██║   ██║╚══██╔══╝██╔═══██╗██╔══██╗   |
|      ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║            ██║   ██║   ██║   ██║   ██║   ██║██████╔╝   |
|      ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║            ██║   ██║   ██║   ██║   ██║   ██║██╔══██╗   |
|      ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗       ██║   ╚██████╔╝   ██║   ╚██████╔╝██║  ██║   |
|      ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝       ╚═╝    ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═╝   |
+=======================================================================================================================+
EOF


    echo "welcome to the Terminal Tutor!

Here you will be guided through the set-up of each file so you can use them."
  echo "quick note: the mimeinfo.cache file is a good sign things are wokrking properly"
sleep 6
    echo " first, before you can use all of the apps that are made you need to set them up to read the correct file path."
  echo " We will use nano which is an easy to use text editor in the command line. Lets have you edit a file with it."
teach_command() {
  local expected_cmd="nano i-installer.desktop"
  local success_msg="Alright, you got it boss. Lets edit that file."
  local user_cmd

  echo
  echo "Type the following command. Keep in mind that linux is very case sensitive."
  echo "$expected_cmd"
  echo

  read -rp "> " user_cmd

  if [[ "$user_cmd" != "nano i-installer.desktop" ]]; then
    echo "✗ Not quite. Try again."
    teach_command "nano i-installer.desktop" "$success_msg"
    return
  fi

  echo
  echo "✓ Correct!"
  echo "Alright, you got it boss. Lets edit that file."
  echo

  sleep 4

  #Nano text editor will take over from here and this script resumes when you exit
  $expected_cmd

  # continue after nano starts
  echo
  echo "✓ All done! Let's get back to the Terminal Tutor..."

}

teach_command

  echo "Now that you have finished adding the correct file paths, the last few will be left for you to complete on your own.
You can refer to the bash-tools.sh file for guidance.

Note: The terminal_tutor.sh file is hidden. Use ls -la in the terminal to see all the files, or try to locate it in your file explorer."

  echo "Hint: Everything you need is in the tux-labs folder"

  sleep 6



