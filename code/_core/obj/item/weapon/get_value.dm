// https://www.desmos.com/calculator/ndpqhe7kfe


/obj/item/weapon/proc/get_recommended_value(var/armor_to_use=0)

	var/reliability = min(1,get_reliability())

	var/kill_time = clamp(get_kill_time(armor_to_use),0,5) //Prevents absurd values.
	var/kill_time_mod = ((5-min(kill_time*reliability,5))**5)*0.25

	var/stopping_power = get_stopping_power(armor_to_use)
	var/stopping_power_mod = ((reliability*stopping_power)**1.25)*1000

	var/dps = get_dps(get_damage_per_hit(armor_to_use)*reliability)
	var/dps_mod = (dps**1.75)*0.1

	if(kill_time_mod < 0)
		log_error("Value Calcuation Error: kill_time_mod was negative! ([kill_time_mod])")
		return 1

	if(stopping_power_mod < 0)
		log_error("Value Calcuation Error: stopping_power_mod was negative! ([stopping_power_mod])")
		return 1

	if(dps_mod < 0)
		log_error("Value Calcuation Error: dps_mod was negative! ([dps_mod])")
		return 1

	. = ( (kill_time_mod + stopping_power_mod + dps_mod)*0.2 )**1.2

	switch(.)
		if(0 to 100)
			return CEILING(.,1)
		if(100 to 1000)
			return CEILING(.,10)
		if(1000 to 10000)
			return CEILING(.,100)
		if(10000 to INFINITY)
			return CEILING(.,1000)

/obj/item/weapon/ranged/get_recommended_value(var/armor_to_use=0)
	. = ..() ** 1.1
	return  CEILING(.,20)

