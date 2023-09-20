function terminal_color_test()
{
    for i in {0..255}
    do
        printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"

        if ((( i < 16 )) && (( i % 8 == 7 ))) || ((( i > 15 )) && (( (i-15) % 6 == 0 )))
        then
            printf "\n";
        fi
    done
}
