// Overall level formula: https://www.desmos.com/calculator/cka4qx8qr0

/class/

	//By default, all weights are 0.

	//12 + 1 attributes
	var/list/weights_attribute = list(
		ATTRIBUTE_STRENGTH = 1,
		ATTRIBUTE_FORTITUDE = 1,
		ATTRIBUTE_CONSTITUTION = 1,
		ATTRIBUTE_VITALITY = 1,

		ATTRIBUTE_INTELLIGENCE = 1,
		ATTRIBUTE_WILLPOWER = 1,
		ATTRIBUTE_SOUL = 1,
		ATTRIBUTE_WISDOM = 1,

		ATTRIBUTE_DEXTERITY = 1,
		ATTRIBUTE_RESILIENCE = 1,
		ATTRIBUTE_ENDURANCE = 1,
		ATTRIBUTE_AGILITY = 1,

		ATTRIBUTE_LUCK = 1
	)

	//15 combat skills, 1 crafting skill.
	var/list/weights_skill = list(
		SKILL_MELEE = 1,
		SKILL_UNARMED = 1,
		SKILL_PRAYER = 1,
		SKILL_BLOCK = 1,
		SKILL_ARMOR = 1,

		SKILL_RANGED = 1,
		SKILL_PRECISION = 1,
		SKILL_SURVIVAL = 1,
		SKILL_EVASION = 1,
		SKILL_PARRY = 1,

		SKILL_MAGIC_OFFENSIVE = 1,
		SKILL_MAGIC_DEFENSIVE = 1,
		SKILL_MAGIC_SUMMONING = 1,
		SKILL_MAGIC_ENCHANTING = 1,
		SKILL_MEDICINE = 1,

		SKILL_BOTANY = 1

	)

	var/total_skill_weight = 0
	var/total_attribute_weight = 0

/class/New(var/desired_loc)
	. = ..()
	total_skill_weight = 0
	total_attribute_weight = 0

	for(var/k in weights_attribute)
		var/v = weights_attribute[k]
		total_attribute_weight += v

	for(var/k in weights_skill)
		var/v = weights_skill[k]
		total_skill_weight += v
