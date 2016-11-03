{% set mysql_root_password = salt['pillar.get']('mysql:server:root_password', salt['grains.get']('server_id')) %}
{% set smtp_server = salt['pillar.get']('smtp:server', salt['grains.get']('server_id')) %}
{% set smtp_port = salt['pillar.get']('smtp:port', salt['grains.get']('server_id')) %}
{% set smtp_username = salt['pillar.get']('smtp:username', salt['grains.get']('server_id')) %}
{% set smtp_password = salt['pillar.get']('smtp:password', salt['grains.get']('server_id')) %}
{% set elgg_plugins = salt['pillar.get']('elgg:plugins', salt['grains.get']('server_id')) %}


#
# Install useful packages
#
eLab_packages:
  pkg:
    - installed
    - pkgs:
      - apache2 
      - git 
      - vim 
      - curl 
      - tmux 
      - mysql-server
      - php5 
      - php5-mysql
      - php5-curl
      - python-pip
      - python-dev
      - libmysqlclient-dev
#
# Once pip is installed get the pip related pkgs 
#
MySQL-python:
  pip.installed:
    - require:
      - pkg: eLab_packages

requests:
  pip.installed:
    - require:
      - pkg: eLab_packages

#
# Restart apache2 and make sure it is running
#
apache2:
  service.running:
    - restart: True
    - watch:
      - file: /etc/php5/apache2/php.ini

#
# Enable mod_rewrite for eLab
#
Apache mod_rewrite:
  apache_module.enable:
    - name: rewrite

#
# Copy sql backup template, set mysql password and update the database
#
/root/eLab_backup.sql:
  file.managed:
    - source: salt://eLab-portal-formula/files/elab_ss.sql
    - user: root
    - group: root
    - mode: 644
    - template: jinja

{% if salt['grains.get']('mysql_password_updated') != True %}
set mysql password:
  cmd.run:
    - name: mysqladmin -u root password {{ mysql_root_password }}
  grains.present:
    - name: mysql_password_updated
    - value: True
{% endif %}

mysql -uroot -p{{ mysql_root_password }} < /root/eLab_backup.sql:
  cmd.run

#
# Clone git repo create data directory and copy web content
#
clone repo:
  git.latest:
    - name: https://github.com/ml6973/eLab-GUI-web-portal.git 
    - target: /opt/eLab-GUI-web-portal
    - rev: master

/opt/eLab-data:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True

/var/www/html/eLab-GUI-web-portal:
  file.directory:
    - makedirs: True

copy web content:
  cmd.run:
    - name: cp -rf /opt/eLab-GUI-web-portal/WebContent/. /var/www/html/eLab-GUI-web-portal/
  file.directory:
    - name: /var/www/html/eLab-GUI-web-portal
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/var/www/myConfig.ini:
  file.managed:
    - source: salt://eLab-portal-formula/files/myConfig.ini

/etc/apache2/sites-available/000-default.conf:
  file.managed:
    - source: salt://eLab-portal-formula/files/000-default.conf

/etc/php5/apache2/php.ini:
  file.managed:
    - source: salt://eLab-portal-formula/files/php.ini
    - template: jinja

service apache2 restart:
  cmd.run
