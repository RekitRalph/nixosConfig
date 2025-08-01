
# Setup git after install or move to new computer

## generate ssh key

 - ssh-keygen -t ed25519 -C "your_email@example.com"
 
 copy the contents 'cat ~/.ssh/id_ed25519.pub' then upload to github profile to add a key. 
 
 git clone repository to download. 


git config --global user.email "you@example.com"
git config --global user.name "Your Name"

## List generations:

sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

Compare the last gen (number) to current. ./result is current generation:

nvd diff /nix/var/nix/profiles/system-###-link ./result

## Collect garabage:

'sudo nix-collect-garbage -d (delete old) -d' deletes everything leaving only current gen

'sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +3' # delete old gen except last 3

'nix-store --optimise'
