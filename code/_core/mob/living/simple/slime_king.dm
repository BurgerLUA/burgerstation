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



	object_size = 2

	boss = TRUE
	force_spawn = TRUE

	armor = /armor/slime

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		DISARM = TRUE,
		FIRE = TRUE,
		GRAB = TRUE,
		PAINCRIT = TRUE
	)

	fatigue_mul = 0

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

	soul_size = SOUL_SIZE_RARE

	respawn_time = SECONDS_TO_DECISECONDS(300)

	movement_delay = DECISECONDS_TO_TICKS(6)

	level = 30

/mob/living/simple/slime_king/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)
	. = ..()

	if(!dead && prob(damage_amount) && attacker)
		var/turf/T = get_step(src,get_dir(src,attacker))
		if(T)
			var/mob/living/simple/slime/S = new(T)
			S.color = rgb(rand(0,255),rand(0,255),rand(0,255))
			S.alpha = rand(50,200)
			INITIALIZE(S)
			FINALIZE(S)
			var/xvel = rand(-1,1)
			var/yvel = rand(-1,1)
			if(xvel == 0 && yvel == 0)
				xvel = pick(-1,1)
				yvel = pick(-1,1)
			S.throw_self(src,attacker,16,16,xvel*10,yvel*10)
			if(S.ai)
				S.ai.set_objective(attacker)

/mob/living/simple/slime_king/post_death()
	..()
	icon_state = "death"