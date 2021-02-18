/obj/item/weapon/ranged/magic

	var/cost_mana = 0
	var/cooldown = 60 //In deciseconds. Only used for artifacts.

	var/current_cooldown = 0

	automatic = FALSE

	use_loyalty_tag = TRUE
	firing_pin = null

	var/obj/item/powergem/stored_powergem

/obj/item/weapon/ranged/magic/get_examine_list(var/mob/examiner)

	. = ..()

	if(stored_powergem)
		. += div("notice","It has a [stored_powergem.name] installed in the gem slot.")
	else
		. += div("notice","It has an empty gem slot.")

	return .

/obj/item/weapon/ranged/magic/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/powergem/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		if(stored_powergem)
			caller.to_chat(span("warning","There is already a [stored_powergem.name] installed!"))
			return TRUE
		var/desired_input = input("Are you sure you wish to insert \the [object.name] into \the [src.name]? This action cannot be undone.","Powergem insertion","Cancel") as null|anything in list("Yes","No","Cancel")
		if(desired_input == "Yes")
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			var/obj/item/powergem/P = object
			P.drop_item(src)
			stored_powergem = P
			caller.to_chat(span("notice","You install \the [P.name] into \the [src.name]."))
		return TRUE

	return ..()


/obj/item/weapon/ranged/magic/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("stored_powergem")
	return .

/obj/item/weapon/ranged/magic/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("stored_powergem")
	return .

/obj/item/weapon/ranged/magic/get_static_spread()
	return 0

/obj/item/weapon/ranged/magic/get_skill_spread(var/mob/living/L)
	return 0.05 - (0.1 * L.get_skill_power(SKILL_MAGIC))
