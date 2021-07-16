/mob/living/advanced/npc/syndicate
	name = "syndicate operative"
	desc = "A member of the Syndicate crime organization."
	ai = /ai/advanced/syndicate

	dialogue_id = /dialogue/npc/soldier

	var/list/possible_outfits = list(
		/loadout/syndicate/soldier = 90,
		/loadout/syndicate/shotgunnner = 20,
		/loadout/syndicate/basic = 6,
		/loadout/syndicate/advanced = 3,
		/loadout/syndicate/elite = 1
	)

	var/loadout_to_level = list(
		/loadout/syndicate/soldier = 2,
		/loadout/syndicate/shotgunnner = 2,
		/loadout/syndicate/basic = 4,
		/loadout/syndicate/advanced = 8,
		/loadout/syndicate/elite = 16
	)

/mob/living/advanced/npc/syndicate/Initialize()

	var/loadout_to_use = pickweight(possible_outfits)
	level *= loadout_to_level[loadout_to_use]

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

/mob/living/advanced/npc/syndicate/double

/mob/living/advanced/npc/syndicate/triple

/mob/living/advanced/npc/syndicate/quadruple

/mob/living/advanced/npc/syndicate/stress_test
	name = "stress test"
	ai = /ai/advanced/syndicate/stress_test

/mob/living/advanced/npc/syndicate/scientist
	name = "syndicate scientist"

	possible_outfits = list(/loadout/syndicate/scientist)
	loadout_to_level = list(/loadout/syndicate/scientist=1)