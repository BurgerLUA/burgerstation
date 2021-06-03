/obj/item/contract
	name = "contract"
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
	contract_datum = pick(SScontract.all_contracts)
	var/contract/C = CONTRACT(contract_datum)
	reward_amount = C.get_random_reward()
	amount_current = 0
	amount_max = C.get_random_amount()

/obj/item/contract/Finalize()
	. = ..()
	var/contract/C = CONTRACT(contract_datum)
	name = "contract: [C.name]"
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

/obj/item/contract/proc/on_scan(var/atom/A)
	var/contract/C = CONTRACT(contract_datum)
	return C.on_scan(A,src)

/obj/item/contract/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	if(on_scan(object))
		return TRUE
	. = ..()

/obj/item/contract/click_on_object(var/mob/caller,var/atom/object,location,control,params)
	if(on_scan(object))
		return TRUE
	. = ..()