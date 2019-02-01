/class/botanist
	name = "The Botanist"
	desc = "\
		The Botanist is known for their love of plants, nature, and their trusty hatchet. Years of working with plants and putting up with the \
		chef's bullshit have given them a considerable amount of natural recovery and fortitude. The fact that they're also a fucking talking tree also helps."
	id = "botanist"

	starting_species = /species/diona

	//Limits:
	//1 ATTRIBUTE_STARTING_PRIMARY
	//2 ATTRIBUTE_STARTING_SECONDARY
	//3 ATTRIBUTE_STARTING_TERTIARY
	//3 ATTRIBUTE_STARTING_NONE
	//Luck untouched
	//10 total attributes
	attributes = list(
		ATTRIBUTE_STRENGTH = ATTRIBUTE_STARTING_SECONDARY,
		ATTRIBUTE_VITALITY = ATTRIBUTE_STARTING_TERTIARY,
		ATTRIBUTE_FORTITUDE = ATTRIBUTE_STARTING_PRIMARY,

		ATTRIBUTE_INTELLIGENCE = ATTRIBUTE_STARTING_TERTIARY,
		ATTRIBUTE_RESOLVE = ATTRIBUTE_STARTING_TERTIARY,
		ATTRIBUTE_WILLPOWER = ATTRIBUTE_STARTING_NONE,

		ATTRIBUTE_DEXTERITY = ATTRIBUTE_STARTING_SECONDARY,
		ATTRIBUTE_AGILITY = ATTRIBUTE_STARTING_NONE,
		ATTRIBUTE_ENDURANCE = ATTRIBUTE_STARTING_NONE,

		ATTRIBUTE_LUCK = 50
	)

	attribute_descriptions = list(
		ATTRIBUTE_STRENGTH 		= "During one shift, I decided to say \"fuck it\" and grow 2000 tower caps and cut them all down. I gave them all to the clown to make barriers in the hallway with.",
		ATTRIBUTE_VITALITY 		= "I'm pretty sure I have arthritis somehow.",
		ATTRIBUTE_FORTITUDE 	= "Handling plants nearly all my life has given me skin denser than the Head of Security. Also being immune to any sort of pain helps.",

		ATTRIBUTE_INTELLIGENCE 	= "The human education system was really boring so I just smoked vulgaris in the bathroom between classes.",
		ATTRIBUTE_RESOLVE 		= "Yeah I'm pretty sure all that vulgaris I smoked gave me some sort of tolerance.",
		ATTRIBUTE_WILLPOWER 	= "It's very difficult to get any sort of pussy when all the pickup lines you have are wood related.",

		ATTRIBUTE_DEXTERITY 	= "Given how I spend most of my time with hoes, I'd say I'm pretty good with my hands.",
		ATTRIBUTE_AGILITY 		= "Hahahahahahahaha.",
		ATTRIBUTE_ENDURANCE 	= "I'm as about as strong as my plants.",

		ATTRIBUTE_LUCK 			= "At least I'm not cursed."
	)

	//Limits
	//3 SKILL_STARTING_PRIMARY
	//3 SKILL_STARTING_SECONDARY
	//3 SKILL_STARTING_TERTIARY
	//13 SKILL_STARTING_NONE
	//22 total skills
	skills = list(
		SKILL_RANGED = SKILL_STARTING_SECONDARY,
		SKILL_DODGE = SKILL_STARTING_NONE,
		SKILL_STEALTH = SKILL_STARTING_TERTIARY,
		SKILL_ATHLETICS = SKILL_STARTING_NONE,
		SKILL_INSTINCT = SKILL_STARTING_PRIMARY,
		SKILL_PARRY = SKILL_STARTING_NONE,

		SKILL_MELEE = SKILL_STARTING_PRIMARY,
		SKILL_BLOCK = SKILL_STARTING_NONE,
		SKILL_UNARMED = SKILL_STARTING_NONE,
		SKILL_PRAYER = SKILL_STARTING_NONE,
		SKILL_ARMOR = SKILL_STARTING_NONE,
		SKILL_RECOVERY = SKILL_STARTING_PRIMARY,

		SKILL_MEDICINE = SKILL_STARTING_SECONDARY,
		SKILL_MAGIC_OFFENSIVE = SKILL_STARTING_NONE,
		SKILL_MAGIC_SUPPORT = SKILL_STARTING_NONE,
		SKILL_MAGIC_DEFENSIVE = SKILL_STARTING_NONE,
		SKILL_MAGIC_REALITY = SKILL_STARTING_NONE,
		SKILL_MAGIC_CHAOS = SKILL_STARTING_NONE,

		SKILL_ALCHEMY = SKILL_STARTING_SECONDARY,
		SKILL_COOKING = SKILL_STARTING_TERTIARY,
		SKILL_CRAFTING = SKILL_STARTING_TERTIARY,
		SKILL_ENCHANTING = SKILL_STARTING_NONE
	)

	skill_descriptions = list(
		SKILL_RANGED 			= "I mean if some asshole came in and fucked with the plants, I can't really chase them down. Sometimes throwing wads of fertilizer helps.",
		SKILL_DODGE 			= "Hahahahahahahahahah.",
		SKILL_STEALTH 			= "Well, the ability to not make footsteps helps.",
		SKILL_ATHLETICS 		= "Hahahahahahahahahahahahahahahaha.",
		SKILL_INSTINCT 			= "One shift the clown announced that the Captain willingly gave the Clown the Head of Security role. I was the first to realise that something was up.",
		SKILL_PARRY 			= "Why worry about getting hit when you can just outlast them?",

		SKILL_MELEE 			= "I know how to use an axe.",
		SKILL_BLOCK 			= "Why worry about getting hit when you can just outlast them?",
		SKILL_UNARMED 			= "Why would I use my fists when I could just use an axe?",
		SKILL_PRAYER 			= "Despite having the ability to live for thousands of years, we diona have very little time for religion.",
		SKILL_ARMOR 			= "Armor would just slow us down even more.",
		SKILL_RECOVERY 			= "Diona can easily recover wounds naturally.",

		SKILL_MEDICINE 			= "Given how I know what every plant does to the body, I would say I'm quite experienced in using medicine.",
		SKILL_MAGIC_OFFENSIVE 	= "Magic?",
		SKILL_MAGIC_SUPPORT 	= "What fucking magic?",
		SKILL_MAGIC_DEFENSIVE 	= "Seriously, is this a real question?",
		SKILL_MAGIC_REALITY 	= "Yeah I think you need more reality, bud.",
		SKILL_MAGIC_CHAOS 		= "Now you're just being passive aggressive.",

		SKILL_ALCHEMY 			= "Banana-Watermelon hybrid plants are my favorite.",
		SKILL_COOKING 			= "I mean I learned how to cook meth once but I didn't really like the taste.",
		SKILL_CRAFTING 			= "I saw an engineer put in a lightbulb once.",
		SKILL_ENCHANTING 		= "It's very hard to seduce people when you don't have the benefit of genitals."
	)