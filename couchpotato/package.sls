include:
  # external formula
  - git

{% from "couchpotato/map.jinja" import couchpotato with context %}

# create couchpotato user
couchpotato_user:
  user.present:
    - name: {{ couchpotato.user }}
    - createhome: False
    - shell: /bin/false

# create directory to store the application
couchpotato_homedir:
  file.directory:
    - name: {{ couchpotato.homedir }}
    - user: {{ couchpotato.user }}
    - group: {{ couchpotato.group }}
    - require:
      - user: couchpotato_user

# create directory to store the pid file
couchpotato_piddir:
  file.directory:
    - name: {{ couchpotato.piddir }}
    - user: {{ couchpotato.user }}
    - group: {{ couchpotato.group }}
    - require:
      - user: couchpotato_user

couchpotato-git:
  git.latest:
    - name: {{ couchpotato.git }}
    - target: {{ couchpotato.homedir }}
    - user: {{ couchpotato.user }}
    - require:
      - file: couchpotato_homedir
      - pkg: git

couchpotato_packages:
  pkg.installed:
    - pkgs:
      {%- for pkg in couchpotato.pkgs %}
      - {{ pkg }}
      {%- endfor %}

#create folders for the app to use for database and configuration
couchpotato_datadir:
  file.directory:
    - name: {{ couchpotato.datadir }}
    - mode: 777

couchpotato_configdir:
  file.directory:
    - name: {{ couchpotato.configdir }}
    - mode: 777