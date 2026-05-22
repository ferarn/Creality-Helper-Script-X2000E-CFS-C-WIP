#!/bin/sh

set -e

function check_folder_k1c() {
  local folder_path="$1"
  if [ -d "$folder_path" ]; then
    echo -e "${green}✓"
  else
    echo -e "${red}✗"
  fi
}

function check_file_k1c() {
  local file_path="$1"
  if [ -f "$file_path" ]; then
    echo -e "${green}✓"
  else
    echo -e "${red}✗"
  fi
}

function check_any_file_k1c() {
  local file_path
  for file_path in "$@"; do
    if [ -f "$file_path" ]; then
      echo -e "${green}вњ“"
      return
    fi
  done
  echo -e "${red}вњ—"
}

function check_simplyprint_k1c() {
  if [ ! -f "$MOONRAKER_CFG" ]; then
    echo -e "${red}✗"
  elif grep -q "\[simplyprint\]" "$MOONRAKER_CFG"; then
    echo -e "${green}✓"
  else
    echo -e "${red}✗"
  fi
}

function info_menu_ui_k1c() {
  top_line
  title '[ INFORMATION MENU ]' "${yellow}"
  inner_line
  hr
  subtitle '•ESSENTIALS:'
  info_line "$(check_folder_k1c "$MOONRAKER_FOLDER")" 'Moonraker & Nginx'
  info_line "$(check_folder_k1c "$FLUIDD_FOLDER")" 'Fluidd'
  info_line "$(check_folder_k1c "$MAINSAIL_FOLDER")" 'Mainsail'
  hr
  subtitle '•UTILITIES:'
  info_line "$(check_file_k1c "$ENTWARE_FILE")" 'Entware'
  info_line "$(check_file_k1c "$KLIPPER_SHELL_FILE")" 'Klipper Gcode Shell Command'
  hr
  subtitle '•IMPROVEMENTS:'
  info_line "$(check_folder_k1c "$KAMP_FOLDER")" 'Klipper Adaptive Meshing & Purging'
  info_line "$(check_file_k1c "$BUZZER_FILE")" 'Buzzer Support'
  info_line "$(check_folder_k1c "$NOZZLE_CLEANING_FOLDER")" 'Nozzle Cleaning Fan Control'
  info_line "$(check_file_k1c "$FAN_CONTROLS_FILE")" 'Fans Control Macros' 
  info_line "$(check_folder_k1c "$IMP_SHAPERS_FOLDER")" 'Improved Shapers Calibrations'
  info_line "$(check_file_k1c "$USEFUL_MACROS_FILE")" 'Useful Macros'
  info_line "$(check_file_k1c "$SAVE_ZOFFSET_FILE")" 'Save Z-Offset Macros'
  info_line "$(check_file_k1c "$SCREWS_ADJUST_FILE")" 'Screws Tilt Adjust Support'
  info_line "$(check_file_k1c "$M600_SUPPORT_FILE")" 'M600 Support'
  info_line "$(check_file_k1c "$GIT_BACKUP_FILE")" 'Git Backup'
  hr
  subtitle '•CAMERA:'
  info_line "$(check_file_k1c "$TIMELAPSE_FILE")" 'Moonraker Timelapse'
  info_line "$(check_file_k1c "$CAMERA_SETTINGS_FILE")" 'Camera Settings Control'
  info_line "$(check_any_file_k1c "$USB_CAMERA_FILE" "$USB_CAMERA_LEGACY_FILE")" 'USB Camera Support'
  info_line "$(check_any_file_k1c "$BUILTIN_CAMERA_FILE" "$BUILTIN_CAMERA_LEGACY_FILE")" 'Built-in Camera Fix'
  hr
  subtitle '•REMOTE ACCESS:'
  info_line "$(check_folder_k1c "$OCTOEVERYWHERE_FOLDER")" 'OctoEverywhere'
  info_line "$(check_folder_k1c "$MOONRAKER_OBICO_FOLDER")" 'Obico'
  info_line "$(check_folder_k1c "$GUPPYFLO_FOLDER")" 'GuppyFLO'
  info_line "$(check_folder_k1c "$MOBILERAKER_COMPANION_FOLDER")" 'Mobileraker Companion'
  info_line "$(check_folder_k1c "$OCTOAPP_COMPANION_FOLDER")" 'OctoApp Companion'
  info_line "$(check_simplyprint_k1c)" 'SimplyPrint'
  hr
  subtitle '•CUSTOMIZATION:'
  info_line "$(check_file_k1c "$FLUIDD_LOGO_FILE")" 'Creality Dynamic Logos for Fluidd'
  hr
  inner_line
  hr
  bottom_menu_option 'b' 'Back to [Main Menu]' "${yellow}"
  bottom_menu_option 'q' 'Exit' "${darkred}"
  hr
  version_line "$(get_script_version)"
  bottom_line
}

function info_menu_k1c() {
  clear
  info_menu_ui_k1c
  local info_menu_opt
  while true; do
    read -p " ${white}Type your choice and validate with Enter: ${yellow}" info_menu_opt
    case "${info_menu_opt}" in
      B|b)
        clear; main_menu; break;;
      Q|q)
         clear; exit 0;;
      *)
        error_msg "Please select a correct choice!";;
    esac
  done
  info_menu_k1c
}
