/mob/living/vehicle/mech
	name = "mech"
	desc = "Weaponized Anime."
	desc_extended = "A humanoid armoured weapons platform that can be modified with an array of different parts and weapon modules to navigate and perform in any environment. Manufactures its own ammo using internal battery power, making it highly self-sufficient and expensive."
	icon = 'icons/obj/vehicles/mechs.dmi'

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	anchored = TRUE

	movement_delay = DECISECONDS_TO_TICKS(4)

	change_dir_on_move = FALSE

	blood_type = /reagent/blood/robot
	blood_volume = 1000

	mob_size = MOB_SIZE_LARGE

/mob/living/vehicle/mech/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps + /footstep/mech_step

/mob/living/vehicle/mech/set_dir(var/desired_dir,var/force=FALSE)

	. = ..()

	if(.)
		var/turf/T = get_turf(src)
		play('sound/effects/footsteps/mechmove.ogg',)
		if(length(passengers) && passengers[1])
			create_alert(VIEW_RANGE,T,passengers[1],ALERT_LEVEL_NOISE)

	return .

/mob/living/vehicle/mech/Move(NewLoc,Dir=0,step_x=0,step_y=0)
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
	else if(!ai && !length(passengers))
		icon_state = "[icon_state]_open"

	..()

/mob/living/vehicle/mech/ripley
	name = "\improper APLU Ripley Combat Mech"
	desc = "Ripley"

	icon_state = "ripley"

	movement_delay = DECISECONDS_TO_TICKS(4)

	health_base = 1000

	armor_base = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
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


/mob/living/vehicle/mech/gygax
	name = "\improper Gygax Combat Mech"
	desc = "An upgraded version of the Gygax we all know and love."
	icon = 'icons/obj/vehicles/gygax.dmi'
	icon_state = "gygax"

	pixel_x = -1

	armor_base = list(
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

	class = /class/gygax/

	health_base = 1500

	movement_delay = DECISECONDS_TO_TICKS(3)

/mob/living/vehicle/mech/gygax/dark
	name = "\improper DARK Gygax Combat Mech"
	desc = "A syndicate owned Dark Gygax. These are usually controlled by AI."
	icon = 'icons/obj/vehicles/gygax_dark.dmi'
	icon_state = "dark_gygax"

	pixel_x = 0
	pixel_y = 0

	health_base = 2000

	ai = /ai/mech

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

/mob/living/vehicle/mech/gygax/dark/Generate()
	. = ..()

	var/obj/item/weapon/ranged/energy/mech/smg/M1 = new(src.loc)
	M1.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate
	INITIALIZE(M1)
	GENERATE(M1)
	FINALIZE(M1)
	src.attach_equipment(null,M1)

	var/obj/item/weapon/ranged/energy/mech/smg/M2 = new(src.loc)
	M2.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate
	INITIALIZE(M2)
	GENERATE(M2)
	FINALIZE(M2)
	src.attach_equipment(null,M2)

	return .


/mob/living/vehicle/mech/durand
	name = "\improper MK2 Durand"
	desc = "An upgraded version of the Durand we all know and love."
	icon = 'icons/obj/vehicles/durand.dmi'
	icon_state = "durand"

	pixel_x = -4

	armor_base = list(
		BLADE = 100,
		BLUNT = 100,
		PIERCE = 100,
		LASER = 25,
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

	class = /class/durand
	health_base = 3000

	movement_delay = DECISECONDS_TO_TICKS(6)