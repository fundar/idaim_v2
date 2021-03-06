IDAIM = ()->

IDAIM.cbs = {}
IDAIM.db = {}

IDAIM.codEstado = (nombre)->
    for index,datum of IDAIM.get('estados')
        return index if nombre == datum.n

IDAIM.estado = (index)->
    IDAIM.get('estados')[index].n

IDAIM.selected = null
IDAIM.mainChart = (dataSet, container, source)->
    # NO JALA RESIZE after click
    container.empty()
    w = container.outerWidth()
    h = if w>500 then 240 else 200
    x = d3.scale.linear().range [0,w]
    y = d3.scale.linear().range [0, h]
    minW = 40

    data = {id: "idaim", children: dataSet}

    vis = d3.select('#'+container.attr('id')).append("div")
            .attr('class', 'chart')
            .style('width', "#{w}px")
            .style('height', '#{h}px')
        .append('svg:svg')
            .attr('width', w)
            .attr('height', h)

    sizes = {}
    for eje in dataSet
        count = 0
        for indicador in eje.children
            count += indicador.children.length
        sizes[eje.id] = 1/3/count*10000

    partition = d3.layout.partition()
                .sort(null)
    partition.nodes(data)
    partition.value (d)-> sizes[d.parent.parent.id]

    nombreDe = (d)->
        tipo = switch d.depth
            when 0 then 'total'
            when 1 then 'eje'
            when 2 then 'indicador'
            when 3 then 'criterio'
        tipo

    valor = (d)->
        id = d.id.toString().replace(/\D+/, '') if d.depth isnt 0
        val = switch d.depth
            when 0 then source.t
            when 1 then source.e[id]
            when 2 then source.i[id]
            when 3 then source.c[id]*100
        val

    colorPara = (d)-> Color(valor d)
    idPara = (d)-> "gn-#{nombreDe(d)}-#{d.id}"
    transform = (d)-> "translate(#{x(d.x)}, #{y(d.y)})"
    click = (d, sepa, resize)->
        resize = resize isnt 0
        IDAIM.selected = {d:d, this:this}
        elem = d3.select(this)
        clase = elem.attr('class')
        return true if clase.match /activo/ and !resize
        clase = clase.replace /\s?activo\s?/, ''
        x.domain [d.x, d.x+d.dx]
        newWidth = w/d.dx;

        unless d.children
            x.domain [d.parent.x, d.parent.x+d.parent.dx]
            newWidth = w/d.parent.dx
            depth = d.parent.depth

        newZero = x 0
        newTotal = x 1

        id = d.id.toString().replace /\D+/, ''

        order = ['total', 'eje', 'indicador', 'criterio']
        if id
            nombre = IDAIM.get('nombres')[clase][id]
            tipo = clase
            tipoParent = order[order.indexOf(clase)-1]
        else
            tipo = 'total'
            id = 'total'
            nombre = "IDAIM"
            tipoParent = null


        parents = []
        current = d
        while current = current.parent
            parents.push({tipo: order[current.depth], id: current.id})


        IDAIM.emit('mainChart.click', {id: id, tipo: tipo, nombre: nombre, valor: elem.attr('valor'), parents: parents })

        el = g.classed('activo', false)
        # KHAAAAAAAAAAAAAAAAAACK
        el = el.transition().duration(500) if !resize

        el.attr('transform', transform)
            .select('rect')
            .attr 'width', (d)-> d.dx*newWidth

        d3.select("##{idPara d}").attr 'class', "#{clase} activo"

    hover = (d)->
        elem = d3.select(this)
        id = d.id.toString().replace /\D+/, ''
        clase = nombreDe(d)
        if id
            nombre = IDAIM.get('nombres')[clase][id]
            tipo = clase
        else
            tipo = 'total'
            id = 'total'
            nombre = "IDAIM"

        IDAIM.emit('mainChart.hover', {id: id, tipo: tipo, nombre: nombre, valor: elem.attr('valor') })

    g = vis.selectAll('g')
        .data(partition.nodes(data))
        .enter().append('svg:g')
            .attr('class', nombreDe)
            .attr('valor', valor)
            .attr('id', idPara)
            .attr('transform', transform)
            .on('click', click)
            .on('mouseover', hover)

    g.append('svg:rect')
        .attr('width', (d)-> x(d.dx))
        .attr('height', (d)-> y(d.dy))
        .attr('fill', colorPara)
    
    d3.select('#gn-total-idaim').attr('class', 'activo')
    click.apply(IDAIM.selected.this, [IDAIM.selected.d, null, true]) if IDAIM.selected

