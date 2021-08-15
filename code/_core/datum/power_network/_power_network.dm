/power_network/
	var/list/obj/structure/interactive/powered/connected_machinery = list()
	var/list/obj/structure/interactive/wire/connected_wires = list()
	var/power_supply = 0
	var/power_draw = 0

	var/queue_wire_update = FALSE

/power_network/Destroy()

	for(var/k in connected_machinery)
		var/obj/structure/interactive/powered/P = k
		src.remove_machine(P)

	for(var/k in connected_wires)
		var/obj/structure/interactive/wire/W = k
		src.remove_wire(W)

	connected_machinery.Cut()
	connected_wires.Cut()
	power_supply = null
	power_draw = null

/power_network/proc/update_wires()

	if(!length(connected_wires))
		qdel(src)
		return FALSE

	var/obj/structure/interactive/wire/master_wire = connected_wires[1]
	for(var/k in connected_wires - master_wire)
		var/obj/structure/interactive/wire/W = k
		src.remove_wire(W)

	var/list/wires_to_update = master_wire.get_all_connections()
	for(var/k in wires_to_update)
		var/obj/structure/interactive/wire/W = k
		src.add_wire(W)

	return TRUE

/power_network/proc/add_machine(var/obj/structure/interactive/powered/machine)

	if(!machine)
		return FALSE

	connected_machinery |= machine
	machine.power_network = src

	machine.update_power_draw(machine.get_power_draw())
	machine.update_power_supply(machine.get_power_supply())

	return TRUE

/power_network/proc/remove_machine(var/obj/structure/interactive/powered/machine)

	if(!machine)
		return FALSE

	machine.update_power_draw(0)
	machine.update_power_supply(0)

	machine.power_network = null
	connected_machinery -= machine

	return TRUE


/power_network/proc/add_wire(var/obj/structure/interactive/wire/wire)

	if(!wire)
		return FALSE

	if(wire.connected_machine)
		add_machine(wire.connected_machine)

	connected_wires |= wire
	wire.power_network = src

	return TRUE

/power_network/proc/remove_wire(var/obj/structure/interactive/wire/wire)

	if(!wire)
		return FALSE

	if(wire.connected_machine)
		remove_machine(wire.connected_machine)

	connected_wires -= wire
	wire.power_network = null

	return TRUE