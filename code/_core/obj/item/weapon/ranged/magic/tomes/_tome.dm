/obj/item/weapon/ranged/magic/tome/
	name = "spell tome"
	desc = "What secrets does this tome hold?"
	desc_extended = "A weapon that uses mana to cast spells."

	var/mana_cost = 100 //Base cost per cast

	var/associated_skill = SKILL_MAGIC_OFFENSIVE

	has_quick_function = TRUE

/obj/item/weapon/ranged/magic/tome/quick(var/mob/caller as mob,var/atom/object,location,params)
	shoot(caller,object,location,params)
	return TRUE

/obj/item/weapon/ranged/magic/tome/proc/get_mana_cost()
	var/mob/living/advanced/A = get_owner()
	if(!is_advanced(A))
		return mana_cost * NPC_MANA_COST_MULTIPLIER

	return mana_cost * (1 - (A.get_skill_level(associated_skill)/200))

/obj/item/weapon/ranged/magic/tome/get_owner()
	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		return I.owner

	return null

/obj/item/weapon/ranged/magic/tome/get_ammo_count()
	return get_owner() && mana_cost ? floor(get_owner().mana_current / get_mana_cost()) : 0


/obj/item/weapon/ranged/magic/tome/handle_ammo(var/mob/caller as mob,var/atom/object,location,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller
	A.adjust_mana(-get_mana_cost())
	A.update_health_element_icons(mana=TRUE)