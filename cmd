# RUN locally
bin/spark-submit \
    --master k8s://https://192.168.64.11:8443 \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=3\
    --conf spark.kubernetes.container.image=dimssss/spark-py:v2.4.3-v2 \
    /tmp/sparkapp1.py


bin/spark-submit \
    --master k8s://https://ocp-local:8443 \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=1\
    --conf spark.kubernetes.namespace=nemo \
    --conf spark.dynamicAllocation.initialExecutors=1 \
    --conf spark.dynamicAllocation.enabled=true \
    --conf spark.shuffle.service.enabled=true \
    --conf spark.kubernetes.node.selector.test=hw \
    --conf spark.kubernetes.shuffle.namespace=nemo \
    --conf spark.kubernetes.shuffle.labels="app=spark-shuffle" \
    --conf spark.kubernetes.container.image=dimssss/spark-py:v2.4.3-v2 \
    /tmp/sparkapp1.py


bin/spark-submit \
    --master k8s://https://ocp-local:8443 \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=3 \
    --conf spark.kubernetes.container.image=dimssss/spark-py:v2.4.3-v2 \
    /tmp/sparkapp1.py



# RUN script from HDFS
bin/spark-submit \
    --master k8s://https://192.168.64.11:8443 \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=3\
    --conf spark.kubernetes.container.image=dimssss/spark-py:v2.4.3-v2 \
    --conf spark.kubernetes.driverEnv.HADOOP_USER_NAME=dima \
    /tmp/sparkapp1.py




bin/spark-submit \
    --master k8s://https://192.168.64.11:8443 \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=3\
    --conf spark.kubernetes.container.image=docker.io/dimssss/spark-py:v2.4.3-v3 \
    /tmp/sparkapp2.py


bin/spark-submit \
    --master k8s://https://ocp-local:8443 \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=3\
    --conf spark.kubernetes.container.image=docker.io/dimssss/spark-py:v2.4.3-v3 \
    https://raw.githubusercontent.com/Dimss/spark-test/master/sparkapp1.py



    /Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home