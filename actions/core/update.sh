#!/usr/bin/env bash

core_update ()
{
    ascii

    cd "$CORE_DIR"

    local remote_version=$(git rev-parse origin/master)
    local local_version=$(git rev-parse HEAD)

    if [[ "$remote_version" == "$local_version" ]]; then
        STATUS_CORE_UPDATE="No"

        info "You already have the latest ARK Core version that we support."
    else
        STATUS_CORE_UPDATE="Yes"

        read -p "An update is available for ARK Core, do you want to install it? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            forger_stop
            relay_stop

            heading "Starting Update..."
            git reset --hard >> "$commander_config"
            git pull >> "$commander_config"
            success "Update OK!"

            STATUS_CORE_UPDATE="No"
        fi
    fi
}
