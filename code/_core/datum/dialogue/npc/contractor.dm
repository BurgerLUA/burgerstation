/dialogue/npc/contractor/

/dialogue/npc/contractor/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Ah, greetings [P.real_name], I have heard quite about you. Perhaps you'd like to earn some extra credits while working here? I am offering #1... if you're up for it.",
		"blood contracts"
	)

	if("purchase a blood contract" in known_options)
		.["hello"] += "purchase a blood contract"
		.["hello"] += "turn in a blood contract"


	.["blood contracts"] = list(
		"It's simple: You #1 from me, and you go out there and complete it. You can then #2 to me and I will give you the reward inscribed in the #2, as well as what you spent to purchase to the blood contract. \
		There is no risk of failing it... however if you lose the contract... well you lose your investment.",
		"purchase a blood contract",
		"turn in a blood contract"
	)

	.["purchase a blood contract"] = list(
		"I hope you'll enjoy these..."
	)

	.["turn in a blood contract"] = list(
		"..."
	)

	.["*success"] = list(
		"Excellent work. Please enjoy your reward..."
	)

	.["*failure"] = list(
		"You have no contracts in your hand that are completed. Please do not waste my time."
	)


var/global/list/valid_contract_locations = list("contract",BODY_HAND_LEFT_HELD,BODY_HAND_RIGHT_HELD)

/dialogue/npc/contractor/set_topic(var/mob/living/advanced/player/P,var/topic)

	if(topic == "purchase a blood contract")
		if(istype(P.dialogue_target,/mob/living/advanced/npc/unique/contractor))
			var/mob/living/advanced/npc/unique/contractor/C = P.dialogue_target
			if(C.stored_vendor)
				var/obj/structure/interactive/vending/V = C.stored_vendor
				if(P.active_structure == V)
					P.set_structure_unactive()
				else
					P.set_structure_active(V)

		P.dialogue_target_id = null
		close_menu(P,/menu/dialogue/)
		return TRUE

	else if(topic == "turn in a blood contract")
		var/obj/item/contract/found_contract
		for(var/k in valid_contract_locations)
			var/obj/hud/inventory/I = P.inventories_by_id[k]
			var/obj/item/contract/C = I.get_top_object()
			if(C && C.amount >= C.amount_max && istype(C))
				found_contract = C
				break
		if(found_contract && found_contract.turn_in(P))
			. = ..(P,"*success")
		else
			. = ..(P,"*failure")
		return .

	. = ..()
