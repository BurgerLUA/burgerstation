/obj/structure/interactive/powered
	name = "powered structure"

	var/power_draw = 0
	var/power_supply = 0

	var/obj/structure/interactive/wire/connected_wire

	anchored = TRUE

/obj/structure/interactive/powered/Destroy()
	. = ..()
	if(connected_wire)
		connected_wire.do_snap()

/obj/structure/interactive/powered/post_move(var/atom/old_loc)
	. = ..()
	if(connected_wire)
		connected_wire.do_snap()

/obj/structure/interactive/powered/proc/get_power_draw()
	return 0

/obj/structure/interactive/powered/proc/get_power_supply()
	return 0

/obj/structure/interactive/powered/proc/update_power_draw(var/desired_power_draw,var/reset=FALSE)

	if(!connected_wire)
		power_draw = -1
		CRASH("Tried updating power draw without a connected wire!")

	if(!connected_wire.power_network)
		power_draw = -1
		CRASH("Tried updating power draw without a network!")

	desired_power_draw = max(0,desired_power_draw)

	if(desired_power_draw != power_draw)
		if(!reset) connected_wire.power_network.power_draw -= power_draw
		power_draw = desired_power_draw
		connected_wire.power_network.power_draw += power_draw

	return TRUE

/obj/structure/interactive/powered/proc/update_power_supply(var/desired_power_supply,var/reset=FALSE)

	if(!connected_wire)
		power_draw = -1
		CRASH("Tried updating power supply without a connected wire!")

	if(!connected_wire.power_network)
		power_draw = -1
		CRASH("Tried updating power supply without a network!")

	desired_power_supply = max(0,desired_power_supply)

	if(desired_power_supply != power_supply)
		if(!reset) connected_wire.power_network.power_supply -= power_supply
		power_supply = desired_power_supply
		connected_wire.power_network.power_supply += power_supply

	return TRUE

/obj/structure/interactive/powered/proc/power_process()
	return TRUE