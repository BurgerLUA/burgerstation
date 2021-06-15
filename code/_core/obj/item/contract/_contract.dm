/obj/item/contract
	name = "blood contract"
	icon = 'icons/obj/item/contract.dmi'
	icon_state = "unfilled"

	desc = "They said not to deal with the devil. Now look what you've done."
	desc_extended = "A spooky contract listing one or more conditions the contract holder should complete. Despite being made out of papyrus, it appears to be very strong."

	var/contract/contract_datum
	var/reward_amount = 0
	var/amount_current = 0
	var/amount_max = 0

	drop_sound = 'sound/items/drop/paper.ogg'

	value = 1

/obj/item/contract/update_sprite()
	. = ..()
	if(!amount_max)
		icon_state = "torn"
	else if(amount_current >= amount_max)
		icon_state = "filled"
	else
		icon_state = "unfilled"

/obj/item/contract/Generate()
	. = ..()
	if(!ispath(contract_datum))
		contract_datum = pick(SScontract.all_contracts)
	var/contract/C = CONTRACT(contract_datum)
	reward_amount = C.get_random_reward()
	amount_current = 0
	amount_max = C.get_random_amount()

/obj/item/contract/proc/on_kill(var/mob/living/attacker,var/list/data=list())

	var/mob/living/victim = data[1]
	var/contract/C = CONTRACT(contract_datum)
	if(istype(victim,C.type_to_check))
		amount_current++
		update_sprite()

	return TRUE

/obj/item/contract/Finalize()
	. = ..()
	var/contract/C = CONTRACT(contract_datum)
	name = "[initial(src.name)]: [C.name]"
	value = CEILING(reward_amount * 0.25,1)

/obj/item/contract/get_examine_details_list(var/mob/examiner)
	. = ..()
	var/contract/C = CONTRACT(contract_datum)
	. += div("notice","Reward on completion: [reward_amount].")
	. += div("notice","[amount_current] out of [amount_max] [C.reward_text].")

/obj/item/contract/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEPATH("contract_datum")
	SAVEVAR("reward_amount")
	SAVEVAR("amount_current")
	SAVEVAR("amount_max")

/obj/item/contract/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADPATH("contract_datum")
	LOADVAR("reward_amount")
	LOADVAR("amount_current")
	LOADVAR("amount_max")

/obj/item/contract/post_move(var/atom/old_loc)

	. = ..()

	if(!.)
		return .

	if(istype(loc,/obj/hud/inventory/organs/groin/pocket/contract))
		var/obj/hud/inventory/organs/groin/pocket/contract/I = loc
		if(is_advanced(I.owner))
			HOOK_ADD("on_kill","on_kill_\ref[src]",I.owner,src,.proc/on_kill)

	if(istype(old_loc,/obj/hud/inventory/organs/groin/pocket/contract))
		var/obj/hud/inventory/organs/groin/pocket/contract/I = old_loc
		if(is_advanced(I.owner))
			HOOK_REMOVE("on_kill","on_kill_\ref[src]",I.owner)


