/mob/living/simple/spider
	name = "cave spider"
	icon = 'icons/mob/living/simple/spiders.dmi'
	icon_state = "guard"

	damage_type = /damagetype/npc/spider

	ai = /ai/

	class = /class/spider

	stun_angle = 0

	health_base = 75
	stamina_base = 150
	mana_base = 50

	value = 100

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_spider/,
		/obj/item/container/food/dynamic/meat/raw_spider/,
		/obj/item/container/food/dynamic/meat/raw_spider/
	)

	armor_base = list(
		HEAT = -AP_SWORD,
		COLD = AP_SWORD,
		BIO = AP_GREATSWORD,
		RAD = AP_AXE,
		FATIGUE = AP_SWORD,
		ION = INFINITY,
		PAIN = AP_SWORD
	)

	mob_size = MOB_SIZE_LARGE

	movement_delay = DECISECONDS_TO_TICKS(2)

	loyalty_tag = "Spider"
	iff_tag = "Spider"

	blood_type = /reagent/blood/spider

/mob/living/simple/spider/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/spider/desert
	name = "glowspider"
	icon_state = "nurse"

	level_multiplier = 1.25

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 25,
		ARCANE = 50,
		HEAT = 75,
		COLD = -25,
		BOMB = 0,
		BIO = INFINITY,
		RAD = 25,
		HOLY = 75,
		DARK = 50,
		FATIGUE = 25,
		ION = INFINITY,
		PAIN = 25
	)

/mob/living/simple/spider/desert/Initialize()
	. = ..()
	set_light(4,0.25,"#00FF00")
	return .

/mob/living/simple/spider/twilight
	name = "twilight spider"
	icon_state = "hunter"

	level_multiplier = 1.5

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 25,
		ARCANE = 50,
		HEAT = 75,
		COLD = -25,
		BOMB = 0,
		BIO = 75,
		RAD = 25,
		HOLY = 25,
		DARK = 100,
		FATIGUE = 25,
		ION = INFINITY,
		PAIN = 25
	)

