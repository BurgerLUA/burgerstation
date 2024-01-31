
/*
/mob/living/advanced/proc/add_species_health_elements()

	var/species/S = SPECIES(species)

	for(var/v in S.spawning_health)
		var/obj/hud/button/B = v
		B = new B
		B.update_owner(src)
*/

/mob/living/advanced/on_damage_received(atom/atom_damaged,atom/attacker,atom/weapon,damagetype/DT,list/damage_table,damage_amount,critical_hit_multiplier,stealthy=FALSE)

	. = ..()

	HOOK_CALL("on_damage_received") //For hulking and whatnot.