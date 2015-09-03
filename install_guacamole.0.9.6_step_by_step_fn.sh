###install guacamole 9.6 step by step 
## install guacamole server

//install server
sudo apt-get install libcairo2-dev libpng12-dev libossp-uuid-dev libfreerdp-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev libvorbis-dev 
cd ~
wget http://ncu.dl.sourceforge.net/project/guacamole/current/source/guacamole-server-0.9.6.tar.gz
tar -xzf guacamole-server-0.9.6.tar.gz
cd guacamole-server-0.9.6/
./configure --with-init-dir=/etc/init.d
make
sudo make install 

sudo ldconfig

//install client

sudo apt-get install tomcat7

 wget http://ncu.dl.sourceforge.net/project/guacamole/current/binary/guacamole-0.9.6.war
 sudo mkdir -p /usr/share/tomcat7/.guacamole
 sudo mkdir -p /etc/guacamole
 cd /etc/guacamole
 sudo vim user-mapping.xml
 <<EOF
 <user-mapping>
	
    <!-- Per-user authentication and config information -->
    <authorize username="USERNAME" password="PASSWORD">
        <protocol>vnc</protocol>
        <param name="hostname">localhost</param>
        <param name="port">5900</param>
        <param name="password">VNCPASS</param>
    </authorize>

</user-mapping>
EOF
sudo vim guacamole.properties
<<EOF
# Hostname and port of guacamole proxy
guacd-hostname: localhost
guacd-port:     4822

# Auth provider class (authenticates user/pass combination, needed if using the provided login screen)
auth-provider: net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider
basic-user-mapping: /etc/guacamole/user-mapping.xml
EOF

 sudo mkdir -p /var/lib/guacamole/
 sudo cp guacamole-0.9.6.war /var/lib/guacamole/ 
 sudo ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat7/.guacamole/
 sudo ln -s /var/lib/guacamole/guacamole.war /var/lib/tomcat7/webapps


