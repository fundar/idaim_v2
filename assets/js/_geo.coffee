Geo = ()->
	@callback = null;
	this

Geo.instance = null


Geo.start = ()->
	Geo.instance = new Geo()
	return Geo.instance

Geo::set = (iso)->
	if !iso
		@tryGeoLocation()
	else
		@locationAquired(iso)

Geo::cancelGeolocation = ()->
	true;

Geo::aquired = (evt)->
	r = evt.coords;
	req = $.ajax({
		url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{r.latitude},#{r.longitude}&sensor=false&language=es_mx"
	})

	req.done (d)->
		try
			edo = d.results[d.results.length-2].formatted_address
		catch err
			return alert('No te pude localizar');
		
		estado = false
		candidato = edo.split(',')[0]
		for id, edo of IDAIM.get('estados')
			if edo.n == candidato
				estado = id
				break;

		if estado
			Geo.instance.locationAquired(id)

	@cancelGeolocation = ()->
		req.abort();

	req.fail (a,b)->
		console.log a,b

Geo::denied = (evt)->
	return true;

Geo::tryGeoLocation = ()->
	return unless navigator.geolocation;
	return unless confirm('¿Deseas que te localizemos para mostrar los datos de tu estado?')
	navigator.geolocation.getCurrentPosition @aquired, @denied


Geo::onLocation = (cb)->
	@callback = cb;
	this

Geo::locationAquired = (code)->
	return unless @callback;
	#console.log code
	data = IDAIM.get('estados')[code]
	data['id'] = code;
	#console.log this.callback
	@callback(data)
