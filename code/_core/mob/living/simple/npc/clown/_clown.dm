/mob/living/simple/npc/clown
	name = "clown minion"
	desc = "Oh god oh fuck."
	desc_extended = "A loyal servant of the honkmother, now in this realm."
	icon = 'icons/mob/living/simple/clown_large.dmi'
	icon_state = "clown"

	health_base = 100

	ai = /ai/clown
	class = /class/clown //Just like highschool
	damage_type = /damagetype/npc/clown

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
		ION = INFINITY
	)


/mob/living/simple/npc/clown/hulk
	name = "clown hunk"
	icon_state = "hulk"

	health_base = 1000

	ai = /ai/clown/hulk

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
		ION = INFINITY
	)

	pixel_x = -16

/mob/living/simple/npc/clown/hulk/armored
	name = "armored clown hunk"
	icon_state = "destroyer"

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
		ION = INFINITY
	)

/mob/living/simple/npc/clown/tree
	name = "clown tree"
	icon_state = "tree"

	health_base = 200

	ai = /ai/clown/tree

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
		ION = INFINITY
	)

	pixel_x = -16



/mob/living/simple/npc/clown/long
	name = "long clown"
	icon_state = "long"

	health_base = 300

	ai = /ai/clown/long

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
		ION = INFINITY
	)

/mob/living/simple/npc/clown/pie
	name = "pie clown"
	icon_state = "pie"
	health_base = 100

	ai = /ai/clown/pie

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
		ION = INFINITY
	)

/mob/living/simple/npc/clown/lube
	name = "lube slime clown"
	icon_state = "lube"

	health_base = 200

	ai = /ai/clown/lube

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
		ION = INFINITY
	)

	status_immune = list(
		SLIP = TRUE
	)

/mob/living/simple/npc/clown/lube/post_move(var/atom/old_loc)

	. = ..()

	if(is_simulated(loc))
		var/turf/simulated/S = loc
		S.add_wet(1000)

	return .


/*
/mob/living/simple/npc/clown/creep
	name = "clown creep"
	icon_state = "creep"

	health_base = 500

	ai = /ai/clown/creep
	class = /class/clown/creep
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
		ION = INFINITY
	)
*/

/*
/mob/living/simple/npc/clown/giggles
	name = "giggles the clown"
	icon_state = "giggles"

	health_base = 150

	ai = /ai/clown/giggles
	class = /class/clown/giggles
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
		ION = INFINITY
	)
*/

/*
/mob/living/simple/npc/clown/chad
	name = "chad clown"

	icon_state = "chad"

	health_base = 500

	ai = /ai/clown/chad
	class = /class/clown/chad
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
		ION = INFINITY
	)
*/


/*
/mob/living/simple/npc/clown/scary
	name = "scary clown"

	icon_state = "scary"

	health_base = 150

	ai = /ai/clown/scary
	class = /class/clown/scary
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
		ION = INFINITY
	)
*/

/*
/mob/living/simple/npc/clown/flesh
	name = "flesh clown"
	icon_state = "flesh"

	health_base = 250

	ai = /ai/clown/flesh
	class = /class/clown/flesh
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
		ION = INFINITY
	)
*/

/*
/mob/living/simple/npc/clown/plural
	name = "clowns"
	icon_state = "plural"

	health_base = 200

	ai = /ai/clown/plural
	class = /class/clown/plural
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
		ION = INFINITY
	)
*/

/mob/living/simple/npc/clown/mutant
	name = "mutant clown"

	icon_state = "mutant"

	health_base = 400

	ai = /ai/clown/mutant

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
		ION = INFINITY
	)

	pixel_x = -16

/mob/living/simple/npc/clown/blob
	name = "blob clown"
	icon_state = "blob"

	health_base = 500

	ai = /ai/clown/blob

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
		ION = INFINITY
	)

	pixel_x = -16

/*
/mob/living/simple/npc/clown/honkling
	name = "honkling clown"
	icon_state = "honkling"

	health_base = 50

	ai = /ai/clown/honkling
	class = /class/clown/honkling
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
		FATIGUE = 0,
		ION = INFINITY
	)
*/