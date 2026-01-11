
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

## Working with ACSM Files on Linux

I acquire books from various OverDrive instances. OverDrive provides an ACSM file, which is not a book, but instead an XML ticket meant to be exchanged for the actual book file – similar to requesting a book in meatspace by turning in a catalog card to a librarian. Adobe Digital Editions is used to perform this exchange. As one would expect from Adobe, this software does not support Linux.

Back in 2013 I setup a Windows 7 virtual machine with Adobe Digital Editions v2.0.1.78765, which I used exclusively for turning ACSM files into EPUB files. A few months ago I was finally able to retire that VM thanks to the discovery of libgourou, which is both a library and a suite of utilities that can be used to work with ACSM files.

To use, I first register an anonymous account with Adobe.

$ adept_activate -a

Next I export the private key that the files will be encrypted to.

$ acsmdownloader --export-private-key

This key can then be imported into the DeDRM_tools plugin of Calibre.

Whenever I receive an ACSM file, I can just pass it to the acsmdownloader utility from libgourou.

$ acsmdownloader -f foobar.acsm

This spits out the EPUB, which may be imported into my standard Calibre library.

To remove the Drm use "adept_remove -f <encryptedfile>"
