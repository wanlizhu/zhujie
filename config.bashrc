#!/bin/bash
# System
export DISPLAY=:0

# NVIDIA tools
export P4V=$HOME/NVIDIA/P4V
export PIC_V=$HOME/NVIDIA/PIC-V
export PIC_G=$HOME/NVIDIA/PIC-G
export NGFX=$HOME/NVIDIA/NVIDIA-NSIGHT-GRAPHICS
export FLAMEGRAPH=$HOME/NVIDIA/FLAMEGRAPH

# Perforce
export P4USER=wanliz
export P4PASSWD="Xavier#35224047"
export P4ROOT=$HOME/NVIDIA/SRC_ON_P4
export P4PORT=p4proxy-zj.nvidia.com:2006
export P4IGNORE=$HOME/NVIDIA/P4IGNORE
case $(hostname) in
    nvidia-desktop-master)
        export P4CLIENT=nvidia-src-zhujie
    ;;
    nvidia-laptop)
        export P4CLIENT=nvidia-src-zhujie-again
    ;;
    *)
        export P4CLIENT=""
        echo "P4 SRC IS NOT CONFIGURED ON THIS MACHINE"
    ;;
esac
if [ ! -f "$P4IGNORE" ]; then
    echo "_out/" >> "$P4IGNORE"
    echo ".git/" >> "$P4IGNORE" 
    echo ".gitignore" >> "$P4IGNORE"
fi

# NVIDIA Steam account
export STEAM_USER=nvidialinuxteam
export STEAM_PASSWORD=nv1d1a3d

# GTL
export NVM_GTLAPI_USER=wanliz
export NVM_GTLAPI_PASSWORD="Xavier#35224047"
if [ ! -f "$HOME/.gtl_api_key" ]; then
    cp -f $HOME/NVIDIA/GTL_API_KEY ~/.gtl_api_key
    chmod 555 ~/.gtl_api_key
fi

# IP
export IP_ROUTER=""
export IP_NVIDIA=""
export IP_ZEROTIER=""

export PATH="$HOME/NVIDIA/BIN:$FLAMEGRAPH:$P4V/bin:$NGFX/host/linux-desktop-nomad-x64:$P4ROOT/sw/misc/linux:$P4ROOT/sw/automation/dvs/dvsbuild:$P4ROOT/sw/pvt/dleone/bin:$PATH"

for IP in $(ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'); do
    if [[ "$IP" =~ ^192\.168\.192\..* ]]; then
        IP_ZEROTIER=$IP
    elif [[ "$IP" =~ ^192\.168\..* ]]; then
        IP_ROUTER=$IP
    fi
    
    if [[ "$IP" =~ ^10\.19\..* ]]; then
        IP_NVIDIA=$IP
    fi
done

echo "    ROUTER IP: $IP_ROUTER"
echo "    NVIDIA IP: $IP_NVIDIA"
echo " ZERO-TIER IP: $IP_ZEROTIER"


function ddnet-in-pts() {
    # 2560x1440
    # Fullscreen
    # Vulkan
    # Default
    # RaiNyMore2 -- GPU-intensive 
    (echo 7; echo 2; echo 1; echo 1; echo 2; echo n) | phoronix-test-suite benchmark pts/ddnet
}

function talos-principle-in-pts() {
    # Launch steam if it's not currently running
    pgrep -x steam >/dev/null && echo "STEAM IS RUNNING..." || gnome-terminal -- sh -c "steam"
    sleep 15

    if ! [[ -f "$HOME/.steam/steam/steamapps/common/The Talos Principle/Bin/x64/Talos" ]]; then
        echo "INSTALL Talos Principle IN STEAM'S WINDOW AND TRY AGAIN"
        return 1
    fi

    # Vulkan
    # 2560x1440
    (echo 2; echo 7; echo n) | phoronix-test-suite benchmark pts/talos-principle
    
    #~/.steam/steam/steamapps/common/The\ Talos\ Principle/Bin/x64/Talos +gfx_strAPI VLK +gfx_pixResWidth 2560 +gfx_pixResHeight 1440 +exec ~/.phoronix-test-suite/installed-tests/pts/talos-principle-1.2.1/talos-run-test.lua
}
