/obj/item/container/beaker
	name = "glass beaker"
	desc = "For the mad scientist in all of us."
	desc_extended = "Holds reagents."
	crafting_id = "beaker"

	icon = 'icons/obj/item/container/cup/beaker.dmi'
	icon_state = "beaker"

	reagents = /reagent_container/beaker/

	var/icon_count = 7

	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	var/overide_icon = FALSE

	value = 5

	drop_sound = 'sound/items/drop/bottle.ogg'

/obj/item/container/beaker/get_consume_verb()
	return "drink"

/obj/item/container/beaker/get_consume_sound()
	return 'sound/items/consumables/drink.ogg'

/obj/item/container/beaker/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/beaker/click_self(var/mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/initial_amount = initial(transfer_amount)

	transfer_amount += initial_amount
	if(transfer_amount > reagents.volume_max)
		transfer_amount = initial_amount

	caller.to_chat(span("notice","You will now transfer [transfer_amount] units at a time with \the [src]."))

	return TRUE

/obj/item/container/beaker/update_icon()

	if(!overide_icon)
		icon = initial(icon)
		icon_state = initial(icon_state)

		var/icon/I = new/icon(icon,icon_state)
		var/icon/I2 = new/icon(icon,"liquid_[CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]")

		I2.Blend(reagents.color,ICON_MULTIPLY)
		I.Blend(I2,ICON_UNDERLAY)

		icon = I

	return ..()