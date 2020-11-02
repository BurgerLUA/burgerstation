/mob/living/simple/npc/bat
	name = "cave bat"
	desc = "Spooky!"
	desc_extended = "A very aggressive cave bat."
	icon = 'icons/mob/living/simple/bat.dmi'
	icon_state = "living"

	health_base = 20

	damage_type = /damagetype/unarmed/bite/
	class = /class/crab

	collision_bullet_flags = FLAG_COLLISION_SPECIFIC

	stun_angle = 0

/mob/living/simple/npc/bat/post_death()
	. = ..()
	icon_state = "dead"
	return .