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

/*
/mob/living/simple/silicon/engineer
	name = "engineer cyborg"
	icon_state = "engineer"

/mob/living/simple/silicon/engineer/PostInitialize()
	. = ..()
	flick("engineer_transform",src)
	return .
*/


/mob/living/simple/silicon/squats
	name = "S.Q.U.A.T.S."
	icon_state = "squats"

	health = /health/mob/living/simple/squats/
	class = /class/squats

	movement_delay = 2

	health_base = 300
	stamina_base = 500
	mana_base = 100

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 3

	armor_base = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_AXE,
		LASER = AP_SWORD,
		ARCANE = -AP_GREATSWORD,
		HEAT = -AP_AXE,
		COLD = AP_AXE,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = -AP_GREATSWORD,
		PAIN = INFINITY
	)

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

	damage_type = /damagetype/squats/

	status_immune = list(
		FIRE = TRUE
	)

/mob/living/simple/silicon/squats/post_death()
	. = ..()
	icon_state = "squats-dead"
	return .

/mob/living/simple/silicon/squats/Finalize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/silicon/squats/update_overlays()
	. = ..()
	if(!dead && health && health.health_current >= health.health_max * 0.5)
		var/icon/I = new/icon(initial(icon),"squats-shield")
		add_overlay(I)
	return .


/mob/living/simple/silicon/syndieborg
	name = "\improper Syndicate Battleborg"
	icon_state = "syndicate"

	ai = /ai/syndicate_cyborg
	class = /class/squats

	movement_delay = DECISECONDS_TO_TICKS(4)

	health_base = 400
	stamina_base = 200
	mana_base = 100

	armor_base = list(
		BLADE = AP_SWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = -AP_AXE,
		COLD = AP_SWORD,
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
	return .

/mob/living/simple/silicon/syndieborg/post_death()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/silicon/syndieborg/update_overlays()

	if(!dead)
		var/image/I = new/image(initial(icon),"[initial(icon_state)]_light")
		I.plane = PLANE_LIGHTING
		add_overlay(I)

	return ..()