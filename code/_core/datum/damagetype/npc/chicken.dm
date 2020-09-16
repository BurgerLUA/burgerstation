/damagetype/npc/chicken
	name = "Chicken Peck"
	attack_verbs = list("pecks","claws","kicks")
	weapon_name = "beak"

	hit_effect = /obj/effect/temp/impact/combat/claw

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 1,
		PIERCE = 1
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 20,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = PIERCE,
		ATTRIBUTE_DEXTERITY = BLADE
	)

	skill_stats = list(
		SKILL_UNARMED = 30
	)

	skill_damage = list(
		SKILL_UNARMED = PIERCE
	)