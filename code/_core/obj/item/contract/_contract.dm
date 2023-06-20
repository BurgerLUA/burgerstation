/obj/item/contract
	name = "contract: error"
	icon = 'icons/obj/item/contract.dmi'
	icon_state = "unfilled"

	desc = "They said not to deal with the devil. Now look what you've done."
	desc_extended = "A spooky contract listing one or more conditions the contract holder should complete. Despite being made out of papyrus, it appears to be very strong."

	var/atom/type_to_check
	var/value_current = 0
	var/value_max = 0
	var/obj/item/reward
	var/burgerbux_reward = 0
	var/objective_text = "objectives completed"

	drop_sound = 'sound/items/drop/paper.ogg'

	value = 0

	rarity = RARITY_RARE

/obj/item/contract/PreDestroy()
	QDEL_NULL(reward)
	. = ..()

/obj/item/contract/update_sprite()
	. = ..()
	if(!value_max)
		icon_state = "torn"
	else if(value_current >= value_max)
		icon_state = "filled"
	else
		icon_state = "unfilled"

/obj/item/contract/Generate()
	. = ..()
	if(!reward)
		log_error("Warning: Tried generating [src.get_debug_name()], but it had a null reward!")
		reward = /obj/item/coin/adamantium
	reward = new reward(src)
	if(reward.quality != -1)
		reward.quality = rand(100,200)
	INITIALIZE(reward)
	GENERATE(reward)
	FINALIZE(reward)
	value_current = 0

/obj/item/contract/proc/on_kill(var/mob/living/attacker,var/list/data=list())

	var/mob/living/victim = data[1]
	if(istype(victim,type_to_check))
		value_current++
		update_sprite()

	return TRUE

/obj/item/contract/Finalize()
	. = ..()
	if(!reward)
		log_error("Warning: [src.get_debug_name()] had an invalid reward!")
		qdel(src)
		return FALSE

	update_value()
	update_sprite()

/obj/item/contract/get_base_value()
	return CEILING(reward.get_value()*0.25,1)

/obj/item/contract/get_examine_details_list(var/mob/examiner)
	. = ..()
	if(burgerbux_reward)
		. += div("notice","Reward on completion: [reward.name] and [burgerbux_reward] Burgerbux.")
	else
		. += div("notice","Reward on completion: [reward.name].")
	. += div("notice","[value_current] out of [value_max] [objective_text].")
	. += div("notice bold","Contract progress is only counted if this object is slotted in the top right contract slot.")

/obj/item/contract/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("reward")
	SAVEVAR("value_current")
	SAVEVAR("burgerbux_reward")

/obj/item/contract/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("reward")
	LOADVAR("value_current")
	LOADVAR("burgerbux_reward")

/obj/item/contract/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	if(istype(loc,/obj/hud/inventory/organs/groin/pocket/contract))
		var/obj/hud/inventory/organs/groin/pocket/contract/I = loc
		if(is_advanced(I.owner))
			HOOK_ADD("on_kill","on_kill_\ref[src]",I.owner,src,src::on_kill())

/obj/item/contract/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE) //When the object is dropped from the old_inventory
	. = ..()
	if(istype(old_inventory,/obj/hud/inventory/organs/groin/pocket/contract))
		var/obj/hud/inventory/organs/groin/pocket/contract/I = old_inventory
		if(is_advanced(I.owner))
			HOOK_REMOVE("on_kill","on_kill_\ref[src]",I.owner)


/obj/item/contract/proc/turn_in(var/mob/living/advanced/player/P,var/params)
	var/turf/T = get_turf(P)
	if(src.value_current < src.value_max)
		P.to_chat(span("warning","You feel it would be unwise to try to turn in a contract that isn't complete yet!"))
		return FALSE
	var/initial_investment = CEILING(get_value(),10)
	if(burgerbux_reward)
		P.to_chat(span("notice","You are awarded \the [reward.name] and [burgerbux_reward] burgerbux for completing the contract, as well as your initial investment of [initial_investment] credits."))
		P.adjust_burgerbux(burgerbux_reward)
	else
		P.to_chat(span("notice","You are awarded \the [reward.name] for completing the contract. as well as your initial investment of [initial_investment] credits."))
	src.drop_item(T)
	reward.drop_item(T)
	P.put_in_hands(reward,params)
	reward = null //Just in case.
	value_current = 0 //Just in case.
	P.adjust_currency(initial_investment,silent=TRUE)
	qdel(src)
	return TRUE






