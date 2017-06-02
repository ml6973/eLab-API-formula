{% from "eLab-API-formula/eLab/map.jinja" import eLab with context %}
{% set mysql_root_password = eLab.mysql.server.root_password %}

MySQL_packages:
  pkg:
    - installed
    - pkgs:
      - libmysqlclient-dev
      - mysql-server
      - python-pip

MySQL-python:
  pip.installed:
    - require:
      - pkg: MySQL_packages

#
# Copy sql backup template, set mysql password and update the database
#
/root/eLab_backup.sql:
  file.managed:
    - source: salt://eLab-API-formula/files/elab_api_ss.sql
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


echo "CREATE DATABASE IF NOT EXISTS {{ eLab.mysql.server.name }}" | mysql -uroot -p{{ mysql_root_password }}:
  cmd.run


mysql -uroot -p{{ mysql_root_password }} --database={{ eLab.mysql.server.name }} < /root/eLab_backup.sql:
  cmd.run
