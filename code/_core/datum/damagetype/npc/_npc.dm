/damagetype/npc/

	draw_blood = TRUE

	savage_hit_threshold = 0.4

	animate = TRUE

	can_be_parried = TRUE

/damagetype/npc/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("warning","You hear bone hitting flesh.")