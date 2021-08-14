/obj/structure/interactive/wire/
	name = "power cable"
	icon = 'icons/obj/structure/wire.dmi'
	icon_state = "map"
	var/power_network/power_network
	var/connection_dir = 0x0
	var/list/connections = list() //ASSOC LIST
	var/obj/structure/interactive/powered/connected_machine

/obj/structure/interactive/wire/Destroy()

	for(var/k in connections)
		var/obj/structure/interactive/wire/W = connections[k]
		W.check_new_connections()
	connections.Cut()

	if(power_network)
		power_network.remove_wire(src)
		power_network.remove_machine(connected_machine)
		power_network.update_wires()

	power_network = null
	connected_machine = null

	. = ..()

/obj/structure/interactive/wire/proc/get_all_connections(var/list/existing_list = list())

	for(var/k in connections)
		var/obj/structure/interactive/wire/W = connections[k]
		if(existing_list[W])
			continue
		existing_list |= W.get_all_connections(existing_list)

	return existing_list


/obj/structure/interactive/wire/update_icon()
	. = ..()
	icon = null
	icon_state = null

/obj/structure/interactive/wire/Finalize()
	. = ..()
	check_new_connections()

/obj/structure/interactive/wire/update_overlays()

	. = ..()

	var/initial_icon = initial(icon)

	if(connection_dir in DIRECTIONS_INTERCARDINAL)
		icon = initial_icon
		icon_state = "full"
		dir = connection_dir
	else if(connection_dir in DIRECTIONS_CARDINAL)
		icon = initial_icon
		icon_state = "end"
		dir = connection_dir
	else
		for(var/k in DIRECTIONS_CARDINAL)
			if(!(connection_dir & k))
				continue
			var/image/I = new/image(initial_icon,"full")
			I.dir = k
			add_overlay(I)

/obj/structure/interactive/wire/proc/check_new_connections()

	var/old_connection_dir = connection_dir

	connections.Cut()
	connection_dir = 0x0

	for(var/k in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,k)
		if(!T)
			continue
		var/obj/structure/interactive/wire/W = locate() in T.contents
		if(!W || W.qdeleting)
			continue
		connection_dir |= k
		connections[W] = TRUE
		var/W_old_connection_dir = W.connection_dir
		W.connection_dir |= turn(k,180)
		W.connections[src] = TRUE
		if(W_old_connection_dir != W.connection_dir)
			W.update_sprite()

	if(connection_dir != old_connection_dir)
		update_sprite()
		return TRUE

	return FALSE







