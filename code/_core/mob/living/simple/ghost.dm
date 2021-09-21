/mob/living/simple/ghost
	name = "?"
	desc = "..."
	desc_extended  = "..."
	//Icon and icon state is set in AI.

	ai = /ai/ghost/
	damage_type = /damagetype/npc/ghost

	var/desired_alpha = 200 //Controlled in AI.

	has_footsteps = TRUE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	movement_delay = DECISECONDS_TO_TICKS(1)

	health_base = 500
	stamina_base = 500
	mana_base = 500
	blood_type = null

	iff_tag = "Ghost"
	loyalty_tag = "Ghost"

	armor_base = list(
		BLADE = INFINITY,
		BLUNT = INFINITY,
		PIERCE = INFINITY,
		LASER = INFINITY,
		ARCANE = INFINITY,
		HEAT = INFINITY,
		COLD = INFINITY,
		BOMB = INFINITY,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 0,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		FATIGUE = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE,
		FIRE = TRUE
	)

	size = SIZE_LARGE

	soul_size = SOUL_SIZE_RARE

	enable_chunk_clean = FALSE

	density = TRUE
	anchored = FALSE

/mob/living/simple/ghost/on_crush()
	return FALSE

/mob/living/simple/ghost/handle_alpha()
	if(dead) return 0
	return desired_alpha


/mob/living/simple/ghost/shitass
	ai = /ai/ghost/shitass