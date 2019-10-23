all:
	"${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e "utils::unzip('camino.zip')";
	rm -rf __MACOSX/;
	cd camino && make clean && make;
	"${R_HOME}/bin${R_ARCH_BIN}/Rscript" copier.R

clean:
	"${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e "unlink('camino', recursive = TRUE, force = TRUE)"
