/obj/structure/interactive/wire/
	name = "power cable"
	icon = 'icons/obj/structure/wire.dmi'
	icon_state = "map"
	var/power_network/power_network
	var/connection_dir = 0x0
	var/list/connections = list() //ASSOC LIST
	var/obj/structure/interactive/powered/connected_machine

	initialize_type = INITIALIZE_LATE

	color = COLOR_WHITE

/obj/structure/interactive/wire/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","It is connected to [length(connections)] other wire(s).")
	if(connected_machine)
		. += div("notice","It is connected to \the [connected_machine].")

/obj/structure/interactive/wire/proc/find_wire_connection(var/mob/caller)

	if(connected_machine)
		caller?.to_chat(span("warning","\The [src.name] is already connected to \a [connected_machine.name]! Remove it first before adding a new connection."))
		return FALSE

	var/obj/structure/interactive/powered/P = locate() in src.loc
	if(!P)
		caller?.to_chat(span("warning","There is nothing to connect \the [src.name] to!"))
		return FALSE

	connected_machine = P
	connected_machine.connected_wire = src

	caller?.to_chat(span("notice","You connect \the [src.name] to \the [connected_machine.name]."))

	if(power_network) power_network.add_wire(src) //This acts as an update.

	update_sprite()

	return TRUE



/obj/structure/interactive/wire/proc/do_snap()
	src.visible_message(span("danger","\The [src.name] snaps!"))
	qdel(src)

/obj/structure/interactive/wire/Destroy()

	if(power_network)
		power_network.remove_wire(src)

	for(var/k in connections)
		var/obj/structure/interactive/wire/W = connections[k]
		W.generate_4way()
		if(power_network)
			W.finalize_network()

	connections.Cut()

	. = ..()

/obj/structure/interactive/wire/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_MULTITOOL)
			INTERACT_CHECK
			INTERACT_DELAY(10)
			if(power_network)
				caller.to_chat(span("notice","Network ID: \ref[power_network]."))
				caller.to_chat(span("notice","Supply: [power_network.power_supply]w."))
				caller.to_chat(span("notice","Draw: [power_network.power_draw]w."))
			else
				caller.to_chat(span("warning","No power network detected!"))

	. = ..()

/obj/structure/interactive/wire/proc/finalize_network()

	var/power_network/best_network
	var/list/found_power_networks = list()
	var/list/found_connections = get_new_connections()

	for(var/k in found_connections)
		var/obj/structure/interactive/wire/W = k
		if(W.power_network)
			found_power_networks |= W.power_network

	for(var/k in found_power_networks)
		var/power_network/PN = k
		if(!best_network || PN.id < best_network.id)
			best_network = PN

	for(var/k in found_connections)
		var/obj/structure/interactive/wire/W = k
		if(W.power_network != best_network)
			W.power_network.remove_wire(W)
		best_network.add_wire(W)

	for(var/k in found_power_networks)
		var/power_network/PN=k
		if(PN == best_network)
			continue
		qdel(PN)

	log_debug("Merged [length(found_power_networks)] power networks into 1.")

/obj/structure/interactive/wire/proc/get_new_connections(var/list/existing_list)

	set background = 1

	if(!existing_list)
		existing_list = list()

	existing_list[src] = TRUE

	for(var/k in connections) //Connections is an ASSOC list. wire = TRUE
		if(existing_list[k])
			continue
		var/obj/structure/interactive/wire/W = k
		if(W.qdeleting)
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

/obj/structure/interactive/wire/Finalize()
	. = ..()
	if(!power_network)
		power_network = new /power_network/
		power_network.add_wire(src)

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
		var/obj/structure/interactive/wire/W = locate() in T.contents
		if(!W || W.qdeleting)
			continue
		if(W.power_network)
			possible_power_networks |= W.power_network
		connection_dir |= k
		connections[W] = TRUE
		var/W_old_connection_dir = W.connection_dir
		W.connection_dir |= turn(k,180)
		W.connections[src] = TRUE
		if(W_old_connection_dir != W.connection_dir)
			W.update_sprite()

	if(length(possible_power_networks))
		var/power_network/PN = pick(possible_power_networks)
		PN.add_wire(src)

	if(connection_dir != old_connection_dir)
		update_sprite()
		return TRUE

	return FALSE







