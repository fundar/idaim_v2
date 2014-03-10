IDAIM = ()->

IDAIM.cbs = {}
IDAIM.db = {}

IDAIM.estado = (index)->
	IDAIM.get('estados')[index].n


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
	click = (d)->
		x.domain [d.x, d.x+d.dx]
		newWidth = w/d.dx;

		unless d.children
			x.domain [d.parent.x, d.parent.x+d.parent.dx]
			newWidth = w/d.parent.dx
			depth = d.parent.depth

		newZero = x 0
		newTotal = x 1

		id = d.id.toString().replace(/\D+/, '')
		if id
			clase = d3.select(this).attr('class')
			nombre = IDAIM.get('nombres')[clase][id]
		else
			nombre = "IDAIM"

		g.classed('activo', false)
			.transition()
			.duration(500)
			.attr('transform', transform)
			.select('rect')
				.attr 'width', (d)-> d.dx*newWidth

		d3.select("##{idPara d}").attr 'class', 'activo'

	g = vis.selectAll('g')
		.data(partition.nodes(data))
		.enter().append('svg:g')
			.attr('class', nombreDe)
			.attr('id', idPara)
			.attr('transform', transform)
			.on('click', click)

	g.append('svg:rect')
		.attr('width', (d)-> x(d.dx))
		.attr('height', (d)-> y(d.dy))
		.attr('fill', colorPara)
	
	d3.select('#gn-total-idaim').attr('class', 'activo')
	


IDAIM.indiceNacional = (variable, container)->

	data = []
	for e in variable
		data.push({id: e[0], v:e[1]})

	chart = d3.select(container)
	$container = $(container)
	x = d3.scale.linear()
		.domain([0, 100])
		.range([0, $container.width()]);

	c = chart.selectAll('div').data(data)

	edo = c.enter().append('div')
			.attr('class', 'barra-container')

	label = edo.append('div')
			.attr('class', 'barra-label')
			.text((d)-> IDAIM.estado(d.id))
	bar = edo.append('div')
			.attr('class', 'barra')
			.style('width', (d)-> x(d.v)+"px")
			.style('background-color', (d)-> Color(d.v))


	

IDAIM.get = (file)->
	IDAIM.db[file]

IDAIM.on = (evt, cb)->
	IDAIM.cbs[evt] ||= []
	IDAIM.cbs[evt].push cb

IDAIM.emit = (evt, data)->
	for cb in IDAIM.cbs[evt]
		cb(data);

IDAIM.load = (data)->
	reqs = []
	for index,file of data
		r = $.getJSON "data/#{file}.json"
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
