var/global/power_id = 1

/power_network/
	var/list/obj/structure/interactive/wire/connected_wires = list()
	var/list/obj/structure/interactive/wire/connected_wires_with_machines = list()
	var/power_supply = 0
	var/power_draw = 0
	var/id = 0

/power_network/New(var/desired_loc)
	. = ..()
	SSpower.all_power_networks += src
	id = power_id
	power_id++

/power_network/Destroy()

	for(var/k in connected_wires)
		var/obj/structure/interactive/wire/W = k
		src.remove_wire(W)

	connected_wires.Cut() //Safety.
	connected_wires_with_machines.Cut() //Safety.

	power_supply = null
	power_draw = null

	SSpower.all_power_networks -= src

	. = ..()

/power_network/proc/power_process()

	var/power_multiplier = power_supply && power_draw ? min(1,power_supply / power_draw) : 0

	for(var/k in connected_wires_with_machines)
		var/obj/structure/interactive/wire/W = k
		W.connected_machine.power_process(power_multiplier)

//Handling wires.
/power_network/proc/add_wire(var/obj/structure/interactive/wire/wire)

	connected_wires |= wire
	wire.power_network = src

	if(wire.connected_machine)
		connected_wires_with_machines |= wire
		wire.connected_machine.update_power_draw(wire.connected_machine.get_power_draw(),reset=TRUE)
		wire.connected_machine.update_power_supply(wire.connected_machine.get_power_supply(),reset=TRUE)
		wire.color = COLOR_GREEN
	else
		wire.color = COLOR_BLUE

	return TRUE

/power_network/proc/remove_wire(var/obj/structure/interactive/wire/wire)

	if(wire.connected_machine)
		connected_wires_with_machines -= wire
		wire.connected_machine.update_power_draw(0)
		wire.connected_machine.update_power_supply(0)
		wire.color = COLOR_RED
	else
		wire.color = COLOR_YELLOW

	connected_wires -= wire
	wire.power_network = null

	return TRUE
