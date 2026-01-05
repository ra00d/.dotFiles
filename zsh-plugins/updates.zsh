pkgupdates() {
    echo "Checking for updates..."
    updates=$(pacman -Qu | awk '{print $1}')

    if [[ -z "$updates" ]]; then
        echo "Your system is up to date!"
        return
    fi

    printf "\n%-30s %-15s\n" "Package" "Download Size"
    printf "%-30s %-15s\n" "-------" "-------------"

    total=0

    for pkg in $updates; do
        info=$(pacman -Si "$pkg" 2>/dev/null)

        # Skip if pacman -Si cannot find the package in repos
        if [[ -z "$info" ]]; then
            printf "%-30s %-15s\n" "$pkg" "N/A"
            continue
        fi

        size=$(echo "$info" | awk '/Download Size/ {print $4, $5}')
        printf "%-30s %-15s\n" "$pkg" "$size"

        value=$(echo "$size" | awk '{print $1}')
        unit=$(echo "$size" | awk '{print $2}')

        # Skip if size missing
        if [[ -z "$value" || -z "$unit" ]]; then
            continue
        fi

        case "$unit" in
            KiB) mult=1 ;;
            MiB) mult=1024 ;;
            GiB) mult=$((1024*1024)) ;;
            *)   mult=1 ;;
        esac

        total=$(echo "$total + ($value * $mult)" | bc)
    done

    total_mib=$(echo "scale=2; $total / 1024" | bc)
    echo -e "\nTotal Download Size: ${total_mib} MiB"
}

