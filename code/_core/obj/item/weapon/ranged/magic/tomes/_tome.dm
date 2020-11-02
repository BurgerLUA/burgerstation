/obj/item/weapon/ranged/magic/tome/
	name = "spell tome"
	desc = "What secrets does this tome hold?"
	desc_extended = "A weapon that uses mana to cast spells."

	has_quick_function = TRUE

	weight = 6

/obj/item/weapon/ranged/magic/tome/get_static_spread()
	return 0

/obj/item/weapon/ranged/magic/tome/get_skill_spread(var/mob/living/L)
	return 0

/obj/item/weapon/ranged/magic/tome/quick(var/mob/caller as mob,var/atom/object,location,params)
	shoot(caller,object,location,params)
	return TRUE

/obj/item/weapon/ranged/magic/tome/proc/get_mana_cost(var/mob/living/caster)
	return cost_mana

/obj/item/weapon/ranged/magic/tome/get_owner()

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		return I.owner

	return null

/obj/item/weapon/ranged/magic/tome/can_gun_shoot(var/mob/caller)

	if(get_ammo_count() < 1)
		return FALSE

	return ..()

/obj/item/weapon/ranged/magic/tome/get_ammo_count()

	var/mob/living/owner = get_owner()

	if(!owner)
		return 0

	if(!owner.health)
		return 1

	var/actual_mana_cost = get_mana_cost(owner)

	if(!actual_mana_cost)
		return 1

	return owner && actual_mana_cost ? FLOOR(owner.health.mana_current / actual_mana_cost, 1) : 0


/obj/item/weapon/ranged/magic/tome/handle_ammo(var/mob/caller,var/bullet_position=1)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller
	if(!A.health)
		return ..()

	var/mana_cost = get_mana_cost(A)

	A.health.adjust_mana(-mana_cost)

	A.update_health_element_icons(mana=TRUE)

	A.mana_regen_delay = max(A.mana_regen_delay,30)

	return null


/*
/obj/item/weapon/ranged/magic/tome/do_automatic(var/mob/caller,var/atom/object,location,params)

	if(!automatic || (object && object.plane >= PLANE_HUD) || !is_advanced(caller))
		return TRUE

	var/mob/living/advanced/A = caller

	power_current = clamp(power_current + power_gain,0,power_max)

	A.mana_regen_delay = max(A.mana_regen_delay,30)

	if(!A.health.adjust_mana(-power_gain))
		on_mouse_up(caller,object,location,params,TRUE)

	A.update_health_element_icons(mana=TRUE)

	return TRUE
*/

/*
/obj/item/weapon/ranged/magic/tome/on_mouse_up(var/mob/caller,var/atom/object,location,control,params,var/secret_bypass=FALSE)

	if(!automatic || !is_advanced(caller))
		return TRUE

	var/mob/living/advanced/A = caller

	var/damage_mod = clamp(power_current/power_max,0,1)

	if(object && object.plane < PLANE_HUD && damage_mod >= 0.25)
		shoot(caller,object,location,params,damage_mod)
	else if(secret_bypass)
		A.health.adjust_mana(power_current)
		A.update_health_element_icons(mana=TRUE)

	power_current = 0

	return TRUE
*/