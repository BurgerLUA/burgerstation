/dialogue/npc/contractor/

/dialogue/npc/contractor/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Ah, greetings [P.real_name], I have heard quite about you. Perhaps you'd like to show me more of the type of person you are? I am offering #1... if you're up for it. \
		I also have several #2 if you're feeling particularly... Lucky.",
		"Blood Contracts",
		"Loot Boxes"
	)

	if("purchase a blood contract" in known_options)
		.["hello"] |= "purchase a blood contract"
		.["hello"] |= "turn in a blood contract"


	.["Blood Contracts"] = list(
		"It's simple: You #1 from me, and you go out there and complete it. You can then #2 to me and I will give you the reward inscribed in the blood contract. \
		There is no risk of failing it... however if you lose the contract... well you lose your investment.",
		"purchase a blood contract",
		"turn in a blood contract"
	)

	if("purchase loot boxes" in known_options)
		.["hello"] |= "purchase loot boxes"


	.["Loot Boxes"] = list(
		"I can recognize a gambler from a miles away, heh. These loot boxes contain items that \
		 cannot be bought anywhere else in the world IF you're lucky, care to try?",
		"purchase loot boxes"
	)

	.["purchase a blood contract"] = list(
		"I hope you'll enjoy these..."
	)

	.["turn in a blood contract"] = list(
		"..."
	)

	.["purchase loot boxes"] = list(
		"..."
	)

	.["*success"] = list(
		"Excellent work. Please enjoy your reward..."
	)

	.["*failure"] = list(
		"You have no contracts that are completed. Please do not waste my time."
	)


/dialogue/npc/contractor/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

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

	else if(topic == "purchase loot boxes")
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
		if(istype(P.right_item,/obj/item/contract/))
			var/obj/item/contract/C = P.right_item
			if(C.amount_current >= C.amount_max)
				found_contract = C
		if(!found_contract && istype(P.left_item,/obj/item/contract/))
			var/obj/item/contract/C = P.left_item
			if(C.amount_current >= C.amount_max)
				found_contract = C
		if(found_contract)
			found_contract.turn_in(P)
			. = ..(P,"*success")
		else
			. = ..(P,"*failure")
		return .
