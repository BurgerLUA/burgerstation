/datum/species/human/
	name = "Human"
	desc = "Vanilla as fuck."
	spawning_organs = list(
		"head" = /obj/item/organ/head,
		"torso" = /obj/item/organ/torso,
		"groin" = /obj/item/organ/groin,
		"l_leg" = /obj/item/organ/left_leg,
		"r_leg" = /obj/item/organ/right_leg,
		"l_foot" = /obj/item/organ/left_foot,
		"r_foot" = /obj/item/organ/right_foot,
		"r_arm" = /obj/item/organ/right_arm,
		"l_arm" = /obj/item/organ/left_arm,
		"l_hand" = /obj/item/organ/left_hand,
		"r_hand" = /obj/item/organ/right_hand
	)

	attribute_defaults = list(
		ATTRIBUTE_STRENGTH = 15,
		ATTRIBUTE_VITALITY = 15,
		ATTRIBUTE_FORTITUDE = 15,

		ATTRIBUTE_INTELLIGENCE = 15,
		ATTRIBUTE_RESOLVE = 15,
		ATTRIBUTE_WILLPOWER = 15,

		ATTRIBUTE_AGILITY = 15,
		ATTRIBUTE_ENDURANCE = 15,
		ATTRIBUTE_LUCK = 50
	)

	skill_defaults = list(
		SKILL_UNARMED = 5,
		SKILL_MELEE = 5,
		SKILL_RANGED = 5,

		SKILL_BLOCK = 5,
		SKILL_DODGE = 5,
		SKILL_PARRY = 5,

		SKILL_MAGIC_OFFENSIVE = 0,
		SKILL_MAGIC_DEFENSIVE = 0,
		SKILL_MAGIC_SUPPORT = 0,

		SKILL_STEALTH = 5,
		SKILL_LOCKPICKING = 5,
		SKILL_THEFT = 0,

		SKILL_ALCHEMY = 5,
		SKILL_COOKING = 5,
		SKILL_ENCHANTING = 0
	)