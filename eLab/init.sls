{% from "eLab-API-formula/eLab/map.jinja" import eLab with context %}
{% set mysql_root_password = eLab.mysql.server.root_password %}
{% set api_secret_key = eLab.api.secret_key %}

include:
  - eLab-API-formula.eLab.packages
{% if grains['environment'] == 'develop' %}
  - eLab-API-formula.eLab.mysql
{% endif %}

#
# Clone git repo create data directory and copy web content
#
clone repo:
  git.latest:
    - name: {{ grains['eLab_API']['REPO'] }} 
    - rev: {{ grains['eLab_API']['BRANCH'] }}
    - target: /opt/eLab-API-Source
    #- name: https://github.com/ml6973/eLab-API-Source.git 

/opt/eLab-API-Source/elabapi/settings.py:
  file.managed:
    - template: jinja
    - source: salt://eLab-API-formula/files/api_settings.py

#execute API non mod_wsgi:
#  cmd.run:
#    - name: tmux new -d -s API_SERVER 'python manage.py runserver 0.0.0.0:12345'
#    - cwd: /opt/eLab-API-Source

collect API static for mod_wsgi:
  cmd.run:
    - name: echo 'yes' | python manage.py collectstatic
    - cwd: /opt/eLab-API-Source

allow apache user access to project directory:
  cmd.run:
    - name: chown :www-data /opt/eLab-API-Source 

#This config will invoke mod_wsgi for the API
/etc/apache2/sites-available/000-default.conf:
  file.managed:
    - source: salt://eLab-API-formula/files/000-default.conf

#service apache2 restart:
#  cmd.run

#
# Restart apache2 and make sure it is running
#
apache2:
  service.running:
    - restart: True
