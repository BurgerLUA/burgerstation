/mob/living/simple/spider
	name = "cave spider"
	icon = 'icons/mob/living/simple/spiders.dmi'
	icon_state = "guard"

	damage_type = /damagetype/npc/spider

	ai = /ai/



	stun_angle = 0

	health_base = 75
	stamina_base = 150
	mana_base = 50

	value = 100

	butcher_contents = list(
		/obj/item/container/edible/dynamic/meat/raw_spider/,
		/obj/item/container/edible/dynamic/meat/raw_spider/,
		/obj/item/container/edible/dynamic/meat/raw_spider/
	)

	armor = /armor/insect

	size = SIZE_GIANT

	movement_delay = DECISECONDS_TO_TICKS(2)

	loyalty_tag = "Spider"
	iff_tag = "Spider"

	blood_type = /reagent/blood/spider

	soul_size = SOUL_SIZE_COMMON

	level = 10

/mob/living/simple/spider/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/spider/glow
	name = "glowspider"
	icon_state = "nurse"

	level = 18

/mob/living/simple/spider/glow/Initialize()
	. = ..()
	set_light(4,0.25,"#00FF00")

/mob/living/simple/spider/twilight
	name = "twilight spider"
	icon_state = "hunter"

	level = 20

