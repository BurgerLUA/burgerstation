/ability/
	var/name = "ability"
	var/desc = "What does it do?"
	var/icon = 'icons/hud/ability.dmi'
	var/icon_state = "none"

	var/mana_cost = 100
	var/cooldown = SECONDS_TO_DECISECONDS(1)
	var/cooldown_end = 0

/ability/proc/activate(var/mob/caller)
	var/atom/target
	if(caller.client)
		target = caller.client.last_object
	else if(is_living(caller))
		var/mob/living/L = caller
		if(L.ai)
			target = L.ai.objective_attack
	if(!src.on_cast_pre(caller,target))
		return FALSE
	return src.on_cast(caller,target)

/ability/proc/on_cast_pre(var/mob/caller,var/atom/target)

	if(world.time < cooldown_end)
		return FALSE

	if(caller.health && caller.health.mana_current < mana_cost)
		return FALSE

	caller.health.adjust_mana(-mana_cost)
	cooldown_end = world.time + cooldown

	return TRUE

/ability/proc/on_cast(var/mob/caller,var/atom/target)
	return TRUE


/ability/quick_draw
	name = "Quick Draw"
	desc = "Quickly draws the item in your equipment slot into your dominant hand."
	icon_state = "quick_draw"
	mana_cost = 0
	cooldown = SECONDS_TO_DECISECONDS(1)
	var/attack_too = FALSE

/ability/quick_draw/on_cast_pre(var/mob/caller,var/atom/target)

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	if(!A.inventories_by_id[BODY_TORSO_OB])
		return FALSE

	var/obj/hud/inventory/I = A.inventories_by_id[BODY_TORSO_OB]

	var/obj/item/I2 = I.get_top_object()
	if(!istype(I2))
		return FALSE

	. = ..()

	if(. && A.put_in_hands(I2))
		if(attack_too)
			var/obj/hud/inventory/new_inventory = I2.loc
			if(!new_inventory)
				return FALSE
			var/location
			var/params
			if(A.client)
				location = A.client.last_location
				params = A.client.last_params
			I2.click_on_object(caller,target,location,null,params)
		return TRUE


/ability/quick_draw/plus
	name = "Quick Draw+"
	desc = "Quickly draws the item in your equipment slot into your dominant hand. If the item is a weapon, attempt an attack on the target location."
	attack_too = TRUE
	mana_cost = 20