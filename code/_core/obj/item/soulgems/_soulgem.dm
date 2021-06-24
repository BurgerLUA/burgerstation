/obj/item/soulgem
	name = "bluespace gem"
	desc = "Holds the souls of lesser beings. Not to be confused with bluespace crystals."
	desc_extended = "Used in enchanting items or refilling the magic of staves."
	icon = 'icons/obj/item/soulgem.dmi'
	icon_state = "common"

	var/total_charge = 0
	//TODO: Make these enchant things.

	value = 60

	weight = 1

/obj/item/soulgem/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("total_charge")

/obj/item/soulgem/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("total_charge")

/obj/item/soulgem/Finalize()
	. = ..()
	update_sprite()

/obj/item/soulgem/get_base_value()
	. = ..()
	. += (total_charge/16)**1.5

/obj/item/soulgem/get_examine_list(var/mob/caller)
	return ..() + span("notice","It has [total_charge] total charge.")

/obj/item/soulgem/update_sprite()
	name = initial(name)
	if(!total_charge)
		name = "empty [name]"
		return ..()
	switch(total_charge)
		if(0 to SOUL_SIZE_COMMON)
			name = "common [name]"
		if(SOUL_SIZE_COMMON to SOUL_SIZE_UNCOMMON)
			name = "uncommon [name]"
		if(SOUL_SIZE_UNCOMMON to SOUL_SIZE_RARE)
			name = "rare [name]"
		if(SOUL_SIZE_RARE to SOUL_SIZE_MYSTIC)
			name = "mystic [name]"
		if(SOUL_SIZE_MYSTIC to INFINITY)
			name = "godly [name]"
	return ..()

/obj/item/soulgem/update_icon()
	if(total_charge)
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = initial(icon_state)
	return ..()

/obj/item/soulgem/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,/obj/effect/temp/soul))
		if(total_charge != 0)
			caller.to_chat(span("warning","You need an empty soul gem in order to capture souls!"))
			return TRUE

		var/obj/effect/temp/soul/S = object
		if(S.qdeleting || !S.soul_size)
			return TRUE

		total_charge = S.soul_size
		caller.visible_message(span("danger","\The [caller.name] traps \the [S.name] with \the [src.name]!"),span("warning","You trap \the [S.name] with \the [src.name]!"))
		if(is_living(caller))
			var/mob/living/L = caller
			L.add_skill_xp(SKILL_MAGIC_ENCHANTING,CEILING(S.soul_size*0.1,1))
		qdel(S)
		update_sprite()

		return TRUE

	/*
	if(is_staff(object))

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)

		var/obj/item/weapon/ranged/magic/staff/S = object
		if(total_charge)
			caller.visible_message(span("notice","\The [caller.name] recharges \the [S.name] with \the [src.name]."),span("notice","You charge \the [S] with \the [src]."))
			S.total_charge += total_charge
			if(is_living(caller))
				var/mob/living/L = caller
				L.add_skill_xp(SKILL_MAGIC_ENCHANTING,CEILING(total_charge*0.025,1))
			total_charge = 0
		else
			caller.to_chat(span("warning","\The [src] is empty!"))
		update_sprite()

		return TRUE
	*/

	return ..()


/obj/item/soulgem/common
	total_charge = SOUL_SIZE_COMMON

/obj/item/soulgem/uncommon
	total_charge = SOUL_SIZE_UNCOMMON

/obj/item/soulgem/rare
	total_charge = SOUL_SIZE_RARE

/obj/item/soulgem/mystic
	total_charge = SOUL_SIZE_MYSTIC