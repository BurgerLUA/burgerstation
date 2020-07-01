/mob/living/simple/npc/xenomorph
	name = "xenomorph"
	desc = "Xenos mad."
	desc_extended = "Oh shit they're here too?!"
	icon = 'icons/mob/living/simple/alien.dmi'
	icon_state = "alien"

	ai = /ai/xenomorph
	damage_type = /damagetype/npc/xenomorph
	class = /class/xenomorph
	health_base = 100

	value = 100

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/
	)

	loyalty_tag = "xeno"
	iff_tag = "xeno"

	armor_base = list(
		BLADE = 80,
		BLUNT = 80,
		PIERCE = 75,
		LASER = 25,
		MAGIC = 25,
		HEAT = 25,
		COLD = INFINITY,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 50,
		DARK = 100,
		FATIGUE = 75
	)

	movement_delay = DECISECONDS_TO_TICKS(1)

	mob_size = MOB_SIZE_LARGE

	blood_color = "#B6FF00"

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
	health_base = 1000
	value = 2000

	armor_base = list(
		BLADE = 100,
		BLUNT = 100,
		PIERCE = 90,
		LASER = 75,
		MAGIC = 75,
		HEAT = 75,
		COLD = INFINITY,
		BOMB = 50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 50,
		DARK = 100,
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

	ai = /ai/xenomorph_queen
	damage_type = /damagetype/npc/xenomorph/queen
	class = /class/xenomorph

	boss = TRUE
	force_spawn = TRUE

	movement_delay = DECISECONDS_TO_TICKS(2)

	level_multiplier = 4

	butcher_contents = list(
		/obj/item/soapstone/orange,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/
	)

	damage_received_multiplier = 0.5

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE