/health/blob/
	armor = /armor/blob

/health/blob/update_health()
	. = ..()
	if(!owner)
		return .
	if(health_current <= 0)
		owner.on_destruction()