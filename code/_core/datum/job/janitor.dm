/job/janitor
	name = "Janitor"
	desc = "Job Description."

	passive_income = 0
	passive_income_bonus = 0 //Per rank

	//50 total
	bonus_skills = list(
		SKILL_UNARMED = 10,
		SKILL_MELEE = 10,
		SKILL_BLOCK = 10,
		SKILL_SURVIVAL = 20
	)

	//50 total
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
		"Cleaner",
		"Custodian",
		"Janitor",
		"Superintendent"
	)

	job_flags = FLAG_JOB_CLEANING