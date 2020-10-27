/mob/living/advanced/player/antagonist/
	var/loadout/loadout_to_use
	class = /class/antagonist
	allow_save = FALSE

	damage_received_multiplier = 0.5

/mob/living/advanced/player/antagonist/proc/prepare()
	INITIALIZE(src)
	FINALIZE(src)
	stop_music_track(client)
	nutrition *= RAND_PRECISE(0.9,1)
	hydration *= RAND_PRECISE(0.9,1)

	var/species/S = all_species[species]

	sex = pick(MALE,FEMALE)
	gender = sex

	default_appearance()

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
	update_all_blends()
	return TRUE


/mob/living/advanced/player/antagonist/on_level_up(var/experience/E,var/old_level,var/new_level)

	. = ..()

	if(client && new_level - old_level > 0)
		var/experienced_gained = FLOOR(E.level_to_xp(new_level) - E.level_to_xp(old_level) * 0.75,1)
		if(!experienced_gained)
			return .
		var/savedata/client/globals/G = GLOBALDATA(client.ckey)
		if(!G)
			return .
		if(!G.loaded_data["stored_experience"]) G.loaded_data["stored_experience"] = list()
		G.loaded_data["stored_experience"][E.id] += experienced_gained
		to_chat(span("notice","You gained [experienced_gained] global [E.id] experience."))

	return .