/mob/living/simple/npc/colossus
	name = "colossus"
	id = "colossus"
	icon = 'icons/mob/living/simple/lavaland/colossus.dmi'
	icon_state = "colossus"
	damage_type = /damagetype/unarmed/claw/
	class = /class/colossus

	value = 4000

	pixel_x = -32

	ai = /ai/boss/colossus/

	stun_angle = 0

	health_base = 4000

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 100,
		MAGIC = 75,
		HEAT = 75,
		COLD = 100,
		BOMB = 25,
		BIO = 25,
		RAD = 50,
		HOLY = 25,
		DARK = 100,
		FATIGUE = 100
	)

	status_immune = list(
		STUN = STAGGER,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		DISARM = TRUE,
		FIRE = TRUE
	)

	iff_tag = "colossus"
	loyalty_tag = "colossus"

	damage_received_multiplier = 0.5

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

/mob/living/simple/npc/colossus/pre_death()
	do_say("<font color='#DD1C1F' size='4'>I WILL RETURN.</font>",FALSE)
	play('sound/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	return ..()

/mob/living/simple/npc/colossus/post_death()
	. = ..()
	animate(src, pixel_z = 64, alpha=0, time = 30)
	CREATE(/obj/structure/interactive/crate/necro,get_turf(src))
	return .