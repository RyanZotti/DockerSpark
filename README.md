## Instructions

Get all of the dependencies. I have saved all of these in my own S3 bucket in case the people that originally made them stop supporting them.

	# Get Java 8, required by Spark
	wget https://s3.amazonaws.com/self-driving-car/spark-dependencies/jdk-8u111-linux-x64.tar.gz
	
	# Get Spark
	wget https://s3.amazonaws.com/self-driving-car/spark-dependencies/spark-1.6.1-bin-hadoop2.6.tgz
	
	# Get H2O's sparkling water. I have no idea why AWS made me specify no certificate check to download
	wget --no-check-certificate https://s3.amazonaws.com/self-driving-car/spark-dependencies/sparkling-water-1.6.1.zip

Steps to run on a Mac:

	# Start the master
	docker run --name spark_master -p 8080:8080 -p 7077:7077 -p 4040:4040 -p 6066:6066 -d ryanzotti:spark /prod/spark-1.6.1-bin-hadoop2.6/sbin/start-master.sh
	
	# Start the worker. Note: you need the master IP
	# Get master IP using: docker inspect <container_id>
	docker run --name spark_worker -p 8081:8081 -d ryanzotti:spark /prod/spark-1.6.1-bin-hadoop2.6/sbin/start-slave.sh spark://172.17.0.2:7077
	
Useful Docker commands:

	# Build an image
	docker build -t ryanzotti:spark .
	
	# Get container ID associated with name
	docker ps -aqf "name=spark_master"
	
	# Get IP associated with container
	docker inspect <container_id>
	