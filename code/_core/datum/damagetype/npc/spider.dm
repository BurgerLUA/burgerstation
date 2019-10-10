/damagetype/npc/spider
	name = "Spider Damage"
	id = "spider"
	desc = "The bite of a spider"
	attack_verbs = list("bite","chomp","scratch")
	weapon_name = "fangs"


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_D,
		BIO = DAMAGE_C
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		PIERCE = BRUTE,
		BIO = TOX,
		FATIGUE = OXY
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = ARMOR_C,
		BIO = ARMOR_B
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C,
		ATTRIBUTE_DEXTERITY = CLASS_D,
		ATTRIBUTE_VITALITY = CLASS_D
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_VITALITY = BIO
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_D
	)

	skill_damage = list(
		SKILL_UNARMED = PIERCE
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = SKILL_D
	)