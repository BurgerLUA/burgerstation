/obj/structure/interactive/powered
	name = "powered structure"

	var/power_draw = 0
	var/power_supply = 0

	var/power_network/power_network


/obj/structure/interactive/powered/proc/get_power_draw()
	return 0

/obj/structure/interactive/powered/proc/get_power_supply()
	return 0

/obj/structure/interactive/powered/proc/update_power_draw(var/desired_power_draw)

	if(!power_network)
		power_draw = 0
		return FALSE

	desired_power_draw = max(0,desired_power_draw)

	if(desired_power_draw != power_draw)
		power_network.power_draw -= power_draw
		power_draw = desired_power_draw
		power_network.power_draw += power_draw

	return TRUE

/obj/structure/interactive/powered/proc/update_power_supply(var/desired_power_supply)

	if(!power_network)
		power_supply = 0
		return FALSE

	desired_power_supply = max(0,desired_power_supply)

	if(desired_power_supply != power_supply)
		power_network.power_supply -= power_supply
		power_supply = desired_power_supply
		power_network.power_supply += power_supply

	return TRUE
