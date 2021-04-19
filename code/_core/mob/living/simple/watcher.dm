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
		BLADE = -20,
		PIERCE = -20,
		ARCANE = AP_GREATSWORD,
		HEAT = AP_CLUB,
		COLD = AP_GREATSWORD,
		FATIGUE = 20,
		ION = INFINITY,
		PAIN = AP_GREATAXE
	)

	status_immune = list(
		FIRE = TRUE
	)

	iff_tag = "Watcher"
	loyalty_tag = "Watcher"

	size = SIZE_LARGE

	pixel_x = -12

	health_base = 75

	blood_type = /reagent/blood/ancient
	blood_volume = 200

	soul_size = SOUL_SIZE_COMMON

/mob/living/simple/watcher/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/watcher/clockwork
	name = "clockwork watcher"
	desc = "Eye see you."
	desc_extended = "A robotic watcher that serves the clockwork army."
	icon = 'icons/mob/living/simple/clockwork_watcher.dmi'
	icon_state = "warden"

	anchored = TRUE

	iff_tag = "Clockwork"
	loyalty_tag = "Clockwork"

	class = /class/clockwork_watcher

	ai = /ai/watcher/clockwork

	blood_type = /reagent/blood/robot

	health_base = 200

	pixel_x = 0

	size = SIZE_LARGE

	status_immune = list()

	armor_base = list(
		BLADE = 20,
		PIERCE = 20,
		ARCANE = AP_GREATSWORD,
		HEAT = -20,
		COLD = AP_GREATSWORD,
		FATIGUE = INFINITY,
		ION = 0,
		PAIN = INFINITY
	)

/mob/living/simple/watcher/clockwork/post_death()
	. = ..()
	anchored = FALSE


/mob/living/simple/watcher/clockwork_mobile
	name = "clockwork floater"
	desc = "Eye see you."
	desc_extended = "A robotic prototype watcher that serves the clockwork army."
	icon = 'icons/mob/living/simple/clockwork_floater.dmi'
	icon_state = "floater"

	iff_tag = "Clockwork"
	loyalty_tag = "Clockwork"

	movement_delay = 1 // Fast

	class = /class/clockwork_watcher

	ai = /ai/watcher/clockwork

	blood_type = /reagent/blood/robot

	health_base = 50 //Low HP

	pixel_x = 0

	size = SIZE_LARGE

	status_immune = list()

	armor_base = list(
		BLADE = 20,
		PIERCE = 20,
		ARCANE = AP_GREATSWORD,
		HEAT = -20,
		COLD = AP_GREATSWORD,
		FATIGUE = INFINITY,
		ION = 0,
		PAIN = INFINITY
	)