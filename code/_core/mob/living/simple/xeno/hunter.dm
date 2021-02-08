/mob/living/simple/xeno/hunter
	name = "xeno hunter"
	icon = 'icons/mob/living/simple/alien_hunter.dmi'

	health_base = 50
	stamina_base = 200
	mana_base = 50

	level_multiplier = 2

	movement_delay = 2

	armor_base = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		HEAT = AP_DAGGER,
		COLD = AP_GREATSWORD,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	can_leap = TRUE

	blood_type = /reagent/blood/xeno
	blood_volume = 480

/mob/living/simple/xeno/drone
	name = "xeno drone"
	icon = 'icons/mob/living/simple/alien_drone.dmi'

	health_base = 100
	stamina_base = 200
	mana_base = 50

	movement_delay = 3

	armor_base = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		HEAT = AP_DAGGER,
		COLD = AP_GREATSWORD,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	can_leap = TRUE

	blood_type = /reagent/blood/xeno
	blood_volume = 480

/mob/living/simple/xeno/sentinel
	name = "xeno sentinel"
	icon = 'icons/mob/living/simple/alien_drone.dmi'

	level_multiplier = 4

	health_base = 150

	movement_delay = 1

	armor_base = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		HEAT = AP_DAGGER,
		COLD = AP_GREATSWORD,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	can_spit = TRUE

	movement_delay = 4

	blood_type = /reagent/blood/xeno
	blood_volume = 480
