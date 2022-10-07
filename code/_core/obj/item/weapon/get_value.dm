// https://www.desmos.com/calculator/eqoor2rovm


/obj/item/weapon/proc/get_recommended_value(var/armor_to_use=0)

	var/reliability = get_reliability()

	var/kill_time = get_kill_time(armor_to_use)
	var/kill_time_mod = ((5-min(kill_time,5)*reliability)**5)*0.4

	var/stopping_power = get_stopping_power(armor_to_use)
	var/stopping_power_mod = (stopping_power**1.2)*1000

	var/dps = get_dps(get_damage_per_hit(armor_to_use))
	var/dps_mod = (dps**1.3)*1.1

	. = ( (kill_time_mod + stopping_power_mod + dps_mod)*reliability )**1.04

	switch(.)
		if(0 to 100)
			return CEILING(.,1)
		if(100 to 1000)
			return CEILING(.,10)
		if(1000 to 10000)
			return CEILING(.,100)
		if(10000 to INFINITY)
			return CEILING(.,1000)