/mob/living/advanced/npc/cyborg_assistant
	name = "cyborg assistant"
	desc = "DO YOU REQUIRE HELP?"
	desc_extended = "A NanoTrasen model Cyborg unit programmed to assist those in asking stupid questions."
	enable_AI = TRUE
	ai = null
	move_mod = 1
	species = "cyborg"
	class = /class/cyborg/
	dialogue_id = /dialogue/tutorial/front_desk
	anchored = TRUE

/mob/living/advanced/npc/cyborg_assistant/Initialize()

	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	update_all_blends()

	return .

/mob/living/advanced/npc/cyborg_assistant/bartender/Initialize()
	. = ..()
	equip_loadout(/loadout/cyborg_assistant/bartender)
	return .


/mob/living/advanced/npc/cyborg_assistant/help_desk/Initialize()
	. = ..()
	equip_loadout(/loadout/cyborg_assistant/help_desk)
	return .


/mob/living/advanced/npc/cyborg_assistant/debug
	dialogue_id = null