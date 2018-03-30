all:
	Rscript -e "utils::unzip('camino.zip')";
	cd camino && make clean && make;
	Rscript copier.R

clean:
	Rscript -e "unlink('camino', recursive = TRUE, force = TRUE)"
