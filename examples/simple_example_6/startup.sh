# This is for ubuntu/debian family

#!/bin/bash

apt update -y
apt install nginx -y
service nginx start

cat << 'EOF' > /var/www/html/index.html
<html> 
  <head>
    <title>HTML E-mail</title>
  </head>
  <body>
    <p style="font-family:verdana;color:red;">
      This text is in Verdana and red
    </p>
  </body>
</html>
EOF