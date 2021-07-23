/obj/item/weapon/ranged/magic

	var/cost_mana = 0
	var/cooldown = 60 //In deciseconds. Only used for artifacts.

	var/current_cooldown = 0

	automatic = FALSE

	use_loyalty_tag = TRUE
	firing_pin = null

	var/obj/item/powergem/stored_powergem

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.05

/obj/item/weapon/ranged/magic/Destroy()
	QDEL_NULL(stored_powergem)
	. = ..()

/obj/item/weapon/ranged/magic/get_examine_list(var/mob/examiner)

	. = ..()

	if(stored_powergem)
		. += div("notice","It has a [stored_powergem.name] installed in the gem slot.")
	else
		. += div("notice","It has an empty gem slot.")


/obj/item/weapon/ranged/magic/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			if(stored_powergem)
				caller.to_chat(span("notice","You remove \the [stored_powergem.name] from \the [src.name]."))
				stored_powergem.drop_item(get_turf(caller))
				if(is_advanced(caller))
					var/mob/living/advanced/A = caller
					A.put_in_hands(stored_powergem,silent=TRUE)
				stored_powergem = null
			else
				caller.to_chat(span("warning","There is nothing to remove from \the [src.name]!"))
			return TRUE
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

/obj/item/weapon/ranged/magic/can_gun_shoot(var/mob/caller)

	if(get_ammo_count() < 1)
		return FALSE

	return ..()

/obj/item/weapon/ranged/magic/get_ammo_count()

	var/mob/living/owner = get_owner()

	if(!owner)
		return 0

	if(!owner.health)
		return 1

	if(!cost_mana)
		return 1

	return owner && cost_mana ? FLOOR(owner.health.mana_current / cost_mana, 1) : 0

/obj/item/weapon/ranged/magic/handle_ammo(var/mob/caller,var/bullet_position=1)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller
	if(!A.health)
		return ..()

	A.health.adjust_mana(-cost_mana)

	A.update_health_element_icons(mana=TRUE)

	A.mana_regen_delay = max(A.mana_regen_delay,30)

	return null


/obj/item/weapon/ranged/magic/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("stored_powergem")

/obj/item/weapon/ranged/magic/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("stored_powergem")

/obj/item/weapon/ranged/magic/get_static_spread()
	return 0

/obj/item/weapon/ranged/magic/get_skill_spread(var/mob/living/L)
	return 0.05 - (0.1 * L.get_skill_power(SKILL_MAGIC_DEFENSIVE))

/obj/item/weapon/ranged/magic/get_base_spread()
	return 0.02
