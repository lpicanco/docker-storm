# Storm 1.0.1 docker image #

### How to Use ###

Create a docker-compose.yml file
```yaml
zookeeper:
  image: 'jplock/zookeeper:latest'
  ports:
    - '2181:2181'
    - '2888:2888'
    - '3888:3888'
nimbus:
  image: lpicanco/storm-nimbus
  ports:
    - "3773:3773"
    - "3772:3772"
    - "6627:6627"
  links:
    - zookeeper:zk
supervisor:
  image: lpicanco/storm-supervisor
  ports:
    - "8000:8000"
  links:
    - nimbus:nimbus
    - zookeeper:zk
ui:
  image: lpicanco/storm-ui
  ports:
    - "8080:8080"
  links:
    - nimbus:nimbus
    - zookeeper:zk
```

Execute
```shellscript
docker-compose up -d
```
