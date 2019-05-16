from pyspark import SparkConf, SparkContext
from operator import add

# logFile = "/tmp/README.md"
app_name = "start-test-app1"
master = "spark://efk-poc.europe-north1-a.c.dimitry-218810.internal:7077"
master = "spark://dimasmac:7077"
master = "spark://35.228.12.205:7077"
conf = SparkConf().setAppName(app_name).setMaster(master).set('spark.cores.max', '1').set("spark.executor.memory", '1g').set("spark.driver.memory",'1g')
sc = SparkContext(conf=conf)
data = sc.parallelize(list("Hello World"))
counts = data.map(lambda x: (x, 1)).reduceByKey(add).sortBy(lambda x: x[1], ascending=False).collect()
for (word, count) in counts:
    print("{}: {}".format(word, count))
sc.stop()
