/mob/living/simple/watcher
	name = "watcher"
	icon = 'icons/mob/living/simple/lavaland/watcher.dmi'
	icon_state = "watcher"
	damage_type = /damagetype/unarmed/claw/
	class = /class/watcher

	value = 100

	health_base = 100
	stamina_base = 200
	mana_base = 400

	ai = /ai/watcher

	stun_angle = 0

	armor_base = list(
		BLADE = -AP_SWORD,
		PIERCE = -AP_SWORD,
		ARCANE = AP_GREATSWORD,
		HEAT = AP_CLUB,
		COLD = AP_GREATSWORD,
		FATIGUE = AP_SWORD,
		ION = INFINITY,
		PAIN = AP_GREATAXE
	)

	status_immune = list(
		FIRE = TRUE
	)

	iff_tag = "Watcher"
	loyalty_tag = "Watcher"

	mob_size = MOB_SIZE_LARGE

	pixel_x = -12

	health_base = 75

	blood_type = /reagent/blood/ancient
	blood_volume = 200

/mob/living/simple/watcher/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()
	return .