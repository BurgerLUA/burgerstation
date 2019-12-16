/damagetype/npc/bull
	name = "Bull Gore"
	id = "bull_gore"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_D,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_C,
	)


	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_C
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE
	)

	skill_stats = list()

	skill_damage = list()

	skill_xp_per_damage = list()