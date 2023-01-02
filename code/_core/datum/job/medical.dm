/job/medical
	name = "Medical Doctor"
	desc = "A doctor is someone who specializes in medicine and its various ways of treating people. They have bonuses in medical skills as well as attributes."

	passive_income = 600
	passive_income_bonus = 200

	//50 total
	bonus_skills = list(
		SKILL_PRECISION = 10,
		SKILL_SURVIVAL = 10,
		SKILL_MEDICINE = 20,
		SKILL_BOTANY = 10
	)

	//50 total
	bonus_attributes = list(
		ATTRIBUTE_INTELLIGENCE = 20,
		ATTRIBUTE_WISDOM = 20,
		ATTRIBUTE_WILLPOWER = 5,
		ATTRIBUTE_DEXTERITY = 5,
	)

	ranks = list(
		"Medical Intern",
		"Medical Resident",
		"Medical Doctor",
		"Senior Medical Doctor"
	)