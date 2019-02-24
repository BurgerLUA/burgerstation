/dialogue/npc/diamond/
	name = "Diamond with Flaw"
	id = "diamond_dialogue"

/dialogue/npc/diamond/get_dialogue_options(var/mob/living/advanced/player/P)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Oh, hello there.",
		"the mayor",
		"goodbye"
	)

	dialogue_options["the mayor"] = list(
		"Oh, yes. That is #1.",
		"me"
	)

	dialogue_options["me"] = list(
		"Oh, you are new. I do not believe we have met. I am #1. The villagers call me #2. Do you wish to know more about the #3?",
		"Diamond with Flaw",
		"the mayor",
		"realm"
	)

	dialogue_options["Diamond with Flaw"] = list(
		"When I became a #1, that is the name I took. I don't remember why, though. A shame.",
		"dionae"
	)

	dialogue_options["dionae"] = list(
		"We are diona. I do not know if you have seen us before./nAre you interested in #1?",
		"becoming a dionae"
	)

	dialogue_options["becoming a dionae"] = list(
		"Most organic lifeforms become a part of a diona by soul absorbtion through digestion, however given your #1 it would be a pointless task. There are #2, but I cannot speak of them.",
		"immortality",
		"other ways of becoming a diona"
	)

	dialogue_options["other ways of becoming a diona"] = list(
		"I do not trust you. Perhaps I will trust you in the future."
	)

	dialogue_options["realm"] = list(
		"#1 was wise to bring you to me as I've been here the longest. I know #2.",
		"Ilaeza Marwani",
		"the rule"
	)

	dialogue_options["the rule"] = list(
		"It is simple. Do not go around #1 unless you wish to invoke #2.",
		"killing humans",
		"wraith of Nar-sie"
	)

	dialogue_options["wraith of Nar-sie"] = list(
		"If you break #1, you will be punished with death. I do not like calling it the wraith of Nar-sie as it is not something Nar-sie would do.",
		"the rule"
	)

	dialogue_options["killing humans"] = list(
		"Yes, humans. You can kill #1, the #2, or #3 as much as you want, just do not kill humans. There are some #4, however.",
		"reptile people",
		"diona",
		"creatures",
		"exceptions to the rule"
	)

	dialogue_options["creatures"] = list(
		"Oh, yes. There are other lifeforms stuck here. Most are quite hostile and angry that they are here. It is quite entertaining watching a creature kill a human, as creatures are subject to #1.",
		"the rule"
	)

	dialogue_options["reptile people"] = list(
		"Yes, the reptile woman you met earlier, #1, was one of them. They have many names. Unathi. Soghun. In order to #2 they have refered to themselves as 'the reptile people.'",
		"Ilaeza Marwani",
		"appease the humans"
	)

	dialogue_options["Ilaeza Marwani"] = list(
		"Ah, yes. She is the caretaker of the village. I do not believe that she is doing it to be kind, but in order to #1 as she is one of the #2.",
		"appease the humans",
		"exceptions to the rule"
	)


	dialogue_options["appease the humans"] = list(
		"The reptile people wish to appear more tolerable to the humans. They do not mention the culture or workings of their past life to anyone but themselves. It is a shame, but it is with good reason that they do this. They are one of #1.",
		"exceptions to the rule"
	)

	dialogue_options["exceptions to the rule"] = list(
		"For some strange reason, #1 only applies to #2. An organic can kill the #3 or #4 as much as they want without invoking #5. Many of us believe that this is an injustice, and wish to #6.",
		"the rule",
		"killing humans",
		"reptile people",
		"diona",
		"wraith of Nar-sie",
		"end the rule"
	)

	dialogue_options["end the rule"] = list(



	)



	return dialogue_options

