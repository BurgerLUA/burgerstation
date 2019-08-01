/mob/living/simple/npc/crab
	name = "crab"
	icon = 'icons/mob/living/simple/crab.dmi'
	icon_state = "crab"
	damage_type = "crab_claw"
	class = "crab"

	ai = /ai/crab

	stun_angle = 180

	loot_drop = "crab"

/mob/living/simple/npc/crab/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()

/mob/living/simple/npc/crab/passive
	ai = /ai/passive
	can_attack_while_moving = FALSE

/mob/living/simple/npc/crab/king
	name = "king crab"
	desc = "A crab this size must be the work of some maniac."
	desc_extended = "A ferocious king crab with massive sharp claws and a thick magic and bullet deflecting outer shell. You'll likely have to get up close and personal in order to crack this crab."
	id = "crab_king"
	icon = 'icons/mob/living/simple/crab_king.dmi'
	icon_state = "king"
	pixel_x = -32
	pixel_y = 0

	health_base = 750

	ai = /ai/king_crab

	class = "crab_king"
	loot_drop = "crab_king"

	level_multiplier = 40

	attack_range = 3

	collision_flags = FLAG_COLLISION_REAL

	boss = TRUE
	boss_music = "crab"

/mob/living/simple/npc/crab/king/can_collide_with(var/atom/A)
	if(istype(src,A))
		return FALSE

	return ..()

/mob/living/simple/npc/crab/king/get_dodge_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	return 0

/mob/living/simple/npc/crab/king/get_block_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	switch(DT.get_attack_type())
		if(ATTACK_TYPE_MELEE)
			return 0

		if(ATTACK_TYPE_RANGED)
			return 90

		if(ATTACK_TYPE_MAGIC)
			return 75

	return 0

/mob/living/simple/npc/crab/king/get_movement_delay()
	return SECONDS_TO_TICKS(1)

/mob/living/simple/npc/crab/king/get_attack_delay()
	return SECONDS_TO_DECISECONDS(1)

