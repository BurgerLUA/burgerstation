/mob/living/simple/npc/silicon/
	name = "robot"
	icon = 'icons/mob/living/simple/robots.dmi'
	icon_state = "robot_old"

	ai = /ai/

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/robot

	value = 100

/mob/living/simple/npc/silicon/engineer
	name = "engineer cyborg"
	icon_state = "engineer"



/mob/living/simple/npc/silicon/engineer/PostInitialize()
	. = ..()
	flick("engineer_transform",src)
	return .


/mob/living/simple/npc/silicon/squats
	name = "S.Q.U.A.T.S."
	icon_state = "squats"

	health = /health/mob/living/simple/npc/squats/
	class = /class/squats

	movement_delay = 2

	health_base = 300

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 3

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 75,
		LASER = 50,
		ARCANE = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = -50
	)

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

	damage_type = /damagetype/squats/

	status_immune = list(
		FIRE = TRUE
	)

/mob/living/simple/npc/silicon/squats/post_death()
	. = ..()
	icon_state = "squats-dead"
	return .

/mob/living/simple/npc/silicon/squats/Finalize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/npc/silicon/squats/update_overlays()
	. = ..()
	if(!dead && health && health.health_current >= health.health_max * 0.5)
		var/icon/I = new/icon(initial(icon),"squats-shield")
		add_overlay(I)
	return .


/mob/living/simple/npc/silicon/syndieborg
	name = "\improper Syndicate Battleborg"
	icon_state = "syndicate"

	ai = /ai/syndicate_cyborg
	class = /class/squats

	movement_delay = DECISECONDS_TO_TICKS(4)

	health_base = 400

	armor_base = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 75,
		LASER = 50,
		ARCANE = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = 0
	)

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

	damage_type = /damagetype/squats/

/mob/living/simple/npc/silicon/syndieborg/proc/shoot_gun(var/atom/desired_target)
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
	play('sound/weapons/223/shoot.ogg',get_turf(src))
	return TRUE


/mob/living/simple/npc/silicon/syndieborg/Finalize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/npc/silicon/syndieborg/post_death()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/npc/silicon/syndieborg/update_overlays()

	if(!dead)
		var/image/I = new/image(initial(icon),"[initial(icon_state)]_light")
		I.plane = PLANE_LIGHTING
		add_overlay(I)

	return ..()