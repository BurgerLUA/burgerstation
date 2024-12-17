
/*
/mob/living/advanced/proc/add_species_health_elements()

	var/species/S = SPECIES(species)

	for(var/v in S.spawning_health)
		var/obj/hud/button/B = v
		B = new B
		B.update_owner(src)
*/

/mob/living/advanced/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount > 0)
		var/mana_armor_value = STATUS_EFFECT_MAGNITUDE(src,MANA_ARMOR)
		if(mana_armor_value > 0 && src.health && src.health.mana_current > src.health.mana_current*0.5 && length(src.overall_clothing_defense_rating[ARCANE]) > 0 && length(damage_table))
			var/total_brute = SAFENUM(damage_table[BLUNT]) + SAFENUM(damage_table[PIERCE]) + SAFENUM(damage_table[BLADE])
			if(total_brute > 0)
				src.health.adjust_mana(-total_brute)

	HOOK_CALL("on_damage_received") //For hulking and whatnot.