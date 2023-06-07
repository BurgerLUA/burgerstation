/mob/living/advanced/npc/space_soldier
	name = "space soldier"
	desc = "Spreading democracy since 1775."

	dna = /dna/human

	ai = /ai/advanced/space_soldier

	dialogue_id = /dialogue/npc/soldier/

	soul_size = SOUL_SIZE_UNCOMMON

	level = 60

	var/list/possible_loadouts = list(
		/loadout/space_soldier/assault_rifle = 4,
		/loadout/space_soldier/battle_rifle = 2,
		/loadout/space_soldier/dmca = 1
	)

/mob/living/advanced/npc/space_soldier/Initialize()
	loadout = pickweight(possible_loadouts)
	. = ..()

/mob/living/advanced/npc/space_soldier/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/space_cop)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/space_cop)


/mob/living/advanced/npc/space_soldier/special_operative
	name = "space special operative"

	dialogue_id = null

	ai = /ai/advanced/space_soldier/special

	possible_loadouts = list(
		/loadout/space_soldier/spec_ops = 1
	)

	level = 90