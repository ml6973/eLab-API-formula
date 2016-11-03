Elgg Formula

Install/Setup SaltStack

Run SaltStack installation

.. code-block::

  $ sudo add-apt-repository ppa:saltstack/salt

  $ sudo apt-get update

  $ apt-get install salt-api salt-cloud salt-master salt-minion salt-ssh salt-syndic
  
  $ mkdir /srv/salt

  $ mkdir /srv/pillar


Create /srv/salt/top.sls

.. code-block:: yaml

  base:
    '*elgg*':
      - elgg-formula.elgg

Create /srv/pillar/top.sls

.. code-block:: yaml

  base:
    '*elgg*':
      - elgg



