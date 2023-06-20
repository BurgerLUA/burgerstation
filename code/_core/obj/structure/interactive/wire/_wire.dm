/obj/structure/interactive/wire/
	name = "power cable"
	icon = 'icons/obj/structure/wire.dmi'
	icon_state = "map"
	var/power_network/power_network
	var/connection_dir = 0x0
	var/list/connections = list() //ASSOC LIST
	var/obj/structure/interactive/connected_machine

	layer = LAYER_FLOOR_PIPE
	under_tile = TRUE
	plane = PLANE_AREA-1 //Layered above stuff in maps. Plane is properly set in New()

	initialize_type = INITIALIZE_LATE

	color = COLOR_WHITE

	alpha = 100

/obj/structure/interactive/wire/New(var/desired_loc)
	. = ..()
	var/wire_count = 0
	for(var/obj/structure/interactive/wire/W in src.loc.contents)
		if(W.color != src.color)
			continue
		wire_count++

	if(wire_count > 1)
		log_error("Multiple wire cables ([wire_count]) detected at [src.loc.get_debug_name()].")
		qdel(src)

	plane = PLANE_WIRE

	alpha = 255

/obj/structure/interactive/wire/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","It is connected to [length(connections)] other wire(s).")
	if(connected_machine)
		. += div("notice","It is connected to \the [connected_machine].")

/obj/structure/interactive/wire/proc/find_wire_connection(var/mob/caller)

	if(connected_machine)
		caller?.to_chat(span("warning","\The [src.name] is already connected to \a [connected_machine.name]! Remove it first before adding a new connection."))
		return FALSE

	var/obj/structure/interactive/found_machine
	for(var/obj/structure/interactive/P in src.loc.contents)
		if(!P.wire_powered)
			continue
		found_machine = P
		break

	if(!found_machine)
		caller?.to_chat(span("warning","There is nothing to connect \the [src.name] to!"))
		return FALSE

	connected_machine = found_machine
	connected_machine.connected_wire = src

	caller?.to_chat(span("notice","You connect \the [src.name] to \the [connected_machine.name]."))

	if(power_network) power_network.add_wire(src) //This acts as an update.

	update_sprite()

	return TRUE

/obj/structure/interactive/wire/proc/do_snap()
	src.visible_message(span("danger","\The [src.name] snaps!"))
	qdel(src)

/obj/structure/interactive/wire/PreDestroy()

	if(power_network)
		qdel(power_network)
		power_network = null

	for(var/k in connections)
		var/obj/structure/interactive/wire/W = k
		W.generate_4way()
		W.refresh_network()

	. = ..()

/obj/structure/interactive/wire/Destroy()
	. = ..()
	connections.Cut()

/obj/structure/interactive/wire/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			INTERACT_CHECK
			INTERACT_DELAY(10)
			qdel(src)
			return TRUE
		if(I.flags_tool & FLAG_TOOL_MULTITOOL)
			INTERACT_CHECK
			INTERACT_DELAY(10)
			if(power_network)
				caller.to_chat(span("notice","Network ID: \ref[power_network]."))
				caller.to_chat(span("notice","Supply: [power_network.power_supply]w."))
				caller.to_chat(span("notice","Draw: [power_network.power_draw]w."))
			else
				caller.to_chat(span("warning","No power network detected!"))
			return TRUE

	. = ..()


/obj/structure/interactive/wire/proc/refresh_network()

	if(!power_network)
		CRASH("refresh_network() not find a valid power network!")

	var/list/found_connections = get_new_connections()

	for(var/k in found_connections)
		var/obj/structure/interactive/wire/W = k
		power_network.add_wire(W)

/obj/structure/interactive/wire/proc/get_new_connections(var/list/existing_list)

	if(!existing_list)
		existing_list = list()

	existing_list[src] = TRUE

	for(var/k in connections) //Connections is an ASSOC list. wire = TRUE
		if(existing_list[k])
			continue
		var/obj/structure/interactive/wire/W = k
		if(!W || W.qdeleting)
			connections -= k
			continue
		existing_list |= W.get_new_connections(existing_list)

	return existing_list


/obj/structure/interactive/wire/update_icon()
	. = ..()
	icon = null
	icon_state = null

/obj/structure/interactive/wire/Initialize()
	. = ..()
	find_wire_connection()

/obj/structure/interactive/wire/PostInitialize()
	. = ..()
	generate_4way()

/obj/structure/interactive/wire/update_overlays()

	. = ..()

	var/initial_icon = initial(icon)

	if(connection_dir in DIRECTIONS_CARDINAL)
		icon = initial_icon
		icon_state = "[connection_dir]"
	else if(connection_dir == 0x0)
		icon = initial_icon
		icon_state = "none"
	else
		for(var/k in DIRECTIONS_CARDINAL)
			if(!(connection_dir & k))
				continue
			var/image/I = new/image(initial_icon,"[k]")
			add_overlay(I)

	if(connected_machine)
		var/image/I = new/image(initial_icon,"connection")
		add_overlay(I)

/obj/structure/interactive/wire/proc/generate_4way()

	var/old_connection_dir = connection_dir

	connections.Cut()
	connection_dir = 0x0

	var/list/possible_power_networks = list()

	for(var/k in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,k)
		if(!T)
			continue
		var/obj/structure/interactive/wire/found_wire
		for(var/obj/structure/interactive/wire/W in T.contents)
			if(W.qdeleting)
				continue
			if(W.color != src.color)
				continue
			found_wire = W
			break
		if(!found_wire)
			continue
		if(found_wire.power_network)
			possible_power_networks |= found_wire.power_network
		connection_dir |= k
		connections[found_wire] = TRUE
		var/found_wire_old_connection_dir = found_wire.connection_dir
		found_wire.connection_dir |= turn(k,180)
		found_wire.connections[src] = TRUE
		if(found_wire_old_connection_dir != found_wire.connection_dir)
			found_wire.update_sprite()

	merge_networks(possible_power_networks)

	if(connection_dir != old_connection_dir)
		update_sprite()
		return TRUE

	return FALSE


/obj/structure/interactive/wire/proc/merge_networks(var/list/possible_power_networks)

	var/power_network/best_network
	for(var/k in possible_power_networks)
		var/power_network/PN = k
		if(!PN || PN.qdeleting)
			continue
		if(!best_network || PN.id < best_network.id)
			best_network = PN

	if(best_network)
		best_network.add_wire(src)
		for(var/k in possible_power_networks) //Transfer the reset of the wires.
			if(k == best_network)
				continue
			var/power_network/PN = k
			for(var/j in PN.connected_wires)
				best_network.add_wire(j)
			qdel(PN)
	else
		power_network = new /power_network/
		power_network.add_wire(src)

/obj/structure/interactive/wire/red
	color = "#FF0000"

/obj/structure/interactive/wire/yellow
	color = "#FFFF00"

/obj/structure/interactive/wire/green
	color = "#00FF00"



