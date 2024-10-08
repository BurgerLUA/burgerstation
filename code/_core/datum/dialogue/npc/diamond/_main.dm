/dialogue/npc/diamond/

/dialogue/npc/diamond/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Oh. Hello there."
	)

	dialogue_options["the mayor"] = list(
		"Oh, yes. That is me. That is not my name though, I am #1.",
		"Diamond with Flaw"
	)

	dialogue_options["Diamond with Flaw"] = list(
		"Oh, you are new. I do not believe we have met. I am Diamond with Flaw; a #1. The villagers call me #2, for some reason. I suppose you're here to know more about the #3? Your #4?",
		"dionae",
		"the mayor",
		"the realm",
		"immortality"
	)

	if(P.species == "diona")
		dialogue_options["dionae"] = list(
			"It is always good to see a fellow dionae around.",
		)
	else
		dialogue_options["dionae"] = list(
			"We are dionae, yes. We are a collection of #1, smaller lifeforms, to form one #2.",
			"nymph",
			"gestalt"
		)

	dialogue_options["nymph"] = list(
		"We #1 are made up of a collection of several nymphs to form a #2. We are a coalition of thoughts and decisions and actions... a collective if you will.",
		"dionae",
		"gestalt"
	)

	dialogue_options["gestalt"] = list(
		"What you see before you is a gestalt; a biped of #1s sharing thoughts and decisions together as one collective.",
		"nymph"
	)

	dialogue_options["immortality"] = list(
		"Yes, you are immortal now. Technically. You do not feel #1, you cannot age naturally, and #2 is meaningless to you. You can still die, but you will be #3 in a way.",
		"pain",
		"death",
		"reborn"
	)

	dialogue_options["pain"] = list(
		"You feel pain like us #1 do; not at all. The pain you would normally feel is replaced by a dull signal, that tells your brain casually that your body may be injured. \
		It wasn't always like this, though. In #2, you felt pain like you would in the real world, but I believe #3 somehow changed this.",
		"dionae",
		"the beginning",
		"The Old Man"
	)

	dialogue_options["death"] = list(
		"It is the most accurate term to describe what happens to you when your body gives up. Unfortunately you will be #1 again when it happens.",
		"reborn"
	)

	dialogue_options["reborn"] = list(
		"When your soul cannot be sustained by your body, it leaves your body... only to be captured again and transfered into a copy of your physical form. \
		This process is done near #1 scattered around #2.",
		"wishgranter",
		"the realm"
	)

	dialogue_options["the realm"] = list(
		"#1 was wise to bring you to me to teach you of this. I was one of the few here during #2. I know our history more than anyone else here... except for #3. Well, assuming they're still here.",
		"Ilaeza Marwani",
		"the beginning",
		"The Old Man"
	)

	dialogue_options["the beginning"] = list(
		"Oh, it was quite horrible. Everything was a wasteland of endless grey ash and bluespace skies. There were... roaming souls that you'd meet on ocassion. \
		Most were driven mad by the lack of material objects, and would try their best to rob the other souls of their possessions by combat.NEWLINE\
		It wasn't until #2 came and reshaped the land and the very people in it. He organized most of the lost souls into rebuilding and farming. \
		He gave his followers weapons to fight those who did not believe his goals, and that protection mostly convinced those to rise together.",
		"The Old Man"
	)

	dialogue_options["The Old Man"] = list(
		"Ah, yes. The Old Man. Not much is known about him, save for his exploits in #1. He disappeared after some time after. Many believe he found #2 after he estabilished #3.",
		"the beginning",
		"a way out"
	)

	dialogue_options["a way out"] = list(
		"Leaving this place is something many of us have been trying to figure out, including #1. \
		For nearly 500 years, I have been exchanging letters with #1 on a daily basis, sharing my findings with him and him doing the same. \
		We both needed to leave the realm, but for different, non-conflicting reasons. We both trusted eachother but... he stopped. \
		For an entire 2 weeks I received no letters from them. Initially I thought that perhaps he grew distrustful of me... but then it came.NEWLINENEWLINE\
		#2.",
		"The Old Man",
		"the final message"
	)

	dialogue_options["the final message"] = list(
		"I found it. Instructions will follow.\"NEWLINE\
		That was the final message. After a month of silence, those were the words he wrote to break it.\
		I tasked the entire village to look absolutely everywhere for these instructions... I told them to look to the seas... to look to the skies... to the very ground they stood on. \
		To report anything and anything that looked unusual...NEWLINE\
		... But there was nothing. The instructions did not arrive, and if it did, we missed it entirely.NEWLINE\
		I was quite distraught over this event. I am a #1; we can live for several thousands of years, physically, but mentally we become... something else entirely. \
		We begin to lose ourselves if we do not return to #2 after experiencing a truely unique event. \
		I believe that I am starting to lose myself after visiting this place, and my time is running short before I finally succumb to #3.\
		This matter needs to be resolved. I want you to resolve this matter. I am assigning you this #4 as I have to others.NEWLINENEWLINE\
		I need you to save me from myself, and find a way out. That is your #4, if you choose to accept it.",
		"diona",
		"the singularity",
		"gestalt sickness",
		"task"
	)

	dialogue_options["task"] = list(
		"It is no easy task. You have only but a small bread crumb trail to follow: #1. Speak to them about #2. They will understand.",
		"The Courier",
		"the final message"
	)

	dialogue_options["The Courier"] = list(
		"They are a lizardperson who goes by the name of #1. You can find them lingering near #2.",
		"Bar Shaleez",
		"the main gate"
	)

	if(known_options["the final message"])
		dialogue_options["Bar Shaleez"] = list(
			"They go by \"#1\" given their occupation. They organize deliveries involving messages of great importance. \
			I do not know their methods; they never leave the village... yet... somehow their messages arrive to their recipients through letter.",
			"The Courier")
	else
		dialogue_options["Bar Shaleez"] = list("I do know know of who you speak of.")


	dialogue_options["the singularity"] = list("It is home for #1. In the end of our lives, we then go on a voyage in space, searching for the singularity to finally become one. \
		I must make this journey, however I cannot as I am stuck in this place.")

	dialogue_options["gestalt sickness"] = list("I do not wish to speak of this, please. This is a personal matter.")

	dialogue_options["the main gate"] = list(
		"The main gate is located south of the #1 in the village. It is also close to #2's entrance.",
		"wishgranter",
		"the bar"
	)

	if(known_options["The Old Man"])
		dialogue_options["wishgranter"] = list(
		"One of the creations of #1. In #2, #3 would cause you to be #4 in a random location in the ash. \
		The wishgranter acts as some sort of soul anchor that forces you to be reborn on the wishgranter's doorstep.",
		"The Old Man",
		"the beginning",
		"death",
		"reborn"
		)
	else
		dialogue_options["wishgranter"] = list(
			"Ah, I do not know much about them. I just know that when others die, they tend to end up back outside the wishgranter."
		)

	return dialogue_options

