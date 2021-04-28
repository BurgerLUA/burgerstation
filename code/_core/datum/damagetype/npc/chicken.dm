/damagetype/npc/chicken
	name = "Chicken Peck"
	attack_verbs = list("pecks","claws","kicks")
	weapon_name = "beak"

	hit_effect = /obj/effect/temp/impact/combat/claw

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 15*0.1,
		PIERCE = 15*0.1
	)

	attack_damage_penetration = list(
		BLUNT = 10*0.25,
		PIERCE = 10*0.75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 15*0.6,
		ATTRIBUTE_DEXTERITY = 15*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(PIERCE,BLADE),
		ATTRIBUTE_DEXTERITY = list(PIERCE,BLADE)
	)

	attack_delay = 8*0.5
	attack_delay_max = 8