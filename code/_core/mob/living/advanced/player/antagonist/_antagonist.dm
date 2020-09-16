/mob/living/advanced/player/antagonist/
	var/loadout/loadout_to_use
	class = /class/antagonist
	allow_save = FALSE

/mob/living/advanced/player/antagonist/proc/prepare()
	INITIALIZE(src)
	FINALIZE(src)
	stop_music_track(client)
	nutrition *= RAND_PRECISE(0.9,1)
	hydration *= RAND_PRECISE(0.9,1)

	var/species/S = all_species[species]

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	var/hair_color = random_color()
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))

	update_all_blends()

	equip_loadout(loadout_to_use)

	return TRUE

/mob/living/advanced/player/antagonist/default_appearance()
	var/species/S = all_species[species]
	handle_hairstyle_chargen(sex == MALE ? S.default_hairstyle_chargen_male : S.default_hairstyle_chargen_female,S.default_color_hair,FALSE)
	handle_beardstyle_chargen(1,S.default_color_hair,FALSE)
	handle_skincolor_chargen(S.default_color_skin,FALSE)
	handle_eyecolor_chargen(S.default_color_eye,FALSE)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/groin/syndicate_explosive)
	update_all_blends()
	return TRUE