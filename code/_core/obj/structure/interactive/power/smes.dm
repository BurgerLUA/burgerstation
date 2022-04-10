/obj/structure/interactive/power/smes
	name = "super-magnetic power conductor"

	icon = 'icons/obj/structure/power.dmi'
	icon_state = "smes_map"

	var/list/obj/item/powercell/stored_cells = list()

	wire_powered = TRUE

	var/obj/item/powercell/cell_type = /obj/item/powercell

	var/obj/structure/interactive/power/apc_connection_terminal/terminal

	dir_offset = -4

	pixel_y = 4

/obj/structure/interactive/power/smes/New(var/desired_loc)
	. = ..()
	terminal = new(get_step(src,dir))
	terminal.connected_smes = src
	terminal.dir = turn(dir,180)

/obj/structure/interactive/power/smes/Initialize()
	setup_dir_offsets()
	dir = SOUTH
	. = ..()

/obj/structure/interactive/power/smes/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/power/smes/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = "smes"

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

	. += div("notice","Power Input: [terminal.power_draw]w.")
	. += div("notice","Power Output: [power_supply]w.")

	for(var/i=1,i<=length(stored_cells),i++)
		var/obj/item/powercell/PC = stored_cells[i]
		. += div("notice","\The [PC.name](#[i]) has [PC.charge_current]/[PC.charge_max]([CEILING(100*(PC.charge_current/PC.charge_max),1)]%) charge remaining.")



/obj/structure/interactive/power/smes/get_power_supply()
	return 0 //Handled in power process.


/obj/structure/interactive/power/smes/power_process(var/power_multiplier=1)

	. = ..()

	var/required_power = max(0,connected_wire.power_network.power_draw - (connected_wire.power_network.power_supply-power_supply))

	if(required_power > 0)
		var/actual_power_provided = 0
		for(var/k in stored_cells)
			var/obj/item/powercell/PC = k
			var/local_provided_power = min(required_power,PC.charge_current,CEILING(PC.charge_max,1))
			PC.charge_current -= local_provided_power
			required_power -= local_provided_power
			actual_power_provided += local_provided_power
			if(required_power <= 0)
				break
		update_power_supply(actual_power_provided) //How much we're giving to the new network.
	else
		update_power_supply(0)

	if(terminal)
		terminal.update_power_draw(terminal.get_power_draw()) //How much we're taking from the network.
		var/charge_to_give = terminal.power_draw
		for(var/k in stored_cells)
			var/obj/item/powercell/PC = k
			var/local_charge_to_give = min(charge_to_give,max(0,PC.charge_max - PC.charge_current),CEILING(PC.charge_max,1))
			PC.charge_current += local_charge_to_give
			charge_to_give -= local_charge_to_give
			if(local_charge_to_give <= 0)
				break

/obj/structure/interactive/power/smes/industrial
	cell_type = /obj/item/powercell/industrial

/obj/structure/interactive/power/apc_connection_terminal
	name = "SMES connection terminal"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "terminal"
	var/obj/structure/interactive/power/smes/connected_smes

	wire_powered = TRUE

/obj/structure/interactive/power/apc_connection_terminal/Destroy()
	. = ..()
	if(connected_smes)
		connected_smes.terminal = null
		connected_smes = null

/obj/structure/interactive/power/apc_connection_terminal/get_power_draw()

	var/missing_charge = 0
	for(var/k in connected_smes.stored_cells)
		var/obj/item/powercell/PC = k
		missing_charge += max(0,PC.charge_max - PC.charge_current)

	return missing_charge
