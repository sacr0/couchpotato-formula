{% from "couchpotato/map.jinja" import couchpotato with context %}

include:
  - couchpotato

couchpotato_hdtorrents_base:
  file.managed:
    - name: {{ couchpotato.homedir }}couchpotato/core/media/_base/providers/torrent/hdtorrents.py
    - source: salt://couchpotato/files/hdtorrents/base_hdtorrents.py.jinja
    - template: jinja
    - watch_in:
      - service: couchpotato
    #- user: {{ couchpotato.user }}
    #- group: {{ couchpotato.group }}
    #- mode: 777

couchpotato_hdtorrents_movie:
  file.managed:
    - name: {{ couchpotato.homedir }}couchpotato/core/media/movie/providers/torrent/hdtorrents.py
    - source: salt://couchpotato/files/hdtorrents/movie_hdtorrents.py
    - watch_in:
      - service: couchpotato
    #- user: {{ couchpotato.user }}
    #- group: {{ couchpotato.group }}
    #- mode: 777