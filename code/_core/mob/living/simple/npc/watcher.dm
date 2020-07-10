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
		BLADE = 0,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 50,
		MAGIC = 75,
		HEAT = 25,
		COLD = 75,
		BOMB = 0,
		BIO = 75,
		RAD = 50,
		HOLY = 50,
		DARK = 75,
		FATIGUE = 25
	)

	status_immune = list(
		FIRE = TRUE
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