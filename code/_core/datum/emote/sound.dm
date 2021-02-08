/emote/sound/
	var/list/sounds_male = list()
	var/list/sounds_female = list()


	var/list/sounds_male_meme = list()
	var/list/sounds_female_meme = list()

/emote/sound/on_emote(var/atom/emoter,var/atom/target)
	. = ..()
	if(.)
		var/sound_to_play = get_sound_to_play(emoter,target)
		if(sound_to_play) play_sound(sound_to_play,get_turf(emoter),range_max=VIEW_RANGE)
	return .

/emote/sound/proc/get_sound_to_play(var/atom/emoter,var/atom/target)
	if(is_living(emoter))
		var/mob/living/L = emoter
		return L.get_emote_sound(id)
	return null

/emote/sound/laugh
	name = "Laugh"
	id = "laugh"
	action = "\The #USER laughs!"
	action_target = "\The #USER laughs at #TARGET!"

/emote/sound/cough
	name = "Cough"
	id = "cough"
	action = "\The #USER coughs."
	action_target = "\The #USER coughs on #TARGET."

/emote/sound/deathgasp
	name = "Death Gasp"
	id = "deathgasp"
	action = "\The #USER seizes up and falls limp, their eyes dead and lifeless..."

/emote/sound/gasp
	name = "Gasp"
	id = "gasp"
	action = "\The #USER gasps!"

/emote/sound/grenade
	name = "Grenade!"
	id = "grenade"
	action = "\The #USER primes a grenade!"

/emote/sound/medic
	name = "Medic!"
	id = "medic"
	action = "\The #USER calls out for a medic!"

/emote/sound/pain
	name = "Oof"
	id = "pain"
	action = "\The #USER cries in pain!"

	//sounds_male_meme = list('sound/voice/human/human_male_pain_9.ogg','sound/voice/human/human_male_pain_10.ogg')

/emote/sound/scream
	name = "Scream"
	id = "scream"
	action = "\The #USER screams!"
	action_target = "\The #USER screams at #TARGET!"

	//sounds_male_meme = list('sound/voice/human/human_male_scream_7.ogg')