/obj/structure/interactive/atm
	name = "automatic teller machine"
	desc = "Bank on a wall."
	desc_extended = "An automatic bank teller machine that allows you to deposit or withdraw money into your connected bank account."
	icon = 'icons/obj/structure/atm_bank.dmi'
	icon_state = "atm_map"

	plane = PLANE_OBJ

/obj/structure/interactive/atm/Initialize()
	setup_dir_offsets()
	dir = SOUTH
	icon_state = "atm"
	return ..()

/obj/structure/interactive/atm/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(is_player(caller))
		var/mob/living/advanced/player/P = caller
		if(is_inventory(object))
			if(P.loyalty_tag == "NanoTrasen" && SStax.check_delinquent(P))
				P.to_chat(span("warning","Error: Tax delinquency detected. All associated accounts frozen. Please pay your taxes at the nearest tax payment center."))
				return FALSE
			var/obj/hud/inventory/I = object
			var/desired_input = input("How many credits do you wish to withdraw? (Limit: 5000cr, 1% + 2cr fee.)","Withdraw Credits",0) as num
			INTERACT_CHECK
			if(!desired_input || desired_input <= 0)
				P.to_chat(span("warning","Operation canceled."))
				return TRUE
			if(desired_input > 5000)
				P.to_chat(span("warning","You can't withdraw more than 5000 credits at a time!"))
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
			P.adjust_currency(-(fee + desired_input))
			var/obj/item/currency/credits/C = new(get_turf(caller))
			INITIALIZE(C)
			C.item_count_current = desired_input
			FINALIZE(C)
			P.to_chat(span("notice","Transaction complete."))
			I.add_object(C)
			return TRUE

		if(istype(object,/obj/item/currency/credits/))
			var/obj/item/currency/credits/C = object
			P.adjust_currency(C.item_count_current)
			C.item_count_current = 0
			qdel(C)


	. = ..()