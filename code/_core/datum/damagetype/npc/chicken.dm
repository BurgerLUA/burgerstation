/damagetype/npc/chicken
	name = "Chicken Peck"
	attack_verbs = list("pecks","claws","kicks")
	weapon_name = "beak"

	hit_effect = /obj/effect/temp/impact/combat/claw

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_DAGGER*0.1,
		PIERCE = DAMAGE_DAGGER*0.1
	)

	attack_damage_penetration = list(
		BLUNT = AP_DAGGER*0.25,
		PIERCE = AP_DAGGER*0.75,
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_DAGGER*0.6,
		ATTRIBUTE_DEXTERITY = DAMAGE_DAGGER*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(PIERCE,BLADE),
		ATTRIBUTE_DEXTERITY = list(PIERCE,BLADE)
	)

	attack_delay = SPEED_DAGGER*0.5
	attack_delay_max = SPEED_DAGGER