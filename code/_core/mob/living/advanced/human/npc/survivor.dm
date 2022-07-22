/mob/living/advanced/npc/survivor
	name = "hostile survivor"
	desc = "Get off my lawn!"

	ai = /ai/advanced/suvivor

	level = 40

/mob/living/advanced/npc/survivor/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(SSspecies.all_hair_files[S.default_icon_hair]))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/space_cop)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/space_cop)

	update_all_blends()

	if(prob(25))
		if(gender == FEMALE)
			equip_loadout(/loadout/survivor/female/melee)
		else
			equip_loadout(/loadout/survivor/male/melee)

	else
		if(gender == FEMALE)
			equip_loadout(/loadout/survivor/female)
		else
			equip_loadout(/loadout/survivor/male)
