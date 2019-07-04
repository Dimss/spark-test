# SPARK on OCP

The goal of this POC is to learn, estimate and tests Spark application on OCP.

### The Stack 
- OCP 3.9
- Spark 2.4.3 
- Python 3

### Prerequisite
- OCP cluster
- Spark container image for particular language, in this case Python 3
- Spark 2.4.3

#### Prepare OCP cluster
```bash
# Create new project for running Spark apps 
oc new-project spark
``` 

```bash
# Check if any limits are configured by default for the spark project  
oc get limits
# Delete any defined limits (for POC there is no need to limit CPU/Memory of workers pods) 
oc delete limits limits
```    

```bash
# To keep things simple for a POC, allow executing Spark application with anyuid policy   

```

```bash
# Create service account for executing Spark apps, as of POC use clusterAdmin
apiVersion: authorization.openshift.io/v1
kind: ClusterRoleBinding
metadata:
  name: spark-default-sa-nemo
roleRef:
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: default
  namespace: spark
```

### Create spark docker image
```bash
cd /path/to/your/spark/installation
./bin/docker-image-tool.sh -r docker.io/dimssss -t 0.1  build
```

### Run your spark app on OCP
```bash
# Run without dynamic allocation
cd /path/to/your/spark/installation 
bin/spark-submit \
    --master k8s://${OCP-API-URL} \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.executor.instances=3 \
    --conf spark.kubernetes.container.image=dimssss/spark-py:v2.4.3-v2 \
    /tmp/sparkapp1.py

```  

```bash
# Run with dynamic allocation
cd /path/to/your/spark/installation 
bin/spark-submit \
    --master k8s://${OCP-API-URL} \
    --deploy-mode cluster \
    --name spark-k8s-test \
    --conf spark.kubernetes.namespace=nemo \
    --conf spark.dynamicAllocation.initialExecutors=1 \
    --conf spark.dynamicAllocation.enabled=true \
    --conf spark.shuffle.service.enabled=true \
    --conf spark.kubernetes.node.selector.test=hw \
    --conf spark.kubernetes.shuffle.namespace=nemo \
    --conf spark.kubernetes.shuffle.labels="app=spark-shuffle" \
    --conf spark.kubernetes.container.image=dimssss/spark-py:v2.4.3-v2 \
    /tmp/sparkapp1.py
```  
  





