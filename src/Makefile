all:
	unzip camino.zip;
	cd camino && make clean && make;
	cd camino && ls;
	cd ../ && ls;
	# mkdir -p ../bin;
	cp -R camino/* ../inst/camino/;
	# pwd;
	

clean:
	rm -rf ./camino;
	# rm -rf ../inst/*;
