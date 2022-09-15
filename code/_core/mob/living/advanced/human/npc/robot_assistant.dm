/mob/living/advanced/npc/cyborg_assistant
	name = "cyborg assistant"
	desc = "DO YOU REQUIRE HELP?"
	desc_extended = "A NanoTrasen model Cyborg unit programmed to assist those in asking stupid questions."
	ai = null
	move_mod = 1
	species = "cyborg"

	dialogue_id = /dialogue/tutorial/front_desk
	anchored = TRUE

	level = 1

/mob/living/advanced/npc/cyborg_assistant/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)

/mob/living/advanced/npc/cyborg_assistant/bartender
	loadout = /loadout/cyborg_assistant/bartender

/mob/living/advanced/npc/cyborg_assistant/help_desk
	loadout = /loadout/cyborg_assistant/help_desk

/mob/living/advanced/npc/cyborg_assistant/debug
	dialogue_id = null