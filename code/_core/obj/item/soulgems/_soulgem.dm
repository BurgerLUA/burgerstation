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
	return .

/obj/item/soulgem/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("total_charge")
	return .

/obj/item/soulgem/Finalize()
	. = ..()
	update_sprite()
	return .

/obj/item/soulgem/get_value()

	. = ..()

	. += total_charge*0.03

	return .

/obj/item/soulgem/get_examine_list(var/mob/caller)
	return ..() + span("notice","It has [total_charge] total charge.")

/obj/item/soulgem/update_icon()
	if(total_charge)
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = initial(icon_state)
	return ..()

/obj/item/soulgem/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(is_staff(object))
		var/obj/item/weapon/ranged/magic/staff/S = object
		if(total_charge)
			caller.visible_message(span("notice","\The [caller.name] recharges \the [S.name] with \the [src.name]."),span("notice","You charge \the [S] with \the [src]."))
			S.total_charge += total_charge
			if(is_living(caller))
				var/mob/living/L = caller
				L.add_skill_xp(SKILL_ENCHANTING,CEILING(total_charge*0.05,1))
			total_charge = 0
		else
			caller.to_chat(span("warning","\The [src] is empty!"))
		update_sprite()

		return TRUE

	return ..()


/obj/item/soulgem/common
	total_charge = SOUL_SIZE_COMMON

/obj/item/soulgem/uncommon
	total_charge = SOUL_SIZE_UNCOMMON

/obj/item/soulgem/rare
	total_charge = SOUL_SIZE_RARE

/obj/item/soulgem/mystic
	total_charge = SOUL_SIZE_MYSTIC