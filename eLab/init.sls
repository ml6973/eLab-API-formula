{% set mysql_root_password = salt['pillar.get']('mysql:server:root_password', salt['grains.get']('server_id')) %}


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
      - python-pip
      - python-dev
      - libmysqlclient-dev
      - mysql-server

#
# Once pip is installed get the pip related pkgs 
#
MySQL-python:
  pip.installed:
    - require:
      - pkg: eLab_packages

<<<<<<< HEAD
django:
  pip.installed:
    - name: django >= 1.10
    - require:
      - pkg: eLab_packages

djangorestframework:
  pip.installed:
    - require:
      - pkg: eLab_packages

passlib:  
  pip.installed:
    - require:
      - pkg: eLab_packages

#
# Restart apache2 and make sure it is running
#
apache2:
  service.running:
    - restart: True

{% if salt['grains.get']('mysql_password_updated') != True %}
set mysql password:
  cmd.run:
    - name: mysqladmin -u root password {{ mysql_root_password }}
  grains.present:
    - name: mysql_password_updated
    - value: True
{% endif %}

mysql -uroot -p{{ mysql_root_password }}:
  cmd.run

#
# Clone git repo create data directory and copy web content
#
clone repo:
  git.latest:
    - name: https://github.com/ml6973/eLab-API-Source.git 
    - target: /opt/eLab-API-Source
    - rev: master

/opt/eLab-API-Source/elabapi/settings.py:
  file.managed:
    - template: jinja
    - source: salt://eLab-API-formula/files/api_settings.py

execute API:
  cmd.run:
    - name: tmux new -d -s API_SERVER 'python manage.py runserver 0.0.0.0:12345'
    - cwd: /opt/eLab-API-Source

#/etc/apache2/sites-available/000-default.conf:
#  file.managed:
#    - source: salt://eLab-portal-formula/files/000-default.conf

#/etc/php5/apache2/php.ini:
#  file.managed:
#    - source: salt://eLab-portal-formula/files/php.ini
#    - template: jinja

service apache2 restart:
  cmd.run
