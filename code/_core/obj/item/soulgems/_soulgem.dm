/obj/item/soulgem
	name = "bluespace gem"
	desc = "Holds the souls of lesser beings. Not to be confused with bluespace crystals."
	desc_extended = "Used in enchanting items or refilling the magic of staves."
	icon = 'icons/obj/item/soulgem.dmi'
	icon_state = "common"

	var/total_charge = 0
	//TODO: Make these enchant things.

	value = 60

/obj/item/soulgem/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("total_charge")
	return .

/obj/item/soulgem/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("total_charge")
	return .

/obj/item/soulgem/calculate_value()

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
	..()

/obj/item/soulgem/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(is_staff(object))
		var/obj/item/weapon/ranged/magic/staff/S = object
		if(total_charge)
			caller.to_chat(span("notice","You refill \the [S] with \the [src]."))
			S.total_charge += total_charge
			total_charge = 0
		else
			caller.to_chat(span("notice","\The [src] is empty!"))
		update_sprite()

		return TRUE

	return ..()


/obj/item/soulgem/common/Generate()
	total_charge = 1000
	return ..()

/obj/item/soulgem/uncommon/Generate()
	total_charge = 2500
	return ..()

/obj/item/soulgem/rare/Generate()
	total_charge = 5000
	return ..()

/obj/item/soulgem/mystic/Generate()
	total_charge = 10000
	return ..()
