
{% from "couchpotato/map.jinja" import couchpotato with context %}

include:
  - couchpotato.package
  - python.set_version27

# start the couchpotato process
couchpotato:
  service.running:
    - enable: True
    - name: {{ couchpotato.service }}
    - require:
      - file: couchpotato_service_file
      - sls: couchpotato.package
      - sls: python.set_version27
    - watch:
      - file: couchpotato_service_config

# create the couchpotato service config file (default data to run the service)
couchpotato_service_config:
  file.managed:
    - name: {{ couchpotato.service_config }}
    - source: {{ couchpotato.service_config_src }} 
    - template: jinja
    - require:
      - git: couchpotato-git

# create the service init file, load data from the service config file
couchpotato_service_file:
  file.managed:
    - name: {{ couchpotato.service_file }}
    - source: {{ couchpotato.service_file_src }} 
    - template: jinja
    - require:
      - file: couchpotato_service_config
      - git: couchpotato-git