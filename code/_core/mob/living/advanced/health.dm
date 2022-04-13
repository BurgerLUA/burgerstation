
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

	if(!dead && damage_amount > 10 && prob(damage_amount*0.3))
		src.send_pain(damage_amount)

	HOOK_CALL("on_damage_received") //For hulking and whatnot.

