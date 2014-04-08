// require _jquery
// require _d3

var container = '#graficaEstado';

$(container).empty();

var m = {t: 1, r: 1, b: 1, l: 1},
	wC = $(container).width(),
	w = wC - (m.r + m.l),
	h = (w/4)
	s = w / 28,
	filas = 7;

if (w < 480) {
	h = w;
	s = w / 14;
	filas = 14;
}

var hC = h + (m.t + m.b);

var g = d3.select(container).append('svg')
	.attr("width", wC)
	.attr("height", hC);

var xSquare = function(indice) {
	return Math.floor(indice/filas);
};

var ySquare = function(indice) {
	return indice % filas;
}

var polygonPath = function(eje) {
	var inicio = eje[0],
		fin = eje[1];

	var path = "";

	path += "M" + (xSquare(inicio) * s + m.l) + "," + (ySquare(inicio) * s + m.t);

	if (xSquare(fin) > xSquare(inicio)) {
		path += "V" + (filas * s + m.t);
	} else {
		path += "V" + (ySquare(fin) * s + s + m.t);
	}

	if (ySquare(fin) != (filas - 1)) {
		path += "H" + (xSquare(fin) * s + m.l);
		path += "V" + (ySquare(fin) * s + s + m.t);
	}

	path += "H" + (xSquare(fin) * s + s + m.l);

	if (xSquare(fin) > xSquare(inicio)) {
		path += "V" + m.t;
	} else {
		path += "V" + (ySquare(inicio) * s + m.t);
	}

	if (ySquare(inicio) != 0) {
		path += "H" + (xSquare(inicio) * s + s + m.l);
		path += "V" + (ySquare(inicio) * s + m.t);
	}

	path += "Z";

	return path;
}

var generaPoligonos = function(clase, datos) {
	return g.selectAll("."+clase).data(datos)
	.enter().append("path")
	.attr('class', clase)
	.attr('d', polygonPath);
}

var data = d3.range(0, 196);

var criterios = g.selectAll(".criterio")
	.data(data)
	.enter().append("rect")
	.attr('class', 'criterio')
	.attr('width', s)
	.attr('height', s)
	.attr('x', function(d) { return xSquare(d) * s + m.l})
	.attr('y', function(d) { return ySquare(d) * s + m.t});

var indicadores = generaPoligonos('indicador', 
	[[0, 12], [13, 24], [25, 31], [32,40], [41,44], [45,55], [56,62]]);
var ejes = generaPoligonos('eje', [[0, 62], [63, 116], [117, 195]]);