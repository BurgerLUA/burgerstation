/mob/living/simple/npc/colossus
	name = "colossus"
	id = "colossus"
	icon = 'icons/mob/living/simple/lavaland/colossus.dmi'
	icon_state = "colossus"
	damage_type = /damagetype/unarmed/claw/
	class = "colossus"

	pixel_x = -32

	ai = /ai/boss/colossus/

	stun_angle = 0

	health_base = 2000

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 50,
		LASER = -25,
		MAGIC = -25,
		HEAT = INFINITY,
		COLD = INFINITY,
		BOMB = 50,
		BIO = 75,
		RAD = 75,
		HOLY = -50,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	iff_tag = "colossus"
	loyalty_tag = "colossus"

	butcher_contents = list(
		/obj/item/soapstone/red
	)



/mob/living/simple/npc/colossus/pre_death()
	say("<font color='#DD1C1F' size='4'>I WILL RETURN.</font>",FALSE)
	return ..()

/mob/living/simple/npc/colossus/post_death()
	. = ..()
	play('sounds/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	animate(src, pixel_z = 64, alpha=0, time = 30)
	return .