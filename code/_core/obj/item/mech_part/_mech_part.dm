/obj/item/mech_part
	name = "mech part"
	icon = 'icons/mob/living/advanced/mecha/parts.dmi'

	pixel_x = -8

	size = SIZE_8

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
		ION = -50,
		PAIN = INFINITY
	)

/obj/item/mech_part/update_sprite()

	if(istype(src.loc,/mob/living/vehicle/mech/modular))
		pixel_x = 0
		pixel_y = 0
	else
		pixel_x = initial(pixel_x)
		pixel_y = initial(pixel_y)

	return ..()

/obj/item/mech_part/can_be_attacked()
	return TRUE