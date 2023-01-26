// https://www.desmos.com/calculator/k6xteaoff3


/obj/item/weapon/proc/get_recommended_value(var/debug=FALSE)

	var/reliability = min(1,0.25 + get_reliability())

	if(debug) log_debug("reliability: [reliability]")

	var/kill_time_mod = get_kill_time(0)*0.2 + get_kill_time(100)*0.3 + get_kill_time(200)*0.5
	kill_time_mod = ((3 - min(reliability*kill_time_mod,3))**4)*24 //Scales from 1944 to 0 (0 to 3)

	if(debug) log_debug("kill_time_mod: [kill_time_mod]")

	var/stopping_power = get_stopping_power(0)*0.2 + get_stopping_power(100)*0.3 + get_stopping_power(200)*0.5
	var/stopping_power_mod = ((reliability*stopping_power)**1.3)*1000

	if(debug) log_debug("stopping_power_mod: [stopping_power_mod]")

	var/dps = get_dps(get_damage_per_hit(0))*0.2 + get_dps(get_damage_per_hit(100))*0.3 + get_dps(get_damage_per_hit(200))*0.5
	var/dps_mod = ((reliability*dps)**1.6)*0.25

	if(debug) log_debug("dps_mod: [dps_mod]")

	if(kill_time_mod < 0)
		log_error("Value Calcuation Error: kill_time_mod for [src.type] was negative! ([kill_time_mod])")
		return 1

	if(stopping_power_mod < 0)
		log_error("Value Calcuation Error: stopping_power_mod for [src.type] was negative! ([stopping_power_mod])")
		return 1

	if(dps_mod < 0)
		log_error("Value Calcuation Error: dps_mod for [src.type] was negative! ([dps_mod])")
		return 1

	. = 0.2 * (dps_mod + stopping_power_mod + kill_time_mod)**1.2

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
