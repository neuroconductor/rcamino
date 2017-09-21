all:
	unzip -o camino.zip;
	cd camino && make clean && make;
	# cd camino && ls;
	# cd ../ && ls;
	mkdir -p ../inst/camino/;
	# mkdir -p ../bin;
	cp -R camino/* ../inst/camino/ ;
	# cp -R camino/bin/* ../inst/camino/bin/ ;
	# pwd;


clean:
	rm -rf ./camino;
	# rm -rf ../inst/*;
