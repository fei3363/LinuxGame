docker stop $(docker ps -a -q)
docker rm -f $(docker ps -a -q)
for i in {49999..50100}
do
    docker run -d -p $i:22  linuxgame
done