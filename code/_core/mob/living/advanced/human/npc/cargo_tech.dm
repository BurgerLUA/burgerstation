/mob/living/advanced/npc/cargo_tech
	name = "cyborg cargo technician"
	desc = "DO YOU REQUIRE HELP?"
	desc_extended = "A NanoTrasen model Cyborg unit programmed to assist those in asking stupid questions."
	ai = /ai/advanced/guarding

	move_mod = 1
	species = "cyborg"

	dialogue_id = /dialogue/tutorial/front_desk

	level = 1

	loadout = /loadout/nanotrasen/cargo_tech

	health = null

	anchored = TRUE
	density = TRUE

/mob/living/advanced/npc/cargo_tech/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)