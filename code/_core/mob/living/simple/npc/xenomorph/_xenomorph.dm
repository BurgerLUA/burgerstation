/mob/living/simple/npc/xenomorph
	name = "xenomorph"
	desc = "Oh shit they're here too?!"
	icon = 'icons/mob/living/simple/alien.dmi'
	icon_state = "alien"

	ai = /ai/xenomorph
	damage_type = /damagetype/npc/xenomorph
	class = "xenomorph"
	health_base = 100

	loyalty_tag = "xeno"
	iff_tag = "xeno"

	movement_delay = DECISECONDS_TO_TICKS(1)

	armor_base = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = -50,
		MAGIC = -25,
		HEAT = -25,
		COLD = 90,
		BOMB = -25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 50,
		DARK = 100,
		FATIGUE = 0
	)

	movement_delay = DECISECONDS_TO_TICKS(0.5)

/mob/living/simple/npc/xenomorph/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/npc/xenomorph/pack_leader
	ai = /ai/xenomorph/pack_leader
	health_base = 100

	level_multiplier = 1.25

/mob/living/simple/npc/xenomorph/pack_leader/queen
	name = "xenomorph queen"
	id = "xenomorph_queen"
	icon = 'icons/mob/living/simple/alien_queen.dmi'
	icon_state = "alien_queen"
	pixel_x = -16
	health_base = 400

	ai = /ai/xenomorph_queen
	damage_type = /damagetype/npc/xenomorph/queen
	class = "xenomorph"

	boss = TRUE
	force_spawn = TRUE

	movement_delay = DECISECONDS_TO_TICKS(3)

	level_multiplier = 4

	butcher_contents = list(
		/obj/item/soapstone/red
	)