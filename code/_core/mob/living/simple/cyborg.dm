/mob/living/simple/silicon/
	name = "robot"
	icon = 'icons/mob/living/simple/robots.dmi'
	icon_state = "robot_old"

	ai = /ai/

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/robot
	blood_volume = 500

	value = 100

	loyalty_tag = "Silicon"
	iff_tag = "Silicon"

	size = SIZE_HUMAN

	armor_base = CYBORG_ARMOR

	soul_size = null

/mob/living/simple/silicon/squats
	name = "S.Q.U.A.T.S."
	icon_state = "squats"

	health = /health/mob/living/simple/squats/


	movement_delay = 2

	health_base = 300
	stamina_base = 500
	mana_base = 100

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 3

	armor_base = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 40,
		LASER = 20,
		ARCANE = -80,
		HEAT = -40,
		COLD = 40,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = -80,
		PAIN = INFINITY
	)

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

	damage_type = /damagetype/squats/

	status_immune = list(
		FIRE = TRUE
	)

	level = 22

/mob/living/simple/silicon/squats/post_death()
	. = ..()
	icon_state = "squats-dead"

/mob/living/simple/silicon/squats/Finalize()
	. = ..()
	update_sprite()

/mob/living/simple/silicon/squats/update_overlays()
	. = ..()
	if(!dead && health && health.health_current >= health.health_max * 0.5)
		var/icon/I = new/icon(initial(icon),"squats-shield")
		add_overlay(I)

/mob/living/simple/silicon/syndieborg
	name = "\improper Syndicate Battleborg"
	icon_state = "syndicate"

	ai = /ai/syndicate_cyborg


	movement_delay = DECISECONDS_TO_TICKS(4)

	health_base = 400
	stamina_base = 200
	mana_base = 100

	armor_base = list(
		BLADE = 20,
		BLUNT = 40,
		PIERCE = 20,
		LASER = -20,
		ARCANE = -40,
		COLD = 20,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

	damage_type = /damagetype/squats/

	level = 12

/mob/living/simple/silicon/syndieborg/proc/shoot_gun(var/atom/desired_target)
	shoot_projectile(
		src,
		desired_target,
		null,
		null,
		/obj/projectile/bullet/firearm/rifle,
		/damagetype/ranged/bullet/rifle_223,
		16,
		16,
		0,
		TILE_SIZE*0.75,
		1,
		COLOR_BULLET,
		0,
		0,
		1,
		iff_tag,
		loyalty_tag
	)
	play_sound('sound/weapons/223/shoot.ogg',get_turf(src))
	return TRUE


/mob/living/simple/silicon/syndieborg/Finalize()
	. = ..()
	update_sprite()

/mob/living/simple/silicon/syndieborg/post_death()
	. = ..()
	update_sprite()

/mob/living/simple/silicon/syndieborg/update_overlays()

	if(!dead)
		var/image/I = new/image(initial(icon),"[initial(icon_state)]_light")
		I.plane = PLANE_LIGHTING
		add_overlay(I)

	return ..()