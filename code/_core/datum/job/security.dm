/job/security
	name = "Security Officer"
	desc = "A security enforcer is someone who protects NanoTrasen as well as its assets and its people. They have bonuses in offensive skills as well as bonuses in offensive and defensive attributes."
	passive_income = 400
	passive_income_bonus = 100

	bonus_skills = list(
		SKILL_MELEE = 5,
		SKILL_ARMOR = 5,
		SKILL_RANGED = 5,
		SKILL_SURVIVAL = 5,
	)

	bonus_attributes = list(
		ATTRIBUTE_STRENGTH = 5,
		ATTRIBUTE_FORTITUDE = 5,
		ATTRIBUTE_CONSTITUTION = 5,
		ATTRIBUTE_ENDURANCE = 5,
	)

	ranks = list(
		"Recruit",
		"Junior Officer",
		"Officer",
		"Senior Officer"
	)

	job_flags = FLAG_JOB_KILLING
