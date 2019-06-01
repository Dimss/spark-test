#!/usr/bin/python
from pyspark import SparkConf, SparkContext
from operator import add

app_name = "start-test-app1"
conf = SparkConf().setAppName(app_name)
sc = SparkContext()
data = sc.parallelize(list("Hello World"))
counts = data.map(lambda x: (x, 1)).reduceByKey(add).sortBy(lambda x: x[1], ascending=False).collect()
for (word, count) in counts:
    print("{}: {}".format(word, count))
sc.stop()
