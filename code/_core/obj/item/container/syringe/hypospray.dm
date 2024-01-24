/obj/item/container/syringe/hypospray
	name = "hypospray"
	desc = ";CMO IS A CHANGELING!!"
	desc_extended = "A bulky, sterile, reusuable air-needle autoinjector for rapid administration of drugs to patients. Injects up to 15 units at a time, almost instantly."

	value = 800
	icon = 'icons/obj/item/container/hypospray.dmi'
	icon_state = "hypo"

	injection_sound = 'sound/effects/stimpack.ogg'

	quality_reduction_on_use = 0
	injection_time = 0.25 SECONDS
	inject_amount_max = 15
	reagents = /reagent_container/syringe/hypospray // holds 60u
	adjustable = TRUE

	size = SIZE_3

	var/icon_count = 12

	rarity = RARITY_RARE

	can_draw = FALSE
	can_inject = TRUE

/obj/item/container/syringe/hypospray/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!object.reagents)
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(!istype(object,/obj/item/container/simple/beaker/bottle/hypospray))
		caller.to_chat(span("warning","You don't know how to put \the [object.name] into \the [src.name]... maybe a special container will work?"))
		return TRUE

	var/obj/item/container/simple/beaker/bottle/hypospray/H = object
	if(H.spent)
		caller.to_chat(span("warning","\The [H.name]'s gas canister is spent and cannot inject its contents!"))
		return TRUE
	H.spent = TRUE

	if(H.reagents.transfer_reagents_to(src.reagents))
		caller.to_chat(span("notice","You insert \the [H.name] into \the [src.name], activating the pressurized gas."))
	else
		caller.to_chat(span("warning","You insert \the [H.name] into \the [src.name], activating the pressurized gas, but the reagents fail to transfer into \the [src.name]!"))

	return TRUE

/obj/item/container/syringe/hypospray/update_icon()
	. = ..()
	//Plunger
	icon = initial(icon)
	icon_state = initial(icon_state)
	var/num_state = CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)
	icon_state = "[icon_state]_[num_state]"

/obj/item/container/syringe/hypospray/update_overlays()
	. = ..()
	if(reagents && reagents.volume_current)
		var/image/I = new/image(icon,"liquid")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = reagents.color
		add_underlay(I)

/obj/item/container/syringe/hypospray/combat
	name = "combat hypospray"
	desc = ";CMO IS A CHANGELING!!"
	desc_extended = "A sterile, reusuable air-needle autoinjector for rapid administration of drugs to patients. About half the size of a regular hypospray, and just as powerful. Injects up to 30 units at a time, instantly."

	value = 1600
	icon = 'icons/obj/item/container/hypospray_combat.dmi'
	icon_state = "hypo"

	injection_sound = 'sound/effects/stimpack.ogg'

	quality_reduction_on_use = 0
	injection_time = 0
	inject_amount_max = 30
	reagents = /reagent_container/syringe/hypospray/combat // holds 30u
	adjustable = TRUE

	size = SIZE_2

	icon_count = 5

	rarity = RARITY_MYTHICAL
