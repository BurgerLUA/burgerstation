/mob/living/advanced/human/npc/arena_guard
	name = "arena guard"
	ai = /ai/ranged/immobile/
	mob_outfit = /outfit/arena_guard
	status = FLAG_STATUS_IMMORTAL

/mob/living/advanced/human/npc/arena_guard/Initialize()
	..()
	var/obj/item/weapon/W1 = new /obj/item/weapon/ranged/laser/unlimited(src.loc)
	pickup(W1)

/mob/living/advanced/human/npc/arena_guard/red
	name = "red team guard"
	starting_factions = list("arena_red")

/mob/living/advanced/human/npc/arena_guard/blue
	name = "blue team guard"
	starting_factions = list("arena_blue")

/mob/living/advanced/human/npc/arena_guard/green
	name = "green team guard"
	starting_factions = list("arena_green")

/mob/living/advanced/human/npc/arena_guard/yellow
	name = "yellow team guard"
	starting_factions = list("arena_yellow")