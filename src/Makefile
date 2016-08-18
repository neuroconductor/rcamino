all:
	unzip camino.zip;
	cd camino && make;
	cd camino/bin && ls;
	cd ../inst/bin && ls;
	cp -R camino/bin/trd ../inst/bin/

clean:
	rm -rf ./camino;
	# rm -rf ../inst/*;
