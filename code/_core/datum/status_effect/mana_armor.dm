/status_effect/mana_armor
	name = "Mana Armor"
	desc = "Your mana protects your health, as long as you have more than half your maximum mana. Protection granted is based on arcane armor."
	id = MANA_ARMOR
	maximum = SECONDS_TO_DECISECONDS(300)
	minimum = SECONDS_TO_DECISECONDS(1)

	default_duration = SECONDS_TO_DECISECONDS(30)
	default_magnitude = 10 //Percent of mana taken before health

	affects_dead = FALSE
