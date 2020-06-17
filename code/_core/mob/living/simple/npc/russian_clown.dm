/mob/living/simple/npc/rev_leader
	name = "revolutionary leader"
	icon = 'icons/mob/living/simple/clown_large.dmi'
	icon_state = "rev"
	desc = "<font face='Comic Sans MS' color='#FF69FF' size='4'>Honk.</font>"
	damage_type = /damagetype/unarmed/fists
	class = /class/arachnid

	ai = /ai/

	stun_angle = 0

	pixel_x = -16

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 50,
		MAGIC = 25,
		HEAT = 25,
		COLD = INFINITY,
		BOMB = 100,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 25,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	iff_tag = "Syndicate"
	loyalty_tag = "Syndicate"

	health_base = 4000

	movement_delay = DECISECONDS_TO_TICKS(5)

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

	mob_size = MOB_SIZE_GIANT


/mob/living/simple/npc/rev_leader/pre_death()
	do_say("<font face='Comic Sans MS' color='#FF69FF' size='4'>oh darn</font>",FALSE)
	play('sounds/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	return ..()

/mob/living/simple/npc/rev_leader/post_death()
	. = ..()
	animate(src, pixel_z = 64, alpha=0, time = 30)
	return .