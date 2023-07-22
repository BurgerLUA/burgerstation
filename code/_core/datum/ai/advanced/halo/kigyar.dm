/ai/advanced/halo/kigyar
	enemy_tags = list("NanoTrasen","Syndicate")
	should_find_weapon = TRUE
	roaming_distance = 10
	aggression = 2
	assistance = 1

	var/language_to_use = LANGUAGE_BASIC

/ai/advanced/halo/kigyar/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount >= 10 && . && prob(40))
		if(prob(10) && get_dist(owner,attacker) >= 3)
			var/attack_dir = dir2text(get_dir(owner,attacker))
			owner.do_say("Taking fire from the [attack_dir]!")
		else
			var/list/responses = list(
				"They got my [atom_damaged.name]!",
				"They hit me in the [atom_damaged.name]!",
			)
			owner.do_say(pick(responses),language_to_use = language_to_use)

	return .

/ai/advanced/halo/kigyar/lobby
	active = TRUE