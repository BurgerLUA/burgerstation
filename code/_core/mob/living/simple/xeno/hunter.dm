/mob/living/simple/xeno/hunter
	name = "xeno hunter"
	icon = 'icons/mob/living/simple/alien_hunter.dmi'

	health_base = 50
	stamina_base = 200
	mana_base = 50



	movement_delay = 1

	armor_base = list(
		BLADE = 10,
		BLUNT = 60,
		PIERCE = 60,
		HEAT = 10,
		COLD = 80,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

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

	armor_base = list(
		BLADE = 10,
		BLUNT = 60,
		PIERCE = 60,
		HEAT = 10,
		COLD = 80,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	can_leap = TRUE

	blood_type = /reagent/blood/xeno
	blood_volume = 480

	level = 20

/mob/living/simple/xeno/sentinel
	name = "xeno sentinel"
	icon = 'icons/mob/living/simple/alien_drone.dmi'

	health_base = 150

	movement_delay = 2

	armor_base = list(
		BLADE = 10,
		BLUNT = 60,
		PIERCE = 60,
		HEAT = 10,
		COLD = 80,
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

	level = 20



/mob/living/simple/xeno/predatorian
	name = "xeno predatorian"
	icon = 'icons/mob/living/simple/alien_predatorian.dmi'

	health_base = 400
	stamina_base = 200
	mana_base = 50

	movement_delay = 4

	armor_base = list(
		BLADE = 10,
		BLUNT = 60,
		PIERCE = 60,
		HEAT = 10,
		COLD = 80,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	can_spit = FALSE
	can_leap = FALSE

	blood_type = /reagent/blood/xeno
	blood_volume = 480

	level = 30