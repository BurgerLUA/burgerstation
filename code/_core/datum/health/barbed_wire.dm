/health/construction/barbed_wire
	var/old_health_number = 0

/health/construction/barbed_wire/update_health()
	. = ..()
	if(!owner)
		return .
	var/health_number = (health_current/health_max)*3
	health_number = CEILING(health_number,1)
	if(old_health_number != health_number)
		owner.icon_state = "[initial(owner.icon_state)]_[health_number]"
		old_health_number = health_number