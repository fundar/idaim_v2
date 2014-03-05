IDAIM = ()->

IDAIM.cbs = {}
IDAIM.db = {}

IDAIM.estado = (index)->
	IDAIM.get('estados')[index].n

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
