/dialogue/npc/diamond/
	name = "Diamond with Flaw"
	id = "diamond_dialogue"

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
		"Oh, you are new. I do not believe we have met. I am Diamond with Flaw; a #1. The villagers call me #2, for some reason. I suppose you're here to know more about the #3? Your #4 Or perhaps offer #5?",
		"dionae",
		"the mayor",
		"realm",
		"immortality",
		"assistance"
	)

	dialogue_options["assistance"] = list(
		"We're looking for someone capable of leaving the safety of #1 and investigating a few... #2. Are you interested?",
		"the village",
		"disturbances"
	)

	dialogue_options["disturbances"] = list(
		"We fear that the safety of those in the realm may be at risk. I shall not go into too much detail, as I do not #1 you quite yet, but we have discovered a credible threat to the realm and possibly beyond it.\n\
		In short, we believe that the #2 are up to something in #3 to the west. We would like you to investigate on our behalf and find out what they're up to. Report your #4 back to me, and only me, when you are done.",
		"trust",
		"cultists",
		"the caves",
		"findings on the disturbances"
	)

	dialogue_options["dionae"] = list(
		"We are dionae, yes. We are a collection of nymphs to form one gestalt./nAre you interested in #1?",
		"becoming a dionae"
	)

	dialogue_options["becoming a dionae"] = list(
		"Most organic lifeforms become a part of a diona by soul absorbtion through assimilation, however given your #1 it would be a pointless task. There are #2, but I cannot speak of them.",
		"immortality",
		"other ways of becoming a diona"
	)

	dialogue_options["immortality"] = list(
		"Yes, you are immortal now. Technically. You do not feel #1, and #2 is meaningless to you.",
		"pain",
		"death"
	)

	dialogue_options["pain"] = list(
		"Oh, I mean physical pain. You can still feel mental or emotional pain. This wouldn't make a good realm to torture souls if they couldn't be tortured. \
		Some see this as a drawback, as it means they don't know if their body is injured. I've seen people collapse in the village, not realising that their bones were broken from an earlier fight."
	)

	dialogue_options["death"] = list(
		"It is the most accurate term to describe what happens to you when your body gives up. When that happens, your soul is removed from your body, and placed in a new one.\
		As #1 should have explained to you, you will lose all material possessions upon this death.",
		"Ilaeza Marwani"
	)

	dialogue_options["other ways of becoming a diona"] = list(
		"I do not #1 you to speak about this. Perhaps offer your #2 first, and I can tell you the secrets of this.",
		"trust",
		"assistance"
	)

	dialogue_options["realm"] = list(
		"#1 was wise to bring you to me. I was here during #2. I know everything there is to #3.",
		"Ilaeza Marwani",
		"the beginning",
		"the rule"
	)

	dialogue_options["the beginning"] = list(
		"Oh, it was quite horrible. People would fight endlessly as #1 did not exist at that time. \
		It wasn't until #2 came and reshaped the land and the very people in it. He organized most of the lost souls into rebuilding and farming. \
		He gave his followers weapons to fight those who did not believe his goals.",
		"the old man"
	)

	dialogue_options["the old man"] = list(
		"Ah, yes. A mysterious fellow. Not much is known about him, save for his exploits in #1. He disappeared after some time after. Many believe he found #2.",
		"the beginning",
		"a way out"
	)

	dialogue_options["a way out"] = list(
		"Leaving the realm is something many of us have been trying to figure out. Most of us do this in secret in fear or some of the less desirable inhabitants following us into the next life. We believe that #1 secretly found a way out as he spoke of this quite a bit before disappearing. \
		However, this is not something I wish to discuss with you.",
		"the old man",
	)

	dialogue_options["the rule"] = list(
		"It is simple. Do not go around #1 unless you wish to invoke #2.",
		"killing humans",
		"wraith of Nar-sie"
	)

	dialogue_options["wraith of Nar-sie"] = list(
		"If you are fond of #1, you will be punished by #2. Strange #3 will confront you and attempt to kill you. We wish to put an #4 not because of this, but rather because of the #5.",
		"killing humans",
		"death",
		"assassins",
		"end to the rule",
		"exceptions to the rule"
	)

	dialogue_options["assassins"] = list(
		"I have not seen them as I do not kill humans, and I am part of the #1. Perhaps they do not exist, and are just a myth. There is only one way to find out.",
		"exceptions to the rule"
	)

	dialogue_options["killing humans"] = list(
		"Yes, humans. You can kill #1, the #2, or #3 as much as you want, just do not kill humans. There are some #4, however, which we are concerned about.",
		"reptile people",
		"diona",
		"creatures",
		"exceptions to the rule"
	)

	dialogue_options["creatures"] = list(
		"Oh, yes. There are other lifeforms stuck here. Most are quite hostile and angry that they are here."
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
		"For some strange reason, #1 only applies to #2. An organic can kill the #3 or #4 as much as they want without invoking #5. It does not matter if you kill in #6 either, even as a human. Many of us believe that this is an injustice, so we wish to put an #7.",
		"the rule",
		"killing humans",
		"reptile people",
		"diona",
		"wraith of Nar-sie",
		"self defense",
		"end of the rule"
	)

	dialogue_options["end of the rule"] = list(
		"We believe that we can bring an end to #1. This rule was not put in by #2, but by something else. Perhaps #3. Perhaps the #4. We do not know, and I shall speak no further of this until you earn my #4.",
		"the rule",
		"Nar-sie",
		"the old man",
		"trust"
	)

	dialogue_options["self defense"] = list(
		"Eventually you will reach a point in your journey where someone may wish to kill you out of sport or neccesity. Unfortunately, #1 prevents you from #2 in self defense as it will #3. \
		This can be prevented by knocking the human out instead or avoiding all conflict together by staying in areas where you feel #4.",
		"the rule",
		"killing humans",
		"wraith of Nar-sie",
		"pacfism"
	)

	dialogue_options["pacifism"] = list(
		"Pacifsm protects most of the villagers that wish not to be harmed in the few #1 in this realm. It is the feeling you get when you are near a #2.",
		"settlements",
		"wishgranter",
	)

	dialogue_options["wishgranter"] = list(
		"Wishgranters are ressurection points for spirits trapped in this realm. This one in #1 is where new souls come in.",
		"the village"
	)

	dialogue_options["cultists"] = list(
		"They are the servants of #1. They are tasked with bringing as much suffering to the souls in this realm as possible. Do not trust them.",
		"Nar-sie"
	)
	dialogue_options["Nar-sie"] = list(
		"Nar-sie is the dark lord who looks over this realm. Allegedly. Other than the #1 and hearsay, there is no evidence of Nar-sie's influence here. Yet.",
		"cultists"
	)


	return dialogue_options