IDAIM.indiceNacional = (variable, container)->
    data = []
    for e in variable
        data.push({id: e[0], v: e[1]/10})

    $container = $(container)
    $container.empty()

    elementos = data.length
    barHeight = 20

    m = {top: 25, right: 15, bottom: 0, left: 120}
    w = $container.width() - (m.right + m.left)
    h = ((barHeight + 1) * elementos)

    cuantosTicks = (w)->
        r = 5
        if w > 400 then r = 10
        if w > 600 then r = 20
        if w > 800 then r = 50
        r

    x = d3.scale.linear()
        .domain([0, 10])
        .range([0, w])

    y = d3.scale.ordinal()
        .domain(data.map((d)->IDAIM.estado(d.id)))
        .rangeRoundBands([0, h])

    ejeX = d3.svg.axis()
        .scale(x)
        .orient("top")

    ejeY = d3.svg.axis()
        .scale(y)
        .orient("left")

    chart = d3.select(container).append('svg')
        .attr("width", w + (m.right + m.left))
        .attr("height", h + (m.top + m.bottom))

    chart.selectAll(".barra")
        .data(data).enter()
        .append("rect")
        .attr("class", "barra")
        .attr("height", barHeight)
        .attr("width", (d)-> x(d.v))
        .attr("x", m.left)
        .attr("y", (d)-> m.top + 1 + y(IDAIM.estado(d.id)))
        .attr("fill", (d)->Color(d.v*10))

    chart.selectAll(".linea")
        .data(x.ticks(cuantosTicks($container.width()))).enter()
        .append("svg:line")
        .attr("class", "linea")
        .attr("x1", (d)-> x(d) + m.left).attr("x2", (d)-> x(d) + m.left)
        .attr("y1", m.top).attr("y2", h + m.top)

    chart.append("g")
      .attr("class", "eje y")
      .attr("transform", "translate("+m.left+"," + m.top + ")")
      .call(ejeY)
      .selectAll('text')
      .on('click', (d)->
        stub = d.toLowerCase().replace(/\s/g, '-')
        id = IDAIM.codEstado(d)
        estado = "/estado/#{id}-#{stub}"
        window.location.href = estado
      )

    chart.selectAll('.tick')
        .attr 'class', (d)-> "tick estado-#{d.toLowerCase()}"

    chart.append("g")
        .attr("class", "eje x")
        .attr("transform", "translate("+m.left+"," + (m.top) + ")")
        .call(ejeX)



    

IDAIM.get = (file)->
    IDAIM.db[file]

IDAIM.on = (evt, cb)->
    IDAIM.cbs[evt] ||= []
    IDAIM.cbs[evt].push cb

IDAIM.emit = (evt, data)->
    for cb in IDAIM.cbs[evt]
        cb(data);

IDAIM.load = (data, callback)->

    if typeof data is 'string'
        callback(IDAIM.db[data]) if IDAIM.db[data]
        r = $.getJSON "/data/#{data}.json"
        r.done (response)->
            IDAIM.db[data] = response;
            callback(response);
    else
        reqs = []
        for index,file of data
            continue if IDAIM.db[file]
            r = $.getJSON "/data/#{file}.json"
            done = (file)->
                f = file
                return (data)->
                    IDAIM.db[f]=data
            r.done done(file)
            reqs.push r



        load = $.when.apply $, reqs
        ready = ()->
            IDAIM.emit 'ready'
        error = (e,c,d)->
            console.log e,c,d
        load.then ready, error
