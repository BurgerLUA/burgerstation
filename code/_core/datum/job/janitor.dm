/job/janitor
	name = "Janitor"
	desc = "Job Description."

	passive_income = 0
	passive_income_bonus = 200 //Per rank

	bonus_skills = list(
		SKILL_MELEE = 5,
		SKILL_RANGED = 5,
		SKILL_SURVIVAL = 5,
		SKILL_EVASION = 5,
	)

	bonus_attributes = list(
		ATTRIBUTE_STRENGTH = 5,
		ATTRIBUTE_CONSTITUTION = 5,
		ATTRIBUTE_RESILIENCE = 5,
		ATTRIBUTE_AGILITY = 5
	)

	ranks = list(
		"Intern Custodian",
		"Custodian",
		"Senior Custodian",
		"Chief Custodian"
	)

	job_flags = FLAG_JOB_CLEANING