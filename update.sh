# cd in
cd /home/n3rdium/.dotfiles || exit

# Sync repo
git pull || true
git add .
git commit || true
git push || true

# Update & rebuild
sudo nix flake update
sudo nixos-rebuild switch --flake .#n3rdium --upgrade

