/material/
	var/name = "material"
	var/desc = "Pun."
	var/desc_extended = "Information about this material."

	var/color = "#FFFFFF"

	var/icon_state_sheet = "sheet"
	var/icon_state_rod = "rod"
	var/icon_state_ingot = "ingot"
	var/icon_state_ore = "ore"
	var/icon_state_ore_deposit

	var/weight_per_unit = 0.1
	var/value_per_unit = 1

	var/list/armor = list( //This is used for constructables, like turfs or machines.
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		ION = 0,
		PAIN = 0,
		SANITY = 0
	)



/material/grass/
	name = "grass"
	color = COLOR_GREEN

	value_per_unit = 2

	armor = list(
		BLADE = -50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = -25,
		ARCANE = INFINITY,
		HEAT = -100,
		COLD = 50,
		BOMB = -500,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/dirt/
	name = "dirt"
	color = COLOR_BROWN

	value_per_unit = 1

	armor = list(
		BLADE = 50,
		BLUNT = -25,
		PIERCE = 50,
		LASER = 25,
		ARCANE = INFINITY,
		HEAT = 75,
		COLD = 75,
		BOMB = -500,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)


/material/rock/
	name = "rock"
	color = COLOR_ROCK

	value_per_unit = 2

	armor = list(
		BLADE = 25,
		BLUNT = -25,
		PIERCE = -25,
		LASER = -50, //Lasers chip away at rocks pretty easy.
		ARCANE = INFINITY,
		HEAT = -25,
		COLD = 25,
		BOMB = -500, //Explosions clear rocks pretty easy.
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)


/material/glass/
	name = "glass"
	color = COLOR_GLASS

	icon_state_sheet = "glass"

	icon_state_ore = "ore_sand"

	value_per_unit = 4

	armor = list(
		BLADE = 25,
		BLUNT = 0,
		PIERCE = 25,
		LASER = INFINITY,
		ARCANE = INFINITY,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/steel
	name = "steel"
	color = COLOR_STEEL

	value_per_unit = 6

	armor = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 50,
		LASER = 25,
		ARCANE = 0,
		HEAT = 75,
		COLD = 75,
		BOMB = 50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/aluminum
	name = "aluminum"
	color = COLOR_ALUMINUM
	value_per_unit = 5

	armor = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 50,
		ARCANE = 25,
		HEAT = 75,
		COLD = 75,
		BOMB = 50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/iron
	name = "iron"
	color = COLOR_IRON
	icon_state_ore = "ore_iron"
	icon_state_ore_deposit = "deposit_iron"

	value_per_unit = 4

	armor = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 25,
		LASER = 0,
		ARCANE = 0,
		HEAT = 50,
		COLD = 50,
		BOMB = 75,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)


/material/phoron
	name = "phoron"
	color = COLOR_PHORON
	icon_state_ore = "ore_phoron"
	icon_state_ore_deposit = "deposit_phoron"

	value_per_unit = 20

	armor = list(
		BLADE = 100,
		BLUNT = 0,
		PIERCE = 75,
		LASER = -50,
		ARCANE = INFINITY,
		HEAT = -100,
		COLD = INFINITY,
		BOMB = -100,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/carbon
	name = "carbon"
	color = COLOR_CARBON
	icon_state_ore = "ore_coal"
	icon_state_ore_deposit = "deposit_coal"

	value_per_unit = 5

	armor = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = -50,
		ARCANE = 75,
		HEAT = -100,
		COLD = 50,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/gold
	name = "gold"
	color = COLOR_GOLD
	icon_state_ore = "ore_gold"
	icon_state_ore_deposit = "deposit_gold"

	value_per_unit = 40

	armor = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 75,
		ARCANE = INFINITY,
		HEAT = 25,
		COLD = 25,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/diamond
	name = "diamond"
	color = COLOR_DIAMOND
	icon_state_ore = "ore_diamond"
	icon_state_ore_deposit = "deposit_diamond"

	value_per_unit = 100

	armor = list(
		BLADE = 200,
		BLUNT = 200,
		PIERCE = 200,
		LASER = 50,
		ARCANE = 200,
		HEAT = 200,
		COLD = 200,
		BOMB = 200,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/silver
	name = "silver"
	color = COLOR_SILVER
	icon_state_ore = "ore_silver"
	icon_state_ore_deposit = "deposit_silver"

	value_per_unit = 30

	armor = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 75,
		ARCANE = 50,
		HEAT = 25,
		COLD = 25,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/uranium
	name = "uranium"
	color = COLOR_URANIUM
	icon_state_ore = "ore_uranium"
	icon_state_ore_deposit = "deposit_uranium"

	value_per_unit = 35

	armor = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 50,
		LASER = 25,
		ARCANE = 25,
		HEAT = 100,
		COLD = 100,
		BOMB = 100,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/titanium
	name = "titanium"
	color = COLOR_TITANIUM
	icon_state_ore = "ore_titanium"

	value_per_unit = 25

	armor = list(
		BLADE = 100,
		BLUNT = 75,
		PIERCE = 100,
		LASER = 100,
		ARCANE = -25,
		HEAT = 100,
		COLD = 100,
		BOMB = 75,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/plasteel
	name = "plasteel"
	color = COLOR_PLASTEEL

	value_per_unit = 25

	armor = list(
		BLADE = 75,
		BLUNT = 100,
		PIERCE = 100,
		LASER = 50,
		ARCANE = 0,
		HEAT = 75,
		COLD = 75,
		BOMB = 100,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)


/material/wood
	name = "wood"
	color = COLOR_WOOD
	value_per_unit = 5

	armor = list(
		BLADE = 0,
		BLUNT = 50,
		PIERCE = 25,
		LASER = -25,
		ARCANE = 100,
		HEAT = -75,
		COLD = 25,
		BOMB = 25,
		BIO = 0,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = 0,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/material/adamantium_carbon
	name = "adamantium-carbon"
	color = COLOR_ADAMANITUM_CARBON
	value_per_unit = 2000

	armor = list(
		BLADE = INFINITY,
		BLUNT = INFINITY,
		PIERCE = INFINITY,
		LASER = INFINITY,
		ARCANE = INFINITY,
		HEAT = INFINITY,
		COLD = INFINITY,
		BOMB = INFINITY,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)