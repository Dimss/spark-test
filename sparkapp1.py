#!/usr/bin/python
from pyspark import SparkConf, SparkContext, SQLContext
from pyspark.sql import SparkSession

from operator import add

app_name = "start-test-app1"
conf = SparkConf().setAppName(app_name)
sc = SparkContext()
sqlContext = SQLContext(sc)
data = sc.parallelize(list("Hello World"))
counts = data.map(lambda x: (x, 1)).reduceByKey(add).sortBy(lambda x: x[1], ascending=False).collect()
df = sqlContext.createDataFrame(counts)
# Save DataFrame into HDFS
df.write.mode("append").format("json").save("hdfs://172.20.10.5:9000/user/root/res10.json")
df.show()
print("========= Loaded from HDFS =============")
# Load DataFrame from HDFS
sparkSession = SparkSession.builder.appName("example-pyspark-read-and-write").getOrCreate()
df_load = sparkSession.read.json('hdfs://172.20.10.5:9000/user/root/res10.json')
df_load.show()
sc.stop()
