
var w = 1024,
    h = 240,
    x = d3.scale.linear().range([0, w]),
    y = d3.scale.linear().range([0, h]);

var vis = d3.select("#graph-total").append("div")
    .attr("class", "chart")
    .style("width", w + "px")
    .style("height", h + "px")
  .append("svg:svg")
    .attr("width", w)
    .attr("height", h);

var partition = d3.layout.partition()
    .value(function(d) { return d.size; })
    .sort(null);

d3.json("data/estructura.json", function(root) {
  var rect = vis.selectAll("rect")
    .data(partition.nodes(root))
    .enter().append("svg:rect")
    .attr("x", function(d) { return x(d.x); })
    .attr("y", function(d) { return y(d.y); })
    .attr("width", function(d) { return x(d.dx); })
    .attr("height", function(d) { return y(d.dy); })
    .attr("class", function(d){return d.class})
    .attr("id", function(d){return d.id})
    .attr("fill", color)
    .on("click", click);

  $('#idaim').addClass('activo');

  function color(d) {
    var col, set;
    // var val = d.calificacion;
    var val = Math.round(Math.random() * 100);
    var colores = [['73161A', '8B1B1F', 'A31F25', 'BB242A', 'D3282F'], ['E87321', 'ED861E', 'F3981A', 'F8AB17', 'FDBD13'], ['8AC65A', '81BD47', '78B434', '6FAA20', '66A10D']];

    if (val <= 59) {
      set = colores[0];
    } else if (val < 80 && val > 59) {
      set = colores[1];
    } else {
      set = colores[2];
    }
    col = '#' + set[Math.round((set.length - 1) * val / 100)];
    return col;
  };

  function click(d) {
    if (!d.children) {
      x.domain([d.parent.x, d.parent.x + d.parent.dx]);
    } else {
      x.domain([d.x, d.x + d.dx]);
    }

    rect.classed('activo', false)
      .transition()
      .duration(750)
      .attr("x", function(d) { return x(d.x); })
      .attr("width", function(d) { return x(d.x + d.dx) - x(d.x); })
    
    $(this).addClass('activo');
  }
});
