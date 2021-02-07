/emote/dab
	name = "Dab"
	id = "dab"
	action = "\The #USER suddenly hits a dab!"
	action_target = "\The #USER dabs on #TARGET!"

/emote/nod
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

/emote/spin
	name = "Spin"
	id = "spin"
	action = null
	action_target = null

/emote/spin/proc/spin(var/atom/emoter,var/spins_remaining=0)

	emoter.set_dir(turn(emoter.dir,90))

	if(spins_remaining > 0)
		CALLBACK("\ref[emoter]_spin",1,src,.proc/spin,emoter,spins_remaining-1)

/emote/spin/on_emote(var/atom/emoter,var/atom/target)
	spin(emoter,12)
	return ..()