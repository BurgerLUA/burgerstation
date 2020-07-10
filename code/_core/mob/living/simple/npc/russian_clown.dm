/mob/living/simple/npc/rev_leader
	name = "revolutionary leader"
	icon = 'icons/mob/living/simple/clown_large.dmi'
	icon_state = "rev"
	desc = "<font face='Comic Sans MS' color='#FF69FF' size='4'>Honk.</font>"
	desc_extended = "A rather clownish leader of a revolution."
	damage_type = /damagetype/unarmed/fists
	class = /class/arachnid

	ai = /ai/

	stun_angle = 0

	pixel_x = -16

	value = 1000

	armor_base = list(
		BLADE = 50,
		BLUNT = 90,
		PIERCE = 75,
		LASER = 50,
		MAGIC = 75,
		HEAT = 50,
		COLD = 100,
		BOMB = 25,
		BIO = 25,
		RAD = 25,
		HOLY = 100,
		DARK = 100
	)

	loyalty_tag = "Revolutionary"
	iff_tag = "Revolutionary"

	health_base = 4000

	movement_delay = DECISECONDS_TO_TICKS(5)

	status_immune = list(
		STUN = STAGGER,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		DISARM = TRUE
	)

	mob_size = MOB_SIZE_GIANT

	enable_medical_hud = FALSE
	enable_security_hud = FALSE


/mob/living/simple/npc/rev_leader/pre_death()
	do_say("<font face='Comic Sans MS' color='#FF69FF' size='4'>oh darn</font>",FALSE)
	play('sound/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	return ..()

/mob/living/simple/npc/rev_leader/post_death()
	. = ..()
	animate(src, pixel_z = 64, alpha=0, time = 30)
	return .