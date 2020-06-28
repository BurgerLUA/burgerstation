/mob/living/simple/npc/bear
	name = "brown bear"
	icon = 'icons/mob/living/simple/bears.dmi'
	icon_state = "brown"
	damage_type = /damagetype/unarmed/claw/
	class = /class/bear

	ai = /ai/

	stun_angle = 90

	armor_base = list(
		BLADE = 10,
		BLUNT = 25,
		PIERCE = 10,
		LASER = -25,
		MAGIC = 0,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)

	health_base = 200

	mob_size = MOB_SIZE_LARGE

	var/armored = FALSE

/mob/living/simple/npc/bear/update_overlays()
	. = ..()

	if(armored)
		var/image/I = new/image(initial(icon),"armor")
		add_overlay(I)

	return .

/mob/living/simple/npc/bear/PostInitialize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/npc/bear/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/npc/bear/armored
	name = "armored bear"
	level_multiplier = 2

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		MAGIC = -50,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)

	armored = TRUE

/mob/living/simple/npc/bear/armored/syndicate
	name = "armored russian bear"
	loyalty_tag = "Syndicate"
	iff_tag = "Syndicate"

/mob/living/simple/npc/bear/snow
	name = "snow bear"
	icon_state = "white"

	level_multiplier = 1.25

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = 0,
		HEAT = -25,
		COLD = 75,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)

/mob/living/simple/npc/bear/black
	name = "black bear"
	icon_state = "black"

	level_multiplier = 2

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = 0,
		HEAT = -25,
		COLD = 75,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)

/mob/living/simple/npc/bear/space
	name = "space bear"
	icon_state = "space"

	level_multiplier = 3

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = 0,
		HEAT = -25,
		COLD = 75,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)