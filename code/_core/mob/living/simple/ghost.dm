/mob/living/simple/ghost
	name = "?"
	desc = "..."
	desc_extended  = "..."
	//Icon and icon state is set in AI.

	ai = /ai/ghost/
	damage_type = /damagetype/npc/ghost

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

	armor = /armor/ghost

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

	size = SIZE_GIANT

	soul_size = SOUL_SIZE_RARE

	enable_chunk_clean = FALSE

	density = TRUE
	anchored = FALSE

	var/desired_alpha = 200 //Controlled in AI.

/mob/living/simple/ghost/on_crush(var/message=TRUE)
	return FALSE

/mob/living/simple/ghost/handle_alpha()
	if(dead) return 0
	return desired_alpha


/mob/living/simple/ghost/shitass
	ai = /ai/ghost/shitass