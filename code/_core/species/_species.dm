/datum/species/
	var/name = "BLANK SPECIES"
	var/desc = "OH MY GOD"

	var/list/obj/item/organ/spawning_organs = list()

	var/list/attribute_defaults = list(
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

	var/list/skill_defaults = list(
		SKILL_UNARMED = 5,
		SKILL_MELEE = 5,
		SKILL_RANGED = 5,

		SKILL_BLOCK = 5,
		SKILL_DODGE = 5,
		SKILL_PARRY = 100,

		SKILL_MAGIC_OFFENSIVE = 5,
		SKILL_MAGIC_DEFENSIVE = 5,
		SKILL_MAGIC_SUPPORT = 5,

		SKILL_STEALTH = 5,
		SKILL_LOCKPICKING = 5,
		SKILL_THEFT = 5,

		SKILL_ALCHEMY = 5,
		SKILL_COOKING = 5,
		SKILL_ENCHANTING = 5
	)

#define ATTRIBUTE_STRENGTH "strength"
#define ATTRIBUTE_VITALITY "vitality"
#define ATTRIBUTE_FORTITUDE "fortitude"

#define ATTRIBUTE_INTELLIGENCE "intelligence"
#define ATTRIBUTE_RESOLVE "resolve"
#define ATTRIBUTE_WILLPOWER "willpower"

#define ATTRIBUTE_AGILITY "agility"
#define ATTRIBUTE_ENDURANCE "endurance"
#define ATTRIBUTE_LUCK "luck"
