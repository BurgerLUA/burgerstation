/obj/item/weapon/ranged/magic/tome/
	name = "spell tome"
	desc = "What secrets does this tome hold?"
	desc_extended = "A weapon that uses mana to cast spells."

	var/associated_skill = SKILL_MAGIC_OFFENSIVE

	has_quick_function = TRUE

	var/power_gain = 10
	var/power_current = 0
	var/power_max = 100

/obj/item/weapon/ranged/magic/tome/quick(var/mob/caller as mob,var/atom/object,location,params)
	shoot(caller,object,location,params)
	return TRUE

/obj/item/weapon/ranged/magic/tome/proc/get_mana_cost(var/mob/living/caster)

	if(!is_advanced(caster))
		return cost_mana * NPC_MANA_COST_MULTIPLIER

	var/mob/living/advanced/A = caster

	return cost_mana * (1 - (A.get_skill_level(associated_skill)/200))

/obj/item/weapon/ranged/magic/tome/get_owner()

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		return I.owner

	return null

/obj/item/weapon/ranged/magic/tome/get_ammo_count()

	var/mob/living/owner = get_owner()

	if(!owner.health)
		return 1

	var/actual_mana_cost = get_mana_cost()

	if(!actual_mana_cost)
		return 1

	return owner && actual_mana_cost ? floor(owner.health.mana_current / actual_mana_cost) : 0


/obj/item/weapon/ranged/magic/tome/handle_ammo(var/mob/caller as mob,var/atom/object,location,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller
	if(!A.health)
		return ..()

	if(!automatic)
		A.health.adjust_mana(-get_mana_cost())

	A.update_health_element_icons(mana=TRUE)

/obj/item/weapon/ranged/magic/tome/do_automatic(var/mob/caller,var/atom/object,location,params)

	if(!automatic || (object && object.plane >= PLANE_HUD) || !is_advanced(caller))
		return TRUE

	var/mob/living/advanced/A = caller

	power_current = Clamp(power_current + power_gain,0,power_max)

	A.health.adjust_mana(-1)
	A.update_health_element_icons(mana=TRUE)

	return TRUE

/obj/item/weapon/ranged/magic/tome/on_mouse_up(var/mob/caller,var/atom/object,location,control,params)

	if(!automatic)
		return TRUE

	var/damage_mod = Clamp(power_current/power_max,0.5,1)

	world.log << damage_mod

	shoot(caller,object,location,params,damage_mod)
	power_current = 0

	return TRUE