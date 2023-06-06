kafka-topics --bootstrap-server kafka:9094 --list

kafka-topics --create --bootstrap-server kafka:9094 --replication-factor 1 --partitions 1 --topic user-mgmt-notification
kafka-topics --bootstrap-server kafka:9094 --describe --topic user-mgmt-notification

docker rm $(docker ps -q -f 'status=exited')
docker rmi $(docker images -q -f "dangling=true")