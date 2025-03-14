/mob/living/simple/watcher
	name = "watcher"
	icon = 'icons/mob/living/simple/lavaland/watcher.dmi'
	icon_state = "watcher"
	damage_type = /damagetype/unarmed/claw/


	value = 100

	health_base = 100
	stamina_base = 200
	mana_base = 400

	ai = /ai/watcher

	stun_angle = 0

	armor = /armor/insect

	status_immune = list(
		FIRE = TRUE
	)

	iff_tag = "Watcher"
	loyalty_tag = "Watcher"

	size = SIZE_GIANT

	pixel_x = -12

	health_base = 75

	blood_type = /reagent/blood/ancient
	blood_volume = 200

	level = 8

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



	ai = /ai/watcher/clockwork

	blood_type = /reagent/blood/robot

	health_base = 200

	pixel_x = 0

	size = SIZE_GIANT

	status_immune = list()

	armor = /armor/brass_construct

	level = 12

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

	ai = /ai/watcher/clockwork

	blood_type = /reagent/blood/robot

	health_base = 50 //Low HP

	pixel_x = 0

	size = SIZE_GIANT

	status_immune = list()

	armor = /armor/brass_construct