/mob/living/advanced/npc/sorcerer
	name = "syndicate sorcerer"
	desc = "A sorcerer borrowed from the syndicate-allied wizard federation."
	ai = /ai/advanced
	class = /class/syndicate_soldier

	var/list/possible_outfits = list(
		/loadout/sorcerer = 1
	)

	var/loadout_to_level = list(
		/loadout/sorcerer = 1
	)

/mob/living/advanced/npc/sorcerer/Initialize()

	var/loadout_to_use = pickweight(possible_outfits)
	level_multiplier *= loadout_to_level[loadout_to_use]

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)

	update_all_blends()

	equip_loadout(loadout_to_use)



	return .