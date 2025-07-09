
# Setup git after install or move to new computer

## generate ssh key

 - ssh-keygen -t ed25519 -C "your_email@example.com"
 
 copy the contents 'cat ~/.ssh/id_ed25519.pub' then upload to github profile to add a key. 
 
 git clone repository to download. 


git config --global user.email "you@example.com"
git config --global user.name "Your Name"
