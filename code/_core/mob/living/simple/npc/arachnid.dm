/mob/living/simple/npc/arachnid
	name = "giant arachnid"
	desc = "Might as well be a miniboss."
	desc_extended = "A giant quadreped carniverous creature."
	icon = 'icons/mob/living/simple/jungle/arachnid.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/arachnid

	ai = /ai/

	stun_angle = 0

	pixel_x = -16

	armor_base = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 75,
		LASER = 0,
		MAGIC = 25,
		HEAT = 50,
		COLD = 0,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 100,
		DARK = 100,
		FATIGUE = INFINITY
	)

	iff_tag = "jungle"
	loyalty_tag = "jungle"

	health_base = 1000

	movement_delay = DECISECONDS_TO_TICKS(2)

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

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

/mob/living/simple/npc/arachnid/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()