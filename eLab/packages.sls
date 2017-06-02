{% from "eLab-API-formula/eLab/map.jinja" import eLab with context %}

#
# Install useful packages
#
eLab_packages:
  pkg.installed:
    - pkgs: {{ eLab.pkgs|json }}

#
# Once pip is installed get the pip related pkgs 
#
Install pip packages:
  pip.installed:
    - names:
      - MySQL-python
      - django >= 1.10
      - djangorestframework
      - passlib
      - boto3
    - require:
      - pkg: eLab_packages

