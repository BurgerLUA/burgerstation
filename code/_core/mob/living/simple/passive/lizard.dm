/mob/living/simple/passive/lizard
	name = "lizard"
	desc = "*Lizard Sounds*"
	desc_extended = "A harmles lizard."
	icon = 'icons/mob/living/simple/lizard.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/bite/
	class = /class/crab
	collision_bullet_flags = FLAG_COLLISION_SPECIFIC

	health_base = 20

	stun_angle = 0

/mob/living/simple/passive/lizard/Crossed(atom/movable/O)
	return TRUE

/mob/living/simple/passive/lizard/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()
	return .