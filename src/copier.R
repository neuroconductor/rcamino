dir.create('../inst/camino', recursive = TRUE)
x = list.dirs(path = 'camino');
sapply(file.path("..", "inst", x),
	dir.create, recursive = TRUE,
	showWarnings = FALSE);
files = list.files(path = 'camino',
	recursive = TRUE);
to = file.path('../inst/camino', files);
file.rename(file.path('camino', files), to);
