/mob/living/advanced/npc/contractor_guard
	name = "nanotrasen elite guard"
	desc = "The very best assigned to guard this old man."

	ai = /ai/advanced/guarding

	dialogue_id = null

	var/loadout_to_use = /loadout/nanotrasen/elite

	level = 80

/mob/living/advanced/npc/contractor_guard/Initialize()

	. = ..()

	var/species/S = SPECIES(species)

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(SSspecies.all_hair_files[S.default_icon_hair]))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(SSspecies.all_hair_files[S.default_icon_hair_face]))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()

	equip_loadout(loadout_to_use)

