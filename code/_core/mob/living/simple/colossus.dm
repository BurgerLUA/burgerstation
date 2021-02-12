/mob/living/simple/colossus
	name = "colossus"
	boss_icon_state = "colossus"
	icon = 'icons/mob/living/simple/lavaland/colossus.dmi'
	icon_state = "colossus"
	damage_type = /damagetype/unarmed/claw/
	class = /class/colossus

	value = 4000

	pixel_x = -32

	ai = /ai/boss/colossus/

	stun_angle = 0

	boss_loot = /loot/lavaland/colossus

	health_base = 8000
	stamina_base = 500
	mana_base = 2000

	attack_range = 2

	move_delay = DECISECONDS_TO_TICKS(5)

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_GREATSWORD,
		ARCANE = AP_SWORD,
		HEAT = AP_GREATSWORD,
		COLD = AP_GREATSWORD,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE,
		FIRE = TRUE
	)

	iff_tag = "Colossus"
	loyalty_tag = "Colossus"

	fatigue_from_block_mul = 0

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/ancient
	blood_volume = 2000

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_colossus,
		/obj/item/container/food/dynamic/meat/raw_colossus,
		/obj/item/container/food/dynamic/meat/raw_colossus,
		/obj/item/container/food/dynamic/meat/raw_colossus,
		/obj/item/container/food/dynamic/meat/raw_colossus,
		/obj/item/container/food/dynamic/meat/raw_colossus
	)

/mob/living/simple/colossus/pre_death()
	do_say("<font color='#DD1C1F' size='4'>I WILL RETURN.</font>",FALSE)
	play_sound('sound/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	return ..()

/mob/living/simple/colossus/post_death()
	. = ..()
	animate(src, pixel_z = 64, time = 30)
	return .

/mob/living/simple/colossus/handle_alpha()

	if(dead)
		return 0

	return ..()


