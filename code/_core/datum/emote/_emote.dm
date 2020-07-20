/emote/
	var/name = "Emote"
	var/id = null

	var/action = "\The #USER stares as they cannot scream."
	var/action_target

	var/special = FALSE //Set to true if it can only be activated by code execution and not manually.

/emote/proc/on_emote(var/atom/emoter,var/atom/target)

	if(!target || !action_target)
		emoter.visible_message(span("emote",replacetextEx(action,"#USER","<b>[emoter.name]</b>")))
	else
		emoter.visible_message(span("emote",replacetextEx(action_target,"#USER","<b>[emoter.name]</b>")))

	return TRUE

/emote/sound/
	var/list/sounds_male = list()
	var/list/sounds_female = list()


	var/list/sounds_male_meme = list()
	var/list/sounds_female_meme = list()

/emote/sound/on_emote(var/atom/emoter,var/atom/target)

	. = ..()

	if(.)
		play(get_sound_to_play(emoter,target),get_turf(emoter))

	return .

/emote/sound/proc/get_sound_to_play(var/atom/emoter,var/atom/target)

	if(emoter.gender == FEMALE && length(sounds_female) > 0)
		if(length(sounds_female_meme) && prob(1))
			return pick(sounds_female_meme)
		return pick(sounds_female)

	if(length(sounds_male_meme) && prob(1))
		return pick(sounds_male_meme)

	return pick(sounds_male)

/emote/sound/laugh
	name = "Laugh"
	id = "laugh"
	action = "\The #USER laughs!"
	action_target = "\The #USER laughs at #TARGET!"

	sounds_male = list('sound/voice/human/human_male_laugh_1.ogg','sound/voice/human/human_male_laugh_2.ogg')
	sounds_female = list('sound/voice/human/human_female_laugh_1.ogg')

/emote/sound/cough
	name = "Cough"
	id = "cough"
	action = "\The #USER coughs."
	action_target = "\The #USER coughs on #TARGET."

	sounds_male = list('sound/voice/human/human_male_cough_1.ogg','sound/voice/human/human_male_cough_2.ogg')
	sounds_female = list('sound/voice/human/human_female_cough_1.ogg','sound/voice/human/human_female_cough_2.ogg')

/emote/sound/deathgasp
	name = "Death Gasp"
	id = "deathgasp"
	action = "\The #USER seizes up and falls limp, their eyes dead and lifeless..."

	sounds_male = list('sound/voice/human/human_male_deathgasp_1.ogg','sound/voice/human/human_male_deathgasp_2.ogg')
	sounds_female = list('sound/voice/human/human_female_deathgasp_1.ogg','sound/voice/human/human_female_deathgasp_2.ogg')

/emote/sound/gasp
	name = "Gasp"
	id = "gasp"
	action = "\The #USER gasps!"

	sounds_male = list('sound/voice/human/human_male_gasp_1.ogg','sound/voice/human/human_male_gasp_2.ogg','sound/voice/human/human_male_gasp_3.ogg')
	sounds_female = list('sound/voice/human/human_female_gasp_1.ogg','sound/voice/human/human_female_gasp_2.ogg')

/emote/sound/grenade
	name = "Grenade!"
	id = "grenade"
	action = "\The #USER primes a grenade!"

	sounds_male = list('sound/voice/human/human_male_grenadethrow_1.ogg','sound/voice/human/human_male_grenadethrow_2.ogg','sound/voice/human/human_male_grenadethrow_3.ogg')
	sounds_female = list('sound/voice/human/human_female_grenadethrow_1.ogg','sound/voice/human/human_female_grenadethrow_2.ogg','sound/voice/human/human_female_grenadethrow_3.ogg')

	special = TRUE

/emote/sound/medic
	name = "Medic!"
	id = "medic"
	action = "\The #USER calls out for a medic!"

	sounds_male = list('sound/voice/human/human_male_medic_1.ogg','sound/voice/human/human_male_medic_2.ogg')
	sounds_female = list('sound/voice/human/human_female_medic_1.ogg')

