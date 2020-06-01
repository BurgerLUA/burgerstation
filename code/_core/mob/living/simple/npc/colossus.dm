/mob/living/simple/npc/colossus
	name = "colossus"
	id = "colossus"
	icon = 'icons/mob/living/simple/lavaland/colossus.dmi'
	icon_state = "colossus"
	damage_type = /damagetype/unarmed/claw/
	class = "colossus"

	pixel_x = -32

	ai = /ai/boss/colossus/

	stun_angle = 0

	health_base = 2000

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 50,
		LASER = 100,
		MAGIC = 0,
		HEAT = INFINITY,
		COLD = INFINITY,
		BOMB = 50,
		BIO = 75,
		RAD = 75,
		HOLY = 0,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		STAGGER = FALSE,
		CONFUSED = FALSE,
		CRIT = FALSE,
		REST = FALSE,
		ADRENALINE = FALSE,
		DISARM = FALSE,
		DRUGGY = FALSE
	)

	iff_tag = "colossus"
	loyalty_tag = "colossus"

	damage_received_multiplier = 0.5

/mob/living/simple/npc/colossus/pre_death()
	do_say("<font color='#DD1C1F' size='4'>I WILL RETURN.</font>",FALSE)
	play('sounds/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	return ..()

/mob/living/simple/npc/colossus/post_death()
	. = ..()
	animate(src, pixel_z = 64, alpha=0, time = 30)
	return .