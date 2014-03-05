IDAIM = ()->

IDAIM.cbs = {}
IDAIM.db = {}

IDAIM.estado = (index)->
	IDAIM.get('estados')[index].n


IDAIM.mainChart = (dataSet, container)->
	console.log(dataSet.e);
	#d3.select()

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
