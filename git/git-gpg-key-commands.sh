######################################################################

gpg --gen-key
### Kind of key:    RSA and RSA (default)
### Keysize:        4096
### Expire:         <PERIOD>
### Real name:      <USER_NAME>
### Email address:  <USER_EMAIL>
### Okay

gpg --list-key
gpg --armor --export "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

######################################################################

git config --global user.name "USER_NAME"
git config --global user.email "USER_EMAIL"
git config --global user.signingkey "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
git config --global commit.gpgsign true
git config --global gpg.program gpg
# git config --global gpg.program $(which gpg)

######################################################################

git config user.name "USER_NAME"
git config user.email "USER_EMAIL"
git config user.signingkey "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
git config commit.gpgsign true
git config gpg.program gpg
# git config gpg.program $(which gpg)
