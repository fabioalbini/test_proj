# echo "$EC2_SSH_KEY2"
echo "$EC2_SSH_KEY2" > ~/.ec2/deploy.pem
# echo "RESPONSE"
# cat ~/.ec2/test.pem
# echo "$EC2_SSH_KEY" > ~/.ec2/deploy.pem
chmod 400 ~/.ec2/deploy.pem
bundle exec cap staging deploy
