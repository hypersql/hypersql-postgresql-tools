# Development environment for HyperSQL
  
Requirements
------------
- docker - https://docs.docker.com/engine/install/ubuntu/
- docker-compose - https://docs.docker.com/compose/install/

Container description
---------------------
- u20p11           : Ubuntu20.04 + Postgresql11
- pmm_server       : Percona managenemt and monitoring server
- pmm_client		   : Percona management and monitoring client

How to use
----------
- build and run containers
  - docker-compose up -d
- Access http://127.0.0.1 through web browser
  - initial username/password is admin/admin
  - it might take 30 seconds to connect between server and client
- Execute some SQLs in Postgresql(u20p11 container)
  - docker exec -it u20p11 /bin/bash
  - use psql

