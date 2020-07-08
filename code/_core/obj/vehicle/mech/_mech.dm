/mob/living/vehicle/mech
	name = "mech"
	desc = "Weaponized Anime"
	icon = 'icons/obj/vehicles/mechs.dmi'

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	anchored = 1

	movement_delay = DECISECONDS_TO_TICKS(4)

	change_dir_on_move = FALSE


/mob/living/vehicle/mech/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps + /footstep/mech_step

/mob/living/vehicle/mech/set_dir(var/desired_dir,var/force=FALSE)

	. = ..()

	if(.)
		play('sound/effects/footsteps/mechmove.ogg',get_turf(src))
		if(length(passengers) && passengers[1])
			create_alert(VIEW_RANGE,src,passengers[1],ALERT_LEVEL_NOISE)

	return .

/mob/living/vehicle/mech/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0,var/silent=FALSE)
	var/real_dir = get_dir(src,NewLoc)
	if(real_dir & dir)
		return ..()
	set_dir(real_dir)
	return FALSE

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
	name = "\improper APLU Ripley Combat Mech"
	desc = "Ripley"

	icon_state = "ripley"

	movement_delay = DECISECONDS_TO_TICKS(6)

	health_base = 1000

/mob/living/vehicle/mech/ripley/equipped/Generate()
	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U1 = new(src.loc)
	INITIALIZE(U1)
	GENERATE(U1)
	attach_equipment(U1)

	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U2 = new(src.loc)
	INITIALIZE(U2)
	GENERATE(U2)
	attach_equipment(U2)
	return ..()

/mob/living/vehicle/mech/gygax
	name = "\improper Gygax Combat Mech"
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

	class = /class/gygax/

	health_base = 1500

	movement_delay = DECISECONDS_TO_TICKS(5)

/mob/living/vehicle/mech/gygax/equipped/Generate()
	var/obj/item/weapon/ranged/energy/mech/smg/mk2/U1 = new(src.loc)
	INITIALIZE(U1)
	GENERATE(U1)
	attach_equipment(U1)

	var/obj/item/weapon/ranged/energy/recharging/captain/U2 = new(src.loc)
	INITIALIZE(U2)
	GENERATE(U2)
	attach_equipment(U2)
	return ..()

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

	class = /class/durand
	health_base = 3000

	movement_delay = DECISECONDS_TO_TICKS(8)


/mob/living/vehicle/mech/durand/equipped/Generate()
	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U1 = new(src.loc)
	INITIALIZE(U1)
	GENERATE(U1)
	attach_equipment(U1)

	var/obj/item/weapon/ranged/energy/mech/smg/mk1/U2 = new(src.loc)
	INITIALIZE(U2)
	GENERATE(U2)
	attach_equipment(U2)
	return ..()