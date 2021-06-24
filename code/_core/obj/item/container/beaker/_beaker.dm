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

	has_quick_function = TRUE

/obj/item/container/beaker/quick(var/mob/caller,var/atom/object,location,params)

	if(!is_living(caller))
		return FALSE

	return feed(caller,caller)

/obj/item/container/beaker/get_consume_verb()
	return "drink"

/obj/item/container/beaker/get_consume_sound()
	return 'sound/items/consumables/drink.ogg'

/obj/item/container/beaker/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/beaker/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/weapon/melee))
		var/obj/item/weapon/melee/M = object
		if(!M.reagents)
			caller.to_chat(span("warning","\The [M.name] cannot be coated!"))
			return FALSE
		var/reagent_transfer = min(5,reagents.volume_current)
		if(reagent_transfer <= 0)
			caller.to_chat(span("warning","\The [src.name] is empty!"))
			return TRUE
		if(M.reagents.volume_current >= M.reagents.volume_max)
			caller.to_chat(span("warning","\The [M.name] is already coated!"))
			return TRUE
		reagents.transfer_reagents_to(M.reagents,reagent_transfer, caller = caller)
		caller.visible_message(span("warning","\The [caller.name] coats \the [M.name] with liquid from \the [src.name]."),span("notice","You carefully coat \the [M.name] with liquid from \the [src.name]."))
		return TRUE

	. = ..()

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


/obj/item/container/beaker/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/container/beaker/potassium/Generate()
	reagents.add_reagent(/reagent/potassium,reagents.volume_max)
	return ..()

/obj/item/container/beaker/smoke_01/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/potassium,40)
	return ..()

/obj/item/container/beaker/smoke_02/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/phosphorous,40)
	return ..()

/obj/item/container/beaker/large/lube_smoke_01/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/potassium,40)
	reagents.add_reagent(/reagent/lube,60)
	return ..()

/obj/item/container/beaker/large/lube_smoke_02/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/phosphorous,40)
	reagents.add_reagent(/reagent/lube,60)
	return ..()

/obj/item/container/beaker/flashbang_01/Generate()
	reagents.add_reagent(/reagent/ammonia,20)
	reagents.add_reagent(/reagent/nitrogen,40)
	return ..()

/obj/item/container/beaker/flashbang_02/Generate()
	reagents.add_reagent(/reagent/ammonia,20)
	reagents.add_reagent(/reagent/fuel/hydrogen,40)
	return ..()