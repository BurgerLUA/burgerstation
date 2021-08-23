/job/
	var/name = "Job Name."
	var/desc = "Job Description."

	var/passive_income = 0
	var/passive_income_bonus = 0 //Per rank

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
		SKILL_PARRY = 0,
		SKILL_MAGIC_DEFENSIVE = 0,
		SKILL_MAGIC_OFFENSIVE = 0,
		SKILL_MAGIC_SUMMONING = 0,
		SKILL_MAGIC_ENCHANTING = 0,
		SKILL_MEDICINE = 0,
		SKILL_BOTANY = 0
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

/job/proc/get_rank_title(var/rank_level=1)
	var/rank_length = length(ranks)
	if(!rank_length)
		return name
	return ranks[max(rank_level,rank_length)]

/job/assistant
	name = "Assistant"
	desc = "An assistant is someone who assistants the other jobs. They have bonuses in all skill fields as well as increased luck."
	passive_income = 200

	bonus_skills = list(
		SKILL_UNARMED = 10,
		SKILL_MELEE = 10,
		SKILL_PRAYER = 10,
		SKILL_BLOCK = 10,
		SKILL_ARMOR = 10,
		SKILL_RANGED = 10,
		SKILL_PRECISION = 10,
		SKILL_SURVIVAL = 10,
		SKILL_EVASION = 10,
		SKILL_PARRY = 10,
		SKILL_MAGIC_DEFENSIVE = 10,
		SKILL_MAGIC_OFFENSIVE = 10,
		SKILL_MAGIC_SUMMONING = 10,
		SKILL_MAGIC_ENCHANTING = 10,
		SKILL_MEDICINE = 10,
		SKILL_BOTANY = 10
	)

	bonus_attributes = list(
		ATTRIBUTE_LUCK = 10
	)

/job/assistant/security
	name = "Security Enforcer"
	desc = "A security enforcer is someone who protects NanoTrasen as well as its assets and its people. They have bonuses in offensive skills as well as bonuses in offenssive and defensive attributes."
	passive_income = 400
	passive_income_bonus = 100

	bonus_skills = list(
		SKILL_UNARMED = 5,
		SKILL_MELEE = 5,
		SKILL_BLOCK = 5,
		SKILL_ARMOR = 5,
		SKILL_RANGED = 5,
		SKILL_PRECISION = 5,
		SKILL_SURVIVAL = 5,
		SKILL_EVASION = 5,
		SKILL_PARRY = 5,
	)

	bonus_attributes = list(
		ATTRIBUTE_STRENGTH = 5,
		ATTRIBUTE_VITALITY = 5,
		ATTRIBUTE_FORTITUDE = 5,
		ATTRIBUTE_CONSTITUTION = 5,
		ATTRIBUTE_DEXTERITY = 5,
		ATTRIBUTE_RESILIENCE = 5,
		ATTRIBUTE_ENDURANCE = 5,
		ATTRIBUTE_AGILITY = 5
	)

	ranks = list(
		"Recruit",
		"Private",
		"Corporal",
		"Sergeant",
		"Sergeant Major",
		"2nd Lieutenant",
		"1st Lieutenant"
	)

/job/assistant/medical
	name = "Medical"
	desc = "A doctor is someone who specializes in medicine and its various ways of treating people. They have bonuses in medical skills as well as attributes."

	passive_income = 600
	passive_income_bonus = 200

	bonus_skills = list(
		SKILL_PRECISION = 5,
		SKILL_SURVIVAL = 5,
		SKILL_MEDICINE = 10,
		SKILL_BOTANY = 5
	)

	bonus_attributes = list(
		ATTRIBUTE_INTELLIGENCE = 10,
		ATTRIBUTE_WISDOM = 10,
		ATTRIBUTE_WILLPOWER = 10,
		ATTRIBUTE_DEXTERITY = 10,
	)


	ranks = list(
		"Student",
		"Intern",
		"Resident",
		"Doctor",
		"Senior Doctor"
	)