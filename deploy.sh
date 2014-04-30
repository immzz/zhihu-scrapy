sudo apt-get update
sudo apt-get install python
sudo apt-get install build-essential python-dev
sudo apt-get install aptitude
sudo aptitude install xvfb
sudo aptitude install x11-xkb-utils
sudo aptitude install xserver-xorg-core
sudo aptitude install xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
#wget http://download.redis.io/redis-stable.tar.gz
#tar xvzf redis-stable.tar.gz
#cd redis-stable
#make
sudo apt-get install redis-server
sudo apt-get install python-lxml
cd ..
sudo apt-get install python-pip
sudo pip install -r requirements.txt


wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable


wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/2.9/chromedriver_linux64.zip && sudo unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/
sudo chmod 777 /usr/local/bin/chromedriver

mkdir log
