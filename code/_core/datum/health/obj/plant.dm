/health/plant
	organic = TRUE


/health/plant/update_health()
	. = ..()

	if(!owner)
		return .

	if(health_current <= 0 && owner.can_do_destruction())
		owner.on_destruction()