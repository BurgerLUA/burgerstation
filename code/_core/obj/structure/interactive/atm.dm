/obj/structure/interactive/atm
	name = "automatic teller machine"
	desc = "Bank on a wall."
	desc_extended = "An automatic bank teller machine that allows you to deposit or withdraw money into your connected bank account."
	icon = 'icons/obj/structure/atm_bank.dmi'
	icon_state = "atm"

	plane = PLANE_MOVABLE

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#0000FF"

	var/list/tracked_limits = list()

/obj/structure/interactive/atm/Initialize()
	try_attach_to()
	setup_dir_offsets()
	return ..()

/obj/structure/interactive/atm/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/atm/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"atm_light")
	I.plane = PLANE_LIGHTING_EFFECT
	add_overlay(I)

/obj/structure/interactive/atm/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(caller.client && is_player(caller))
		var/mob/living/advanced/player/P = caller
		if(is_inventory(object))
			var/obj/hud/inventory/I = object
			var/desired_input = input("How many credits do you wish to withdraw? (Limit: 5000cr per machine, 1% + 2cr fee.)","Withdraw Credits",0) as num
			INTERACT_CHECK
			if(!desired_input || desired_input <= 0)
				P.to_chat(span("warning","Operation canceled."))
				return TRUE
			if(length(tracked_limits) && tracked_limits[P.ckey])
				desired_input -= tracked_limits[P.ckey]
				if(desired_input <= 0)
					P.to_chat(span("warning","Transaction limit reached for this machine. Operation canceled."))
					return TRUE
			var/fee = CEILING(2 + desired_input*0.01,1)
			var/second_input = input("The ATM will attempt to withdraw [desired_input] credits from your account, with a [fee] credit fee. Is this acceptable?","Confirmation","Cancel") as null|anything in list("Yes","No","Cancel")
			if(!second_input || second_input == "Cancel")
				P.to_chat(span("warning","Operation canceled."))
				return TRUE
			INTERACT_CHECK
			if(fee + desired_input > P.currency)
				P.to_chat(span("warning","Insufficient funds."))
				return TRUE
			tracked_limits[P.ckey] += desired_input
			P.adjust_currency(-(fee + desired_input))
			var/obj/item/currency/credits/C = new(get_turf(caller))
			INITIALIZE(C)
			C.amount = desired_input
			FINALIZE(C)
			P.to_chat(span("notice","Transaction complete."))
			I.add_object(C)
			return TRUE

		if(istype(object,/obj/item/currency/credits/))
			var/obj/item/currency/credits/C = object
			P.adjust_currency(C.amount)
			C.amount = 0
			qdel(C)
			return TRUE


	. = ..()