export JAVA_HOME=$(alternatives --display java_sdk_openjdk | grep "link" | awk '{ print $NF }')
