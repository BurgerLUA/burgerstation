/job/medical
	name = "Medical Doctor"
	desc = "A doctor is someone who specializes in medicine and its various ways of treating people. They have bonuses in medical skills as well as attributes."

	passive_income = 0
	passive_income_bonus = 200

	active_income_multiplier_bonus = 1

	bonus_skills = list(
		SKILL_MELEE = 5,
		SKILL_PRECISION = 5,
		SKILL_SURVIVAL = 5,
		SKILL_MEDICINE = 5,
	)

	bonus_attributes = list(
		ATTRIBUTE_VITALITY = 5,
		ATTRIBUTE_INTELLIGENCE = 5,
		ATTRIBUTE_WISDOM = 5,
		ATTRIBUTE_DEXTERITY = 5,
	)

	ranks = list(
		"Medical Intern",
		"Medical Doctor",
		"Senior Medical Doctor",
		"Chief Medical Officer"
	)

	job_flags = FLAG_JOB_HEALING
