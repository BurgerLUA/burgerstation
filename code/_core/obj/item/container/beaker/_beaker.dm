/obj/item/container/simple/beaker
	name = "glass beaker"
	desc = "For the mad scientist in all of us."
	desc_extended = "Holds reagents."
	crafting_id = "beaker"

	icon = 'icons/obj/item/container/cup/beaker.dmi'
	icon_state = "beaker"

	reagents = /reagent_container/beaker/

	var/icon_count = 8

	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	var/overide_icon = FALSE

	value = 10

	drop_sound = 'sound/items/drop/bottle.ogg'

	has_quick_function = TRUE

	value = 0

	size = SIZE_2

/obj/item/container/simple/beaker/Finalize()
	. = ..()
	update_sprite()

/obj/item/container/simple/beaker/quick(var/mob/caller,var/atom/object,location,params)
	return try_transfer_reagents(caller,caller,location,null,params)

/obj/item/container/simple/beaker/get_consume_verb()
	return "drink" //this

/obj/item/container/simple/beaker/get_consume_sound()
	return 'sound/items/consumables/drink.ogg'

/obj/item/container/simple/beaker/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/simple/beaker/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(allow_reagent_transfer_to && istype(object,/obj/item/weapon/melee))
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

/obj/item/container/simple/beaker/click_self(var/mob/caller,location,control,params)

	if(allow_reagent_transfer_to || allow_reagent_transfer_from)
		INTERACT_CHECK
		INTERACT_DELAY(1)
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			var/choice = input("How much do you want to transfer at once?","Min: 0.5 Max: [reagents.volume_max]") as null|num
			INTERACT_CHECK
			if(choice)
				transfer_amount = clamp(choice,0.5,reagents.volume_max)
				caller.to_chat(span("notice","You will now transfer [transfer_amount] units at a time with \the [src]."))
			return TRUE

		var/initial_amount = initial(transfer_amount)

		transfer_amount += initial_amount
		if(transfer_amount > reagents.volume_max)
			transfer_amount = initial_amount

		caller.to_chat(span("notice","You will now transfer [transfer_amount] units at a time with \the [src]."))

		return TRUE

	. = ..()

/obj/item/container/simple/beaker/update_underlays()
	. = ..()
	if(!overide_icon)
		var/image/I = new/image(initial(icon),"liquid_[CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)]")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = reagents.color
		add_underlay(I)

/obj/item/container/simple/beaker/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/potassium/Generate()
	reagents.add_reagent(/reagent/potassium,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/tnt/Generate()
	reagents.add_reagent(/reagent/fuel/tnt,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/tnt_fragments/Generate()
	reagents.add_reagent(/reagent/fuel/tnt,20)
	reagents.add_reagent(/reagent/iron,40)
	return ..()

/obj/item/container/simple/beaker/smoke_01/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/potassium,40)
	return ..()

/obj/item/container/simple/beaker/smoke_02/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar,20)
	reagents.add_reagent(/reagent/phosphorous,40)
	return ..()

/obj/item/container/simple/beaker/flashbang_01/Generate()
	reagents.add_reagent(/reagent/ammonia,20)
	reagents.add_reagent(/reagent/nitrogen,40)
	return ..()

/obj/item/container/simple/beaker/flashbang_02/Generate()
	reagents.add_reagent(/reagent/ammonia,20)
	reagents.add_reagent(/reagent/fuel/hydrogen,40)
	return ..()
