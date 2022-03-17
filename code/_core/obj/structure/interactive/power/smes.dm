/obj/structure/interactive/power/smes
	name = "super-magnetic power conductor"

	icon = 'icons/obj/structure/power.dmi'
	icon_state = "smes"

	var/list/obj/item/powercell/stored_cells = list()

	wire_powered = TRUE

	var/obj/item/powercell/cell_type = /obj/item/powercell

	var/obj/structure/interactive/power/connection_terminal/terminal

/obj/structure/interactive/power/smes/Destroy()
	. = ..()
	QDEL_NULL(terminal)
	for(var/k in stored_cells)
		var/obj/item/I = k
		qdel(I)
	stored_cells.Cut()

/obj/structure/interactive/power/smes/Generate()
	. = ..()
	for(var/i=1,i<=4,i++)
		var/obj/item/powercell/I = new cell_type(src)
		INITIALIZE(I)
		GENERATE(I)
		FINALIZE(I)
		stored_cells |= I

/obj/structure/interactive/power/smes/get_examine_list(var/mob/caller)
	. = ..()

	. += div("notice","Power Draw: [terminal.power_draw]w.")
	. += div("notice","Power Supply: [power_supply]w.")

	for(var/i=1,i<=length(stored_cells),i++)
		var/obj/item/powercell/PC = stored_cells[i]
		. += div("notice","\The [PC.name](#[i]) has [PC.charge_current] out of [PC.charge_max] charge remaining.")



/obj/structure/interactive/power/smes/get_power_supply()
	return 0 //Handled in power process.


/obj/structure/interactive/power/smes/power_process(var/power_multiplier=1)

	. = ..()

	var/required_power = max(0,connected_wire.power_network.power_draw - (connected_wire.power_network.power_supply-power_supply))

	if(required_power > 0)
		var/actual_power_provided = 0
		for(var/k in stored_cells)
			var/obj/item/powercell/PC = k
			var/local_provided_power = min(required_power,PC.charge_current,CEILING(PC.charge_max*0.25,1))
			PC.charge_current -= local_provided_power
			required_power -= local_provided_power
			actual_power_provided += local_provided_power
			if(required_power <= 0)
				break
		update_power_supply(actual_power_provided)
	else
		update_power_supply(0)

	if(terminal)
		terminal.update_power_draw(terminal.get_power_draw())
		var/charge_to_give = terminal.power_draw
		for(var/k in stored_cells)
			var/obj/item/powercell/PC = k
			var/local_charge_to_give = min(charge_to_give,max(0,PC.charge_max - PC.charge_current),CEILING(PC.charge_max*0.25,1))
			PC.charge_current += local_charge_to_give
			charge_to_give -= local_charge_to_give
			if(local_charge_to_give <= 0)
				break

/obj/structure/interactive/power/smes/industrial
	cell_type = /obj/item/powercell/industrial

/obj/structure/interactive/power/connection_terminal
	name = "SMES connection terminal"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "terminal"
	var/obj/structure/interactive/power/smes/connected_smes

	wire_powered = TRUE

/obj/structure/interactive/power/connection_terminal/Destroy()
	. = ..()
	if(connected_smes)
		connected_smes.terminal = null
		connected_smes = null

/obj/structure/interactive/power/connection_terminal/Generate()
	. = ..()
	var/turf/T = get_step(src,dir)
	connected_smes = locate() in T.contents
	if(!connected_smes)
		qdel(src)
	else
		connected_smes.terminal = src

/obj/structure/interactive/power/connection_terminal/get_power_draw()

	var/missing_charge = 0
	for(var/k in connected_smes.stored_cells)
		var/obj/item/powercell/PC = k
		missing_charge += max(0,PC.charge_max - PC.charge_current)

	return connected_smes.power_supply + missing_charge
