function rebuild
    set retp (pwd)
    cd /etc/nixos
    sudo nixos-rebuild switch
    cd $retp
end