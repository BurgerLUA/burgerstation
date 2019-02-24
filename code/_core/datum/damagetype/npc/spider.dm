/damagetype/npc/spider
	name = "Spider Damage"
	id = "spider"
	desc = "The bite of a spider"
	attack_verbs = list("bite","chomp","scratch")
	weapon_name = "fangs"

	base_attack_damage = list(
		BRUTE = 1,
		BURN = 0,
		TOX = 1,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_D,
		ATTRIBUTE_AGILITY = CLASS_D,
		ATTRIBUTE_INTELLIGENCE = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = TOX
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	attack_delay = 5