/mob/living/advanced/get_emote_sound(var/emote_id)

	. = ..()

	if(.) return .

	var/species/S = SPECIES(species)
	if(gender == MALE)
		if(S.emote_sounds_male[emote_id])
			return pick(S.emote_sounds_male[emote_id])
	else if(gender == FEMALE)
		if(S.emote_sounds_female[emote_id])
			return pick(S.emote_sounds_female[emote_id])

	return null