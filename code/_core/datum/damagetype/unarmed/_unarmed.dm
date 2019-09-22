/damagetype/unarmed/
	name = "Body"
	desc = "Your body deals damage."

	skill_xp_per_damage = list(
		SKILL_UNARMED = 1,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

	draw_blood = TRUE


/damagetype/unarmed/do_wound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_dealt)

	if(is_organ(hit_object))
		new/wound/bruise/(victim,hit_object,attacker,weapon,damage_dealt/20)
		if(damage_dealt > 30)
			new/wound/abration(victim,hit_object,attacker,weapon,damage_dealt/40)

		return TRUE

	return FALSE