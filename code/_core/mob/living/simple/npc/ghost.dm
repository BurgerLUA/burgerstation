/mob/living/simple/npc/ghost
	name = "?"
	desc = "..."
	desc_extended  = "..."
	//Icon and icon state is set in AI.

	ai = /ai/ghost/
	damage_type = /damagetype/npc/ghost
	class = /class/antagonist
	level_multiplier = 1000

	var/desired_alpha = 200 //Controlled in AI.

	has_footsteps = FALSE

	collision_flags = FLAG_COLLISION_ETHEREAL | FLAG_COLLISION_UNSIMULATED
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	movement_delay = DECISECONDS_TO_TICKS(2)

	health_base = 500
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
		ION = INFINITY
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

/mob/living/simple/npc/ghost/handle_alpha()
	return desired_alpha


/mob/living/simple/npc/ghost/shitass
	ai = /ai/ghost/shitass