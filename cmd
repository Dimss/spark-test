# RUN locally
bin/spark-submit \
    --master k8s://https://192.168.64.11:8443 \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=3\
    --conf spark.kubernetes.container.image=dimssss/spark-py:v2.4.3-v2 \
    /tmp/sparkapp1.py

# RUN script from HDFS
bin/spark-submit \
    --master k8s://https://192.168.64.11:8443 \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=3\
    --conf spark.kubernetes.container.image=dimssss/spark-py:v2.4.3-v2 \
    /tmp/sparkapp1.py


    /Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home