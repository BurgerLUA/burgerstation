/obj/item/weapon/proc/get_recommended_value(var/debug=FALSE)

	var/reliability = min(1,0.25 + get_reliability())

	if(debug) log_debug("reliability: [reliability]")

	var/kill_time_mod = get_kill_time(0)*0.2 + get_kill_time(100)*0.3 + get_kill_time(200)*0.5
	kill_time_mod = (1 + (1.9 / (0.1+kill_time_mod))) * 50

	if(debug) log_debug("kill_time_mod: [kill_time_mod]")

	var/stopping_power = get_stopping_power(0)*0.2 + get_stopping_power(100)*0.3 + get_stopping_power(200)*0.5
	var/stopping_power_mod = ((reliability*stopping_power)**1.1)*1000

	if(debug) log_debug("stopping_power_mod: [stopping_power_mod]")

	var/dps = get_dps(get_damage_per_hit(0))*0.2 + get_dps(get_damage_per_hit(100))*0.3 + get_dps(get_damage_per_hit(200))*0.5
	var/dps_mod = ((reliability*dps)**1.6)*0.25

	if(debug) log_debug("dps_mod: [dps_mod]")

	var/bullet_mod = 0
	var/found_bullet = SSbalance.weapon_to_bullet[src.type]
	if(found_bullet)
		var/found_bullet_value = SSbalance.stored_value[found_bullet]
		if(found_bullet_value)
			//A weapon that fires 10 2-credit rounds a second should cost 800 credits.
			//2 => 80
			//Magic number: 40.
			bullet_mod = (found_bullet_value*get_hits_per_second())*40
	else if(is_ranged_weapon(src))
		bullet_mod = dps_mod*3.5

	if(debug) log_debug("bullet_mod: [bullet_mod].")

	if(kill_time_mod < 0)
		log_error("Value Calcuation Error: kill_time_mod for [src.type] was negative! ([kill_time_mod])")
		return 1

	if(stopping_power_mod < 0)
		log_error("Value Calcuation Error: stopping_power_mod for [src.type] was negative! ([stopping_power_mod])")
		return 1

	if(dps_mod < 0)
		log_error("Value Calcuation Error: dps_mod for [src.type] was negative! ([dps_mod])")
		return 1

	. = recommended_value_mod * 0.2 * (dps_mod + stopping_power_mod + kill_time_mod + bullet_mod)**1.2



	if(debug) log_debug("final calculation: [.]")

	switch(.)
		if(0 to 100)
			return CEILING(.,1)
		if(100 to 1000)
			return CEILING(.,10)
		if(1000 to 10000)
			return CEILING(.,100)
		if(10000 to INFINITY)
			return CEILING(.,1000)
