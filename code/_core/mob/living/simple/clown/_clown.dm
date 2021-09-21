/mob/living/simple/clown
	name = "clown minion"
	desc = "Oh god oh fuck."
	desc_extended = "A loyal servant of the honkmother, now in this realm."
	icon = 'icons/mob/living/simple/clown_large.dmi'
	icon_state = "clown"

	health_base = 100
	stamina_base = 200
	mana_base = 200

	ai = /ai/clown

	damage_type = /damagetype/npc/clown

	armor_base = list(
		HOLY = -60,
		DARK = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	iff_tag = "Clown"
	loyalty_tag = "Clown"

	size = SIZE_HUMAN

	blood_type = /reagent/blood/clown
	blood_volume = 750

	soul_size = SOUL_SIZE_COMMON

	level = 28


/mob/living/simple/clown/hulk
	name = "clown hunk"
	icon_state = "hulk"

	health_base = 1000

	ai = /ai/clown/hulk

	armor_base = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		HOLY = -60,
		DARK = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	pixel_x = -16

	size = SIZE_LARGE

/mob/living/simple/clown/hulk/armored
	name = "armored clown hunk"
	icon_state = "destroyer"

	armor_base = list(
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 60,
		ARCANE = -10,
		HOLY = -60,
		DARK = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

/mob/living/simple/clown/tree
	name = "clown tree"
	icon_state = "tree"

	health_base = 200

	ai = /ai/clown/tree

	armor_base = list(
		BLADE = -20,
		HOLY = -60,
		DARK = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	pixel_x = -16

	size = SIZE_LARGE



/mob/living/simple/clown/long
	name = "long clown"
	icon_state = "long"

	health_base = 300

	ai = /ai/clown/long

	armor_base = list(
		HOLY = -60,
		DARK = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	size = SIZE_LARGE

/mob/living/simple/clown/pie
	name = "pie clown"
	icon_state = "pie"
	health_base = 100

	ai = /ai/clown/pie

	armor_base = list(
		HOLY = -60,
		DARK = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	size = SIZE_LARGE

/mob/living/simple/clown/lube
	name = "lube slime clown"
	icon_state = "lube"

	health_base = 200

	ai = /ai/clown/lube

	armor_base = list(
		HOLY = -60,
		DARK = 60,
		BIO = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	status_immune = list(
		SLIP = TRUE
	)

/mob/living/simple/clown/lube/post_move(var/atom/old_loc)

	. = ..()

	if(is_simulated(loc) && !dead)
		var/turf/simulated/S = loc
		S.add_wet(1000)

/*
/mob/living/simple/clown/creep
	name = "clown creep"
	icon_state = "creep"

	health_base = 500

	ai = /ai/clown/creep

	damage_type = /damagetype/npc/clown/creep

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 75,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)
*/

/*
/mob/living/simple/clown/giggles
	name = "giggles the clown"
	icon_state = "giggles"

	health_base = 150

	ai = /ai/clown/giggles

	damage_type = /damagetype/npc/clown/giggles

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 75,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)
*/

/*
/mob/living/simple/clown/chad
	name = "chad clown"

	icon_state = "chad"

	health_base = 500

	ai = /ai/clown/chad

	damage_type = /damagetype/npc/clown/chad

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 75,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)
*/


/*
/mob/living/simple/clown/scary
	name = "scary clown"

	icon_state = "scary"

	health_base = 150

	ai = /ai/clown/scary

	damage_type = /damagetype/npc/clown/scary

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 75,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)
*/

/*
/mob/living/simple/clown/flesh
	name = "flesh clown"
	icon_state = "flesh"

	health_base = 250

	ai = /ai/clown/flesh

	damage_type = /damagetype/npc/clown/flesh

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 75,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)
*/

/*
/mob/living/simple/clown/plural
	name = "clowns"
	icon_state = "plural"

	health_base = 200

	ai = /ai/clown/plural

	damage_type = /damagetype/npc/clown/plural

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 75,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0
	)
*/

/mob/living/simple/clown/mutant
	name = "mutant clown"

	icon_state = "mutant"

	health_base = 400

	ai = /ai/clown/mutant

	armor_base = list(
		ARCANE = 60,
		HOLY = -60,
		DARK = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		RAD = INFINITY
	)

	size = SIZE_LARGE

	pixel_x = -16

/mob/living/simple/clown/blob
	name = "blob clown"
	icon_state = "blob"

	health_base = 500

	ai = /ai/clown/blob

	armor_base = list(
		ARCANE = 60,
		HOLY = -60,
		DARK = 60,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	pixel_x = -16

/*
/mob/living/simple/clown/honkling
	name = "honkling clown"
	icon_state = "honkling"

	health_base = 50

	ai = /ai/clown/honkling

	damage_type = /damagetype/npc/clown/honkling

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 75,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 100,
		FATIGUE = 0,,
		PAIN = 0
		ION = INFINITY
	)
*/