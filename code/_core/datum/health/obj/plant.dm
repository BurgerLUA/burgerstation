/health/plant
	organic = TRUE


/health/plant/update_health()
	. = ..()

	if(!owner)
		return .

	if(health_current <= 0)
		owner.on_destruction()