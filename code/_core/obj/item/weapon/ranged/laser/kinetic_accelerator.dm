/obj/item/weapon/ranged/energy/kinetic_accelerator

	name = "kinetic accelerator"
	desc = "Pump action!"
	desc_extended = "An advanced mining tool that uses magnetic force to pulverize rocks and other foes."
	icon = 'icons/obj/item/weapons/ranged/laser/kinetic_accelerator.dmi'
	rarity = RARITY_UNCOMMON
	value = 1000




	charge_cost = 1





/obj/item/weapon/ranged/energy/kinetic_accelerator/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","You are unable to pry out \the [battery.name]."))
			else
				caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return TRUE

	. = ..()