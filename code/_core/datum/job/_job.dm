/job/
	var/name = "Job Name."
	var/desc = "Job Description."

	var/passive_income = 0
	var/passive_income_bonus = 0 //Per rank after 1

	var/active_income_multiplier = 1
	var/active_income_multiplier_bonus = 0 //Per rank after 1.

	var/list/bonus_skills = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_PRAYER = 0,
		SKILL_BLOCK = 0,
		SKILL_ARMOR = 0,
		SKILL_RANGED = 0,
		SKILL_PRECISION = 0,
		SKILL_SURVIVAL = 0,
		SKILL_EVASION = 0,
		SKILL_MAGIC = 0,
		SKILL_SUMMONING = 0,
		SKILL_MEDICINE = 0,
	)

	var/list/bonus_attributes = list(
		ATTRIBUTE_STRENGTH = 0,
		ATTRIBUTE_VITALITY = 0,
		ATTRIBUTE_FORTITUDE = 0,
		ATTRIBUTE_CONSTITUTION = 0,
		ATTRIBUTE_INTELLIGENCE = 0,
		ATTRIBUTE_WISDOM = 0,
		ATTRIBUTE_WILLPOWER = 0,
		ATTRIBUTE_SOUL = 0,
		ATTRIBUTE_DEXTERITY = 0,
		ATTRIBUTE_RESILIENCE = 0,
		ATTRIBUTE_ENDURANCE = 0,
		ATTRIBUTE_AGILITY = 0,
		ATTRIBUTE_LUCK = 0
	)

	var/list/ranks

	var/job_flags = 0x0

/job/proc/get_rank_title(var/rank_level=1)
	var/rank_length = length(ranks)
	if(!rank_length)
		return name
	return ranks[min(rank_level,rank_length)]