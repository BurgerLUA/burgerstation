/damagetype/ranged/magic/chaos
	attack_damage_base = list(
		DARK = 45*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_INTELLIGENCE = 45*0.25
	)

	attribute_damage = list(
		ATTRIBUTE_INTELLIGENCE = DARK
	)

	skill_stats = list(
		SKILL_MAGIC_OFFENSIVE = 45*0.25
	)

	skill_damage = list(
		SKILL_MAGIC_OFFENSIVE = DARK
	)

	bonus_experience_skill = list(
		SKILL_MAGIC_OFFENSIVE = 75 //75%
	)

/damagetype/ranged/magic/chaos/canine //Lazy way to stop the cursed canine from leveling magic stats, but still uses them for damage.
	name = "chaos ball"

	attribute_stats = list(
		ATTRIBUTE_DEXTERITY = 11.25
	)

	skill_stats = list(
		SKILL_RANGED = 11.25
	)
