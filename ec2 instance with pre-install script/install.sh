#! /bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>The page was created by the user data</h2>" | sudo tee /var/www/html/index.html
