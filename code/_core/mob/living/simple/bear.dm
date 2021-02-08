/mob/living/simple/bear
	name = "brown bear"
	desc = "She will devour you, blyat!"
	desc_extended = "A harmfull critter."
	icon = 'icons/mob/living/simple/bears.dmi'
	icon_state = "brown"
	damage_type = /damagetype/unarmed/claw/
	class = /class/bear

	value = 100

	ai = /ai/

	stun_angle = 90

	armor_base = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_SWORD,
		LASER = -AP_SWORD,
		HEAT = -AP_DAGGER,
		COLD = AP_CLUB,
		FATIGUE = AP_SWORD,
		ION = INFINITY,
		PAIN = AP_SWORD
	)

	health_base = 200
	stamina_base = 100
	mana_base = 50

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_bear/,
		/obj/item/container/food/dynamic/meat/raw_bear/,
		/obj/item/container/food/dynamic/meat/raw_bear/,
		/obj/item/container/food/dynamic/meat/raw_bear/
	)

	size = SIZE_LARGE

	var/armored = FALSE

	iff_tag = "Bear"
	loyalty_tag = "Bear"

	blood_type = /reagent/blood/bear
	blood_volume = 1000

/mob/living/simple/bear/update_overlays()
	. = ..()

	if(armored)
		var/image/I = new/image(initial(icon),"armor")
		add_overlay(I)

	return .

/mob/living/simple/bear/PostInitialize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/bear/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/bear/armored
	name = "armored bear"
	level_multiplier = 2

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		ARCANE = -50,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)

	armored = TRUE

/mob/living/simple/bear/armored/revolutionary
	name = "armored russian bear"
	loyalty_tag = "Revolutionary"
	iff_tag = "Revolutionary"

	enable_security_hud = TRUE
	enable_medical_hud = TRUE

/mob/living/simple/bear/snow
	name = "snow bear"
	icon_state = "white"

	level_multiplier = 1.25

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		ARCANE = 0,
		HEAT = -25,
		COLD = 75,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)

/mob/living/simple/bear/black
	name = "black bear"
	icon_state = "black"

	level_multiplier = 2

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		ARCANE = 0,
		HEAT = -25,
		COLD = 75,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)

/mob/living/simple/bear/space
	name = "space bear"
	icon_state = "space"

	level_multiplier = 3

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		ARCANE = 0,
		HEAT = -25,
		COLD = 75,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)