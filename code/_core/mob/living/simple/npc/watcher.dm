/mob/living/simple/npc/watcher
	name = "watcher"
	icon = 'icons/mob/living/simple/lavaland/watcher.dmi'
	icon_state = "watcher"
	damage_type = /damagetype/unarmed/claw/
	class = /class/watcher

	value = 100

	ai = /ai/watcher

	stun_angle = 0

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 50,
		LASER = 25,
		MAGIC = 75,
		HEAT = 50,
		COLD = 100,
		BOMB = 0,
		BIO = 25,
		RAD = 25,
		HOLY = 50,
		DARK = 50,
		FATIGUE = 75
	)

	status_immune = list(
		FIRE = FALSE
	)

	iff_tag = "watcher"
	loyalty_tag = "watcher"

	mob_size = MOB_SIZE_LARGE

	pixel_x = -12

	health_base = 100

/mob/living/simple/npc/watcher/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()