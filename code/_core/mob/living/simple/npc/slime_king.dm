/mob/living/simple/npc/slime_king //Not a subtype of slime because it behaves way differently
	name = "slime king"
	id = "slime_king"
	desc = "Oh no. They're here too."

	icon = 'icons/mob/living/simple/slime_king.dmi'
	icon_state = "king"

	ai = /ai/simple/king_crab

	can_attack_while_moving = TRUE

	color = "#2222FF"

	pixel_x = -32
	pixel_y = -12

	health_base = 750

	level_multiplier = 4

	object_size = 1

	attack_range = 1

	boss = TRUE
	force_spawn = TRUE

/mob/living/simple/npc/slime_king/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	. = ..()

	if(damage_amount >= 10)
		var/mob/living/simple/npc/slime/S = new(src.loc)

		var/xvel = rand(-1,1)
		var/yvel = rand(-1,1)

		if(xvel == 0 && yvel == 0)
			xvel = pick(-1,1)
			yvel = pick(-1,1)

		S.throw_self(src,attacker,16,16,xvel*10,yvel*10)
		S.color = src.color
		S.slime_color = src.color
		S.Initialize()

	return .