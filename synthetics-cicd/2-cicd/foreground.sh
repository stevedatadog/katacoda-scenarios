echo "Greetings from foreground.sh"
statuscheck dependencies
statuscheck environment

git config --global credential.helper 'store --file /root/git-credentials'