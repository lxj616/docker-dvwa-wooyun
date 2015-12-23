FROM tutum/lamp:latest
MAINTAINER lxj616 <502307678@qq.com>

ENV DEBIAN_FRONTEND noninteractive

# Preparation
RUN \
  rm -fr /app/* && \
  apt-get update && apt-get install -yqq wget git unzip && \
  rm -rf /var/lib/apt/lists/* && \
  git clone https://github.com/lxj616/DVWA-WooYun && \
  rm -rf app/* && \
  cp -r /DVWA-WooYun/* /app && \
  rm -rf /DVWA-WooYun && \
  sed -i "s/^\$_DVWA\[ 'db_user' \] = 'root'/\$_DVWA[ 'db_user' ] = 'admin'/g" /app/config/config.inc.php && \
  echo "sed -i \"s/p@ssw0rd/\$PASS/g\" /app/config/config.inc.php" >> /create_mysql_admin_user.sh  && \
  echo 'session.save_path = "/tmp"' >> /etc/php5/apache2/php.ini 

EXPOSE 80 3306
CMD ["/run.sh"]
