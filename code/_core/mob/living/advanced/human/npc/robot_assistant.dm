/mob/living/advanced/npc/cyborg_assistant
	name = "cyborg assistant"
	enable_AI = TRUE
	ai = null
	move_mod = 1
	species = "cyborg"
	class = "passive"
	dialogue_id = "cyborg_assistant"
	anchored = TRUE

/mob/living/advanced/npc/cyborg_assistant/Initialize()

	. = ..()

	update_all_blends()

	return .

/mob/living/advanced/npc/cyborg_assistant/bartender/Initialize()
	. = ..()
	equip_loadout("bartender")
	return .


/mob/living/advanced/npc/cyborg_assistant/help_desk/Initialize()
	. = ..()
	equip_loadout("help_desk")
	return .