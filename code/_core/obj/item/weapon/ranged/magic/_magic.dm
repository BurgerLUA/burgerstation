/obj/item/weapon/ranged/magic

	var/cost_mana = 0
	var/cost_charge = 0
	var/total_charge = 100
	var/cooldown = 60 //In deciseconds


	var/current_cooldown = 0

	automatic = FALSE

	block_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 1
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 0,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

/obj/item/weapon/ranged/magic/handle_ammo(caller)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.mana_regen_delay = max(A.mana_regen_delay,30)

	return null