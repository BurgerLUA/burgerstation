/damagetype/melee/
	draw_blood = TRUE
	draw_weapon = TRUE

	damage_mod = 1
	penetration_mod = 1

	experience_mod = 2

	bonus_experience_skill = list(
		SKILL_MELEE = 50 //50%
	)

	bonus_experience_attribute = list(
		ATTRIBUTE_DEXTERITY = 25, //25%
		ATTRIBUTE_STRENGTH = 25, //25%
	)

	var/condition_on_hit = TRUE

	savage_hit_threshold = 0.1


/damagetype/melee/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	. = ..()
	if(condition_on_hit && is_item(weapon))
		var/obj/item/I = weapon
		I.use_condition(1)