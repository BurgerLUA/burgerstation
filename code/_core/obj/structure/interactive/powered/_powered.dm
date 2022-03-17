/obj/structure/interactive/powered
	name = "powered structure"

	var/power_draw = 0
	var/power_supply = 0

	var/obj/structure/interactive/wire/connected_wire

	anchored = TRUE

	var/wire_powered = FALSE //Set to true to disable this being powered by APCs but instead wires.

	var/powered = FALSE //Whether or not this object is currently powered.

/obj/structure/interactive/powered/Destroy()

	if(!wire_powered && isturf(loc))
		var/area/A = loc.loc
		if(A && A.requires_power)
			update_power_draw(0)
			A.powered_machines -= src

	if(connected_wire)
		connected_wire.do_snap()

	. = ..()

/obj/structure/interactive/powered/Finalize()

	if(!wire_powered && isturf(loc))
		var/area/A = loc.loc
		if(A && A.requires_power)
			A.powered_machines |= src

	. = ..()

/obj/structure/interactive/powered/post_move(var/atom/old_loc)
	. = ..()
	if(connected_wire)
		connected_wire.do_snap()
	if(!wire_powered)
		if(isturf(old_loc))
			var/area/A = old_loc.loc
			if(A.requires_power)
				update_power_draw(0)
				A.powered_machines -= src
		if(isturf(loc))
			var/area/A = loc.loc
			if(A.requires_power)
				A.powered_machines |= src

/obj/structure/interactive/powered/proc/get_power_draw()
	return 0

/obj/structure/interactive/powered/proc/get_power_supply()
	return 0

/obj/structure/interactive/powered/proc/update_power_draw(var/desired_power_draw,var/reset=FALSE)

	var/area/A = null

	if(wire_powered)
		if(!connected_wire)
			power_draw = -1
			CRASH("Tried updating power draw without a connected wire!")

		if(!connected_wire.power_network)
			power_draw = -1
			CRASH("Tried updating power draw without a network!")
	else
		A = get_area(src)
		if(!A.apc)
			power_draw = -1
			CRASH("Tried updating power draw without a connected APC!")

	desired_power_draw = max(0,desired_power_draw)

	if(desired_power_draw != power_draw)
		if(wire_powered)
			if(!reset) connected_wire.power_network.power_draw -= power_draw
			power_draw = desired_power_draw
			connected_wire.power_network.power_draw += power_draw
		else
			if(!reset) A.power_draw -= power_draw
			power_draw = desired_power_draw
			A.power_draw += power_draw

	return TRUE

/obj/structure/interactive/powered/proc/update_power_supply(var/desired_power_supply,var/reset=FALSE)

	if(!wire_powered)
		power_supply = -1
		CRASH("Tried updating power supply of something that isn't wire powered!")

	if(!connected_wire)
		power_supply = -1
		CRASH("Tried updating power supply without a connected wire!")

	if(!connected_wire.power_network)
		power_supply = -1
		CRASH("Tried updating power supply without a network!")

	desired_power_supply = max(0,desired_power_supply)

	if(desired_power_supply != power_supply)
		if(!reset) connected_wire.power_network.power_supply -= power_supply
		power_supply = desired_power_supply
		connected_wire.power_network.power_supply += power_supply

	return TRUE

/obj/structure/interactive/powered/proc/power_process(var/power_multiplier=1)
	return TRUE