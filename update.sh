# cd in
cd /home/n3rdium/.dotfiles || exit

# Sync repo
git pull || true
git add .
git commit || true
git push || true

# (optional) Update & rebuild

echo -p "Update? (y/N) "
read x
if [ $(x) == "y" ]; then
    sudo nix flake update
fi

sudo nixos-rebuild switch --flake .#n3rdium --upgrade

