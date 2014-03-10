
$(document).ready(function(){
  dibuja();
});

function dibuja() {

  var container = $('#graph-total').empty();

  var w = container.outerWidth(),
      h = (w > 500)? 240 : 200,
      x = d3.scale.linear().range([0, w]),
      y = d3.scale.linear().range([0, h]),
      minW = 40;

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

    var g = vis.selectAll("g")
      .data(partition.nodes(root))
      .enter().append("svg:g")
      .attr("id", function(d){return 'gn-'+d.id})
      .attr("transform", function(d) {
        return "translate("+x(d.x)+","+y(d.y)+")";
      })
      .on("click", click);

    g.append("svg:rect")
      .attr("width", function(d) {return x(d.dx);})
      .attr("height", function(d) {return y(d.dy);})
      .attr("fill", color);

    d3.select('#gn-idaim').attr('class','activo');

    // g.append("svg:text")
    //   .attr("transform", function(d) {
    //     return "translate("+x(d.dx)/2+","+(y(d.dy) / 2 + 6)+")";
    //   })
    //   .attr("width", function(d) {return x(d.dx);})
    //   .style("opacity", function(d) {return (d.dx * w) < minW ? 0 : 1;})
    //   .text(function(d) {return d.id;});

    function click(d) {
      x.domain([d.x, d.x + d.dx]);

      var newWidth = w / d.dx;
      
      if (!d.children) {
        x.domain([d.parent.x, d.parent.x + d.parent.dx]);
        newWidth = w / d.parent.dx;
        depth = d.parent.depth
      }

      var newZero = x(0);
      var newTot = x(1);

      g.classed('activo', false)
        .transition()
        .duration(500)
        .attr("transform", function(d) {
          return "translate("+x(d.x)+","+y(d.y)+")";
        })
        .select("rect")
        .attr("width", function(d){ return d.dx * newWidth;});

      d3.select('#gn-'+d.id).attr('class', 'activo');

      // g.select("text")
      //   .transition()
      //   .duration(500)
      //   .attr("transform", function(d) {
      //     pos = (d.dx * newWidth)/2;

      //     check = (
      //       (d.dx*newWidth > w) && 
      //       (((x(d.x) + d.dx * newWidth) > 0) && (x(d.x) < w))
      //     );

      //     if (check) {
      //       pos = w/2 - x(d.x);
      //     }
      //     return "translate("+pos+","+(y(d.dy) / 2 + 6)+")";
      //   })
      //   .style("opacity", function(d) {
      //     return (d.dx * newWidth) < minW ? 0 : 1;
      //   })
      
      
    }
  });

}

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

var debounce = function(fn, timeout) {
  var timeoutID = -1;
  return function() {
    if (timeoutID > -1) {
      window.clearTimeout(timeoutID);
    }
    timeoutID = window.setTimeout(fn, timeout);
  }
};

var debounce_dibuja = debounce(dibuja, 250);

$(window).resize(debounce_dibuja);