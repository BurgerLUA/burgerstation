/mob/living/simple/slime_king //Not a subtype of slime because it behaves way differently
	name = "slime king"
	boss_icon_state = "slime_king"
	desc = "Oh no. They're here too."

	icon = 'icons/mob/living/simple/slime_king.dmi'
	icon_state = "king"

	ai = /ai/

	damage_type = /damagetype/npc/slime

	can_attack_while_moving = TRUE

	color = "#2222FF"

	pixel_x = -32
	pixel_y = -12

	health_base = 4000
	stamina_base = 5000
	mana_base = 100

	value = 500

	level_multiplier = 4

	object_size = 1

	attack_range = 1

	boss = TRUE
	force_spawn = TRUE

	armor_base = list(
		BLADE = -AP_SWORD,
		BLUNT = AP_GREATSWORD,
		LASER = -AP_SWORD,
		HEAT = AP_CLUB,
		COLD = -AP_CLUB,
		BIO = INFINITY,
		RAD = INFINITY,
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
		DRUGGY = TRUE
	)

	fatigue_from_block_mul = 0

	butcher_contents = list(
		/obj/item/soapstone/orange
	)

	size = SIZE_BOSS

	damage_type = /damagetype/npc/slime

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Slime"
	loyalty_tag = "Slime"

	stun_angle = 0

	blood_type = null

/mob/living/simple/slime_king/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(!dead && prob(damage_amount))
		var/mob/living/simple/slime/S = new(src.loc)

		var/xvel = rand(-1,1)
		var/yvel = rand(-1,1)

		if(xvel == 0 && yvel == 0)
			xvel = pick(-1,1)
			yvel = pick(-1,1)

		var/atom/defer_attacker = attacker.defer_click_on_object()

		S.throw_self(src,defer_attacker,16,16,xvel*10,yvel*10)
		S.color = rgb(rand(0,255),rand(0,255),rand(0,255))
		S.alpha = rand(50,200)
		S.slime_color = S.color
		INITIALIZE(S)
		FINALIZE(S)

	return .


/mob/living/simple/slime_king/post_death()
	..()
	icon_state = "death"
	update_sprite()