/mob/living/simple/npc/slime_king //Not a subtype of slime because it behaves way differently
	name = "slime king"
	id = "slime_king"
	desc = "Oh no. They're here too."

	icon = 'icons/mob/living/simple/slime_king.dmi'
	icon_state = "king"

	ai = /ai/

	damage_type = /damagetype/npc/slime

	can_attack_while_moving = TRUE

	color = "#2222FF"

	pixel_x = -32
	pixel_y = -12

	health_base = 3000

	value = 500

	level_multiplier = 4

	object_size = 1

	attack_range = 1

	boss = TRUE
	force_spawn = TRUE

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 50,
		LASER = 25,
		MAGIC = 25,
		HEAT = 100,
		COLD = 0,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
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

	damage_received_multiplier = 0.5

	butcher_contents = list(
		/obj/item/soapstone/orange
	)

	mob_size = MOB_SIZE_BOSS

	damage_type = /damagetype/npc/slime

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Slime"
	loyalty_tag = "Slime"

/mob/living/simple/npc/slime_king/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(!dead && prob(damage_amount))
		var/mob/living/simple/npc/slime/S = new(src.loc)

		var/xvel = rand(-1,1)
		var/yvel = rand(-1,1)

		if(xvel == 0 && yvel == 0)
			xvel = pick(-1,1)
			yvel = pick(-1,1)

		attacker = attacker.defer_click_on_object()

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