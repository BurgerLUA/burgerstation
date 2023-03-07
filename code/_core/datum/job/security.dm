/job/security
	name = "Security Officer"
	desc = "A security enforcer is someone who protects NanoTrasen as well as its assets and its people. They have bonuses in offensive skills as well as bonuses in offenssive and defensive attributes."
	passive_income = 400
	passive_income_bonus = 100

	bonus_skills = list(
		//1 Major (15)
		SKILL_RANGED = 15,

		//2 Moderate (10)
		SKILL_PRECISION = 10,

		//3 Minor (5)
		SKILL_EVASION = 5,
		SKILL_ARMOR = 5
	)

	//50 total
	bonus_attributes = list(
		ATTRIBUTE_STRENGTH = 5,
		ATTRIBUTE_VITALITY = 5,
		ATTRIBUTE_FORTITUDE = 10,
		ATTRIBUTE_CONSTITUTION = 5,
		ATTRIBUTE_DEXTERITY = 10,
		ATTRIBUTE_RESILIENCE = 5,
		ATTRIBUTE_ENDURANCE = 5,
		ATTRIBUTE_AGILITY = 5
	)

	ranks = list(
		"Recruit",
		"Junior Officer",
		"Officer",
		"Senior Officer"
	)

	job_flags = FLAG_JOB_KILLING