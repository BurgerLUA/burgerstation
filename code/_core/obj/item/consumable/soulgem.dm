/obj/item/consumable/soulgem
	name = "bluespace gem"
	desc = "Holds the souls of lesser beings. Not to be confused with bluespace crystals."
	desc_extended = "Used in enchanting items or refilling the magic of staves."
	icon = 'icons/obj/items/soulgem.dmi'
	icon_state = "common"

	var/total_charge = 0
	//TODO: Make these enchant things.

/obj/item/consumable/soulgem/on_spawn()
	total_charge = 1000

/obj/item/consumable/soulgem/get_examine_text(var/mob/caller)
	return ..() + span("notice","It has [total_charge] total charge.")

/obj/item/consumable/soulgem/update_icon()
	if(total_charge)
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = initial(icon_state)
	..()

/obj/item/consumable/soulgem/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(is_staff(object))
		var/obj/item/weapon/ranged/magic/staff/S = object
		if(total_charge)
			caller.to_chat(span("notice","You refill \the [S] with \the [src]."))
			S.total_charge += total_charge
			total_charge = 0
		else
			caller.to_chat(span("notice","\The [src] is empty!"))
		update_icon()

		return TRUE

	return ..()