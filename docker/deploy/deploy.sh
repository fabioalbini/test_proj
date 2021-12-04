echo "$EC2_SSH_KEY" > ~/.ec2/deploy.pem
chmod 400 ~/.ec2/deploy.pem
bundle exec cap staging deploy
