/mob/living/advanced/npc/unique/hostage/
	ai = /ai/advanced/hostage
	health_base = 200 //Extra health so the escort mission isn't fucking hell.
	var/hostage = TRUE
	level = 4

/mob/living/advanced/npc/unique/hostage/Initialize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

/mob/living/advanced/npc/unique/hostage/assistant
	name = "Urist McRobust"
	sex = MALE
	gender = MALE
	dialogue_id = /dialogue/npc/hostage/assistant

/mob/living/advanced/npc/unique/hostage/assistant/Initialize()
	. = ..()
	update_all_blends()
	equip_loadout(/loadout/new_player)

/mob/living/advanced/npc/unique/hostage/clown
	name = "Charles the Clown"
	sex = MALE
	gender = MALE
	dialogue_id = /dialogue/npc/hostage/assistant

/mob/living/advanced/npc/unique/hostage/clown/Initialize()
	. = ..()
	update_all_blends()
	equip_loadout(/loadout/clown)

/mob/living/advanced/npc/unique/hostage/scientist
	name = "Chad Thundercock"
	sex = MALE
	gender = MALE
	dialogue_id = /dialogue/npc/hostage/assistant

/mob/living/advanced/npc/unique/hostage/scientist/Initialize()
	. = ..()
	update_all_blends()
	equip_loadout(/loadout/scientist)
