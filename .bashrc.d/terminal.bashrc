function jcd_color_test()
{
    # Control Sequence Introducer (CSI) bytes.
    local csi="$(printf '\e[')"

    # Select Graphics Rendition (SGR) functions.
    local text_foreground="${csi}38;5;%dm"
    local text_background="${csi}48;5;%dm"
    local reset="${csi}0m"

    # Specific function calls.
    local text_foreground_white="$(printf "${text_foreground}" "231")"
    local text_foreground_black="$(printf "${text_foreground}" "232")"

    for i in {0..255}
    do
        local text_background_i="$(printf "${text_background}" "${i}")"
        printf "${text_background_i}${text_foreground_white}%03d ${text_foreground_black}%03d${reset}" "${i}" "${i}"
        printf " "

        if ((( i < 16 )) && (( i % 8 == 7 ))) || ((( i > 15 )) && (( (i-15) % 6 == 0 )))
        then
            printf "\n";
        fi
    done
}
