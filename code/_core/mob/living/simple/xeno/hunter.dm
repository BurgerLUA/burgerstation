/mob/living/simple/xeno/hunter
	name = "xeno hunter"
	icon = 'icons/mob/living/simple/alien_hunter.dmi'

	health_base = 50
	stamina_base = 200
	mana_base = 50



	movement_delay = 1

	can_leap = TRUE

	blood_type = /reagent/blood/xeno
	blood_volume = 480

	level = 26

/mob/living/simple/xeno/drone
	name = "xeno drone"
	icon = 'icons/mob/living/simple/alien_drone.dmi'

	health_base = 100
	stamina_base = 200
	mana_base = 50

	movement_delay = 3

	can_leap = TRUE

	blood_type = /reagent/blood/xeno
	blood_volume = 480

	level = 20

/mob/living/simple/xeno/sentinel
	name = "xeno sentinel"
	icon = 'icons/mob/living/simple/alien_drone.dmi'

	health_base = 150

	movement_delay = 2

	can_spit = TRUE

	movement_delay = 4

	blood_type = /reagent/blood/xeno
	blood_volume = 480

	level = 20



/mob/living/simple/xeno/predatorian
	name = "xeno predatorian"
	icon = 'icons/mob/living/simple/alien_predatorian.dmi'

	health_base = 400
	stamina_base = 200
	mana_base = 50

	movement_delay = 4

	can_spit = FALSE
	can_leap = FALSE

	blood_type = /reagent/blood/xeno
	blood_volume = 480

	level = 30