/emote/sound/pain
	name = "Oof"
	id = "pain"
	action = "\The #USER cries in pain!"

	sounds_male = list('sound/voice/human/human_male_pain_1.ogg','sound/voice/human/human_male_pain_2.ogg','sound/voice/human/human_male_pain_3.ogg','sound/voice/human/human_male_pain_4.ogg','sound/voice/human/human_male_pain_5.ogg','sound/voice/human/human_male_pain_6.ogg','sound/voice/human/human_male_pain_7.ogg','sound/voice/human/human_male_pain_8.ogg')
	sounds_female = list('sound/voice/human/human_female_pain_1.ogg','sound/voice/human/human_female_pain_2.ogg','sound/voice/human/human_female_pain_3.ogg')

	sounds_male_meme = list('sound/voice/human/human_male_pain_9.ogg','sound/voice/human/human_male_pain_10.ogg')

/emote/sound/scream
	name = "Scream"
	id = "scream"
	action = "\The #USER screams!"
	action_target = "\The #USER screams at #TARGET!"

	sounds_male = list('sound/voice/human/human_male_scream_1.ogg','sound/voice/human/human_male_scream_2.ogg','sound/voice/human/human_male_scream_3.ogg','sound/voice/human/human_male_scream_4.ogg','sound/voice/human/human_male_scream_5.ogg','sound/voice/human/human_male_scream_6.ogg','sound/voice/human/human_male_scream_special.ogg')
	sounds_female = list('sound/voice/human/human_female_scream_1.ogg','sound/voice/human/human_female_scream_2.ogg','sound/voice/human/human_female_scream_3.ogg','sound/voice/human/human_female_scream_4.ogg','sound/voice/human/human_female_scream_5.ogg')

	sounds_male_meme = list('sound/voice/human/human_male_scream_7.ogg')

/emote/dab
	name = "Dab"
	id = "dab"
	action = "\The #USER suddenly hits a dab!"
	action_target = "\The #USER dabs on #TARGET!"

/emote/laugh
	name = "Nod Head"
	id = "nod"
	action = "\The #USER nods."
	action_target = "\The #USER nods their head at #TARGET."

/emote/shake
	name = "Shake Head"
	id = "shake"
	action = "\The #USER shakes their head."
	action_target = "\The #USER shakes their head at #TARGET."

/emote/bow
	name = "Bow"
	id = "bow"
	action = "\The #USER bows."
	action_target = "\The #USER bows towards #TARGET."

/emote/fist
	name = "Shake Fist"
	id = "fist"
	action = "\The #USER shakes their fist."
	action_target = "\The #USER shakes their fist at #TARGET."

/emote/think
	name = "Think"
	id = "think"
	action = "\The #USER thinks."
	action_target = null

/emote/wave
	name = "Wave"
	id = "wave"
	action = "\The #USER waves."
	action_target = "\The #USER waves at #TARGET."

/emote/shrug
	name = "Shrug"
	id = "shrug"
	action = "\The #USER shrugs."
	action_target = null

/emote/cheer
	name = "Cheer"
	id = "cheer"
	action = "\The #USER cheers!"
	action_target = "\The #USER cheers #TARGET on!"

/emote/beckon
	name = "Beckon"
	id = "beckon"
	action = "\The #USER beckons."
	action_target = "\The #USER beckons #TARGET to come."

/emote/yawn
	name = "Yawn"
	id = "yawn"
	action = "\The #USER yawns."
	action_target = "\The #USER yawns at #TARGET."

/emote/cry
	name = "Cry"
	id = "cry"
	action = "\The #USER cries."
	action_target = "\The #USER cries towards #TARGET!"

/emote/clap
	name = "Clap"
	id = "clap"
	action = "\The #USER claps!"
	action_target = "\The #USER claps at #TARGET!"

/emote/salute
	name = "Salute"
	id = "salute"
	action = "\The #USER salutes!"
	action_target = "\The #USER salutes #TARGET!"