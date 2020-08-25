/obj/item/mech_part
	name = "mech part"
	icon = 'icons/mob/living/advanced/mecha/parts.dmi'

	pixel_x = -8

	size = SIZE_8

	var/weight = 0 //The weight of the part.

	health = /health/obj/item/mech_part/

	health_base = 500

	var/list/armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 75,
		ARCANE = -100,
		HEAT = 100,
		COLD = 100,
		BOMB = 50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = -50
	)