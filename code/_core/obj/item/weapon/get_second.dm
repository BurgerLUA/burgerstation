/obj/item/weapon/proc/get_hits_per_second()

	if(!damage_type)
		log_error("Warning: [src.type] did not have a valid damage_type.")
		return 0

	var/damagetype/D = all_damage_types[damage_type]
	if(!D)
		log_error("Warning: [src.type] did not have a valid damage_type.")
		return 0

	return 10/D.attack_delay


/obj/item/weapon/ranged/get_hits_per_second()

	if("burst" in firemodes)
		var/local_burst_delay = burst_delay ? burst_delay : shoot_delay*max_bursts*1.25
		. = max_bursts*(10/local_burst_delay)

	if("automatic" in firemodes)
		var/possible = (10/shoot_delay)
		if(possible > .)
			. = possible

	if("semi-automatic" in firemodes)
		var/possible = (10/max(1,shoot_delay))
		if(possible > .)
			. = possible

/obj/item/weapon/ranged/bullet/get_hits_per_second()
	. = ..()
	if(bullet_count_max > 0)
		. = min(bullet_count_max,.)


/obj/item/weapon/ranged/bullet/pump/get_hits_per_second()

	if("burst" in firemodes)
		var/local_burst_delay = burst_delay ? burst_delay : ((pump_delay*2)+shoot_delay)*max_bursts*1.25
		. = max_bursts*(10/local_burst_delay)

	if("automatic" in firemodes)
		var/possible = (10/((pump_delay*2)+shoot_delay))
		if(possible > .)
			. = possible

	if("semi-automatic" in firemodes)
		var/possible = (10/((pump_delay*2)+max(1,shoot_delay)))
		if(possible > .)
			. = possible

	if(bullet_count_max > 0)
		. = min(bullet_count_max,.)