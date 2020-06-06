/mob/living/vehicle/mech
	name = "mech"
	desc = "Weaponized Anime"
	icon = 'icons/obj/vehicles/mechs.dmi'

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	anchored = 1

	movement_delay = 10

	footstep_override_id = "mech_step"

/mob/living/vehicle/mech/post_death()
	. = ..()
	update_sprite()
	return .

/mob/living/vehicle/mech/get_movement_delay()
	return movement_delay

/mob/living/vehicle/mech/update_icon()

	icon_state = initial(icon_state)

	if(dead)
		icon_state = "[icon_state]_dead"
	else if(!length(passengers) || !passengers[1])
		icon_state = "[icon_state]_open"

	..()

/mob/living/vehicle/mech/ripley
	name = "\improper APLU Ripley"
	desc = "Ripley"

	icon_state = "ripley"


/mob/living/vehicle/mech/ripley/full

/mob/living/vehicle/mech/ripley/full/New(var/desired_loc)
	..()
	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U1 = new(src.loc)
	INITIALIZE(U1)
	GENERATE(U1)
	attach_equipment(U1)

	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U2 = new(src.loc)
	INITIALIZE(U2)
	GENERATE(U2)
	attach_equipment(U2)

/mob/living/vehicle/mech/gygax
	name = "\improper MK2 Gygax"
	desc = "An upgraded version of the Gygax we all know and love."
	icon = 'icons/obj/vehicles/gygax.dmi'
	icon_state = "gygax"

	pixel_x = -1

	armor_base = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 15,
		LASER = 25,
		MAGIC = -100,
		HEAT = 25,
		COLD = 25,
		BOMB = 15,
		BIO = INFINITY,
		RAD = 75,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	class = "gygax"

	health_base = 500


/mob/living/vehicle/mech/gygax/equipped/New(var/desired_loc)
	..()
	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U1 = new(src.loc)
	attach_equipment(U1)
	var/obj/item/weapon/ranged/energy/mech/smg/mk2/U2 = new(src.loc)
	attach_equipment(U2)

/mob/living/vehicle/mech/durand
	name = "\improper MK2 Durand"
	desc = "An upgraded version of the Durand we all know and love."
	icon = 'icons/obj/vehicles/durand.dmi'
	icon_state = "durand"

	pixel_x = -4

	armor_base = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 15,
		MAGIC = -100,
		HEAT = 15,
		COLD = 15,
		BOMB = 50,
		BIO = INFINITY,
		RAD = 25,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	class = "durand"

	health_base = 1500


/mob/living/vehicle/mech/durand/equipped/New(var/desired_loc)
	..()
	var/obj/item/weapon/ranged/energy/mech/smg/mk2/U1 = new(src.loc)
	INITIALIZE(U1)
	GENERATE(U1)
	attach_equipment(U1)
	var/obj/item/weapon/ranged/energy/mech/smg/mk3/U2 = new(src.loc)
	INITIALIZE(U2)
	GENERATE(U2)
	attach_equipment(U2)