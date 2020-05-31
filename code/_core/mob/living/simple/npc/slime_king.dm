/mob/living/simple/npc/slime_king //Not a subtype of slime because it behaves way differently
	name = "slime king"
	id = "slime_king"
	desc = "Oh no. They're here too."

	icon = 'icons/mob/living/simple/slime_king.dmi'
	icon_state = "king"

	ai = /ai/

	can_attack_while_moving = TRUE

	color = "#2222FF"

	pixel_x = -32
	pixel_y = -12

	health_base = 3000

	level_multiplier = 4

	object_size = 1

	attack_range = 1

	boss = TRUE
	force_spawn = TRUE

	armor_base = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = -25,
		LASER = -50,
		MAGIC = -50,
		HEAT = 50,
		COLD = -100,
		BOMB = -25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	butcher_contents = list(
		/obj/item/soapstone/red
	)

/mob/living/simple/npc/slime_king/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	. = ..()

	if(!dead && damage_amount >= 10)
		var/mob/living/simple/npc/slime/S = new(src.loc)

		var/xvel = rand(-1,1)
		var/yvel = rand(-1,1)

		if(xvel == 0 && yvel == 0)
			xvel = pick(-1,1)
			yvel = pick(-1,1)

		S.throw_self(src,attacker,16,16,xvel*10,yvel*10)
		S.color = rgb(rand(0,255),rand(0,255),rand(0,255))
		S.alpha = rand(50,200)
		S.slime_color = S.color
		INITIALIZE(S)

	return .


/mob/living/simple/npc/slime_king/post_death()
	..()
	icon_state = "death"
	update_sprite()