/damagetype/npc/bubblegum //When bubblegum runs into someone.
	name = "bubblegum smash"
	attack_verbs = list("hit","smack")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_GREATCLUB
	)

	attack_damage_penetration = list(
		BLUNT = AP_GREATCLUB
	)

	attack_delay = SPEED_GREATCLUB*0.5
	attack_delay_max = SPEED_GREATCLUB