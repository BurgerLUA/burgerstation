/mob/living/simple/npc/passive/chicken
	name = "white chicken"
	icon_state = "chicken_white"

/mob/living/simple/npc/passive/chicken/brown
	name = "brown chicken"
	icon_state = "chicken_brown"

/mob/living/simple/npc/passive/chicken/black
	name = "black chicken"
	icon_state = "chicken_brown"

/mob/living/simple/npc/passive/chicken/black/Initialize()
	..()
	if(prob(1))
		name = "black cock"