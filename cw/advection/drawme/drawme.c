// Plot 1D array of doubles.
#include "gnuplot_i/src/gnuplot_i.h"

int DM_plot_1d(double *array_x, double *array_y, unsigned int len, char *title, char screen) {
	gnuplot_ctrl *h;
	h = gnuplot_init();

	// Plot in PNG file.
	if (!screen) {
		gnuplot_cmd(h, "set terminal png");
		// FIXME Now rewrite current image.
		gnuplot_cmd(h, "set output \"result.png\"");
	}
	gnuplot_setstyle(h, "lines");
	gnuplot_cmd(h, "set xrange [-1:1]");
	gnuplot_cmd(h, "set yrange [0:2]");
	gnuplot_set_xlabel(h, "Coordinate, x");
	gnuplot_set_ylabel(h, "Value, u");
	gnuplot_plot_xy(h, array_x, array_y, len, title);
	// FIXME Remove me.
	sleep(2);
	gnuplot_close(h);

	return 0;
}

int DM_plot_1d_etalon(double *array_x, double *array_y, double *array_etalon,
		unsigned int len, char *title, char screen) {
	gnuplot_ctrl *h;
	h = gnuplot_init();

	// Plot in PNG file.
	if (!screen) {
		gnuplot_cmd(h, "set terminal png");
		// FIXME Now rewrite current image.
		gnuplot_cmd(h, "set output \"result.png\"");
	}
	gnuplot_setstyle(h, "lines");
	gnuplot_cmd(h, "set xrange [-1:1]");
	gnuplot_cmd(h, "set yrange [0:2]");
	gnuplot_set_xlabel(h, "Coordinate, x");
	gnuplot_set_ylabel(h, "Value, u");
	gnuplot_cmd(h, "set multiplot");
	gnuplot_plot_xy(h, array_x, array_y, len, title);
	gnuplot_plot_xy(h, array_x, array_etalon, len, "Etalon");
	gnuplot_cmd(h, "unset multiplot");
	// FIXME Remove me.
	sleep(2);
	gnuplot_close(h);

	return 0;
}
