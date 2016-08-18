all:
	unzip camino.zip;
	cd camino && make;
	cd camino/bin && ls;
	mkdir -p ../bin;
	cp camino/bin/* ../bin/

clean:
	rm -rf ./camino;
	# rm -rf ../inst/*;
