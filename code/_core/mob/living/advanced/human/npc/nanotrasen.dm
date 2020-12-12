/mob/living/advanced/npc/nanotrasen
	name = "nanotrasen security personnel"
	desc = "A security team that actually follows orders!"
	desc_extended = "A low-ranking NanoTrasen soldier tasked with defending the station and assisting with higher ranking NanoTrasen personnel with missions."
	enable_AI = TRUE
	ai = /ai/advanced/nanotrasen
	class = /class/syndicate_soldier
	dialogue_id = /dialogue/npc/soldier/
	var/loadout_to_use = /loadout/nanotrasen/soldier

/mob/living/advanced/npc/nanotrasen/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()

	equip_loadout(loadout_to_use)

	return .


/mob/living/advanced/npc/nanotrasen/shaft_miner
	name = "shaft miner"
	desc = "Someone didn't do their job."
	dialogue_id = null
	loadout_to_use = /loadout/shaft_miner