FROM python:3.7.3-alpine3.9
RUN pip3.7 install pyspark
CMD ["/bin/ash"]

