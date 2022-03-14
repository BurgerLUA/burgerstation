/obj/structure/interactive/powered/smes
	name = "super-magnetic power conductor"

	icon = 'icons/obj/structure/power.dmi'
	icon_state = "smes"

	var/list/obj/item/powercell/stored_cells = list()

/obj/structure/interactive/powered/smes/standard/Generate()
	. = ..()
	for(var/i=1,i<=4,i++)
		var/obj/item/powercell/industrial/I = new(src)
		INITIALIZE(I)
		GENERATE(I)
		FINALIZE(I)
		stored_cells |= I

/obj/structure/interactive/powered/smes/get_examine_list(var/mob/caller)
	. = ..()

	for(var/i=1,i<=length(stored_cells),i++)
		var/obj/item/powercell/PC = stored_cells[i]
		. += div("notice","\The [PC.name](#[i]) has [PC.charge_current] out of [PC.charge_max] charge remaining.")

/obj/structure/interactive/powered/smes/power_process(var/power_multiplier=1)

	. = ..()

	var/required_power = connected_wire.power_network.power_draw - (connected_wire.power_network.power_supply-power_supply)

	if(required_power > 0)
		var/actual_power_provided = 0
		for(var/k in stored_cells)
			var/obj/item/powercell/PC = k
			var/PC_power = min(required_power,PC.charge_current)
			PC.charge_current -= PC_power
			required_power -= PC_power
			actual_power_provided += PC_power
			if(required_power < 0)
				break
		update_power_supply(actual_power_provided)
	else
		update_power_supply(0)
