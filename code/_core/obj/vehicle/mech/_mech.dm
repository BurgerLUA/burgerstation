/mob/living/vehicle/mech
	name = "mech"
	desc = "Weaponized Anime"
	icon = 'icons/obj/vehicles/mechs.dmi'

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	anchored = 1

	movement_delay = 10


/mob/living/vehicle/mech/post_death()
	. = ..()
	update_sprite()
	return .

/mob/living/vehicle/mech/get_movement_delay()
	. = movement_delay
	return . * (2 - get_attribute_power(ATTRIBUTE_AGILITY))

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
	SPAWN(U1)
	attach_equipment(U1)

	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U2 = new(src.loc)
	INITIALIZE(U2)
	SPAWN(U2)
	attach_equipment(U2)

/mob/living/vehicle/mech/gygax
	name = "\improper MK2 Gygax"
	desc = "An upgraded version of the Gygax we all know and love."
	icon = 'icons/obj/vehicles/gygax.dmi'
	icon_state = "gygax"

	pixel_x = -1

	armor_base = list(
		BLADE = ARMOR_B,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_D,
		LASER = ARMOR_C,
		MAGIC = -ARMOR_S,
		HEAT = ARMOR_C,
		COLD = ARMOR_C,
		BOMB = ARMOR_D,
		BIO = ARMOR_X,
		RAD = ARMOR_A,
		HOLY = ARMOR_X,
		DARK = ARMOR_X,
		FATIGUE = ARMOR_X
	)

	class = "gygax"


/mob/living/vehicle/mech/gygax/equipped/New(var/desired_loc)
	..()
	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U1 = new(src.loc)
	INITIALIZE(U1)
	SPAWN(U1)
	attach_equipment(U1)
	var/obj/item/weapon/ranged/energy/mech/smg/mk2/U2 = new(src.loc)
	INITIALIZE(U2)
	SPAWN(U2)
	attach_equipment(U2)



/mob/living/vehicle/mech/durand
	name = "\improper MK2 Durand"
	desc = "An upgraded version of the Durand we all know and love."
	icon = 'icons/obj/vehicles/durand.dmi'
	icon_state = "durand"

	pixel_x = -4

	armor_base = list(
		BLADE = ARMOR_A,
		BLUNT = ARMOR_B,
		PIERCE = ARMOR_B,
		LASER = ARMOR_D,
		MAGIC = -ARMOR_S,
		HEAT = ARMOR_D,
		COLD = ARMOR_D,
		BOMB = ARMOR_B,
		BIO = ARMOR_X,
		RAD = ARMOR_C,
		HOLY = ARMOR_X,
		DARK = ARMOR_X,
		FATIGUE = ARMOR_X
	)

	class = "durand"


/mob/living/vehicle/mech/durand/equipped/New(var/desired_loc)
	..()
	var/obj/item/weapon/ranged/energy/mech/smg/mk2/U1 = new(src.loc)
	INITIALIZE(U1)
	SPAWN(U1)
	attach_equipment(U1)
	var/obj/item/weapon/ranged/energy/mech/smg/mk3/U2 = new(src.loc)
	INITIALIZE(U2)
	SPAWN(U2)
	attach_equipment(U2)