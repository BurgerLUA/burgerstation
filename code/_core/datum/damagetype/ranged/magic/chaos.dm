/damagetype/ranged/magic/chaos
	attack_damage_base = list(
		DARK = 20
	)

	attribute_stats = list(
		ATTRIBUTE_VITALITY = 20
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = DARK
	)

	skill_stats = list(
		SKILL_PRAYER = 20
	)

	skill_damage = list(
		SKILL_PRAYER = DARK
	)

/damagetype/ranged/magic/chaos/canine //Lazy way to stop the cursed canine from leveling magic stats, but still uses them for damage.

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 11.25
	)

	skill_stats = list(
		SKILL_RANGED = 11.25
	)
