if [ -z "$NIMBUS_PORT_6627_TCP_ADDR" ]; then
  export NIMBUS_PORT_6627_TCP_ADDR=`hostname -i`;
fi

sed -i -e "s/%zookeeper%/$ZK_PORT_2181_TCP_ADDR/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$NIMBUS_PORT_6627_TCP_ADDR/g" $STORM_HOME/conf/storm.yaml

echo "storm.local.hostname: $NIMBUS_PORT_6627_TCP_ADDR" >> $STORM_HOME/conf/storm.yaml

/usr/sbin/sshd && supervisord
