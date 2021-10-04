/mob/living/advanced/npc/space_soldier
	name = "space soldier"
	desc = "Spreading democracy since 1775."

	ai = /ai/advanced

	dialogue_id = /dialogue/npc/soldier/

	level = 70

	var/list/possible_loadouts = list(
		/loadout/space_soldier/assault_rifle = 4,
		/loadout/space_soldier/battle_rifle = 2,
		/loadout/space_soldier/dmca = 1
	)

/mob/living/advanced/npc/space_soldier/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/space_cop)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/space_cop)

	update_all_blends()

	equip_loadout(pickweight(possible_loadouts))

