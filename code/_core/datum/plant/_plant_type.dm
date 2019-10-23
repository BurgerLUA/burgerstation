/plant_type/
	name = "plant name"
	desc = "plant description"
	id = null
	var/icon_count = 1
	var/harvest_icon = 'icons/obj/items/consumable/food/plants.dmi'
	var/list/reagents = list()

/plant_type/nitrogen_flower
	name = "nitrogen flower"
	desc = "An extremely cold flower filled with liquid nitrogen."
	id = "nitrogen_flower"
	icon_count = 3
	reagents = list(
		nitrogen = 1,
	)


/plant_type/oxygen_fruit
	name = "oxygen fruit"
	desc = "An extremely cold watermelon-like plant filled with liquid oxygen."
	id = "oxygen_fruit"
	icon_count = 3
	reagents = list(
		oxygen = 1,
	)

/plant_type/wheat
	name = "wheat"
	desc = "The staple of everything."
	id = "wheat"
	icon_count = 5
	reagents = list(
		wheat_grain = 1,
	)

/plant_type/sugarcane
	name = "sugarcane chute"
	desc = "Some sort of health sugar? Who knows."
	id = "sugarcane"
	icon_count = 4
	reagents = list(
		sugarcane = 1,
	)

/plant_type/liberty_cap
	name = "liberty cap"
	desc = "A magic mushroom that makes you feel LIBERTY."
	id = "liberty_cap"
	icon_count = 1
	reagents = list(
		liberty_dust = 1,
	)

/plant_type/chanterelle
	name = "chanterelle mushroom"
	desc = "A safe, edible mushroom."
	id = "chanterelle"
	icon_count = 1
	reagents = list(
		chanterelle = 1,
	)

/plant_type/destroying_angel
	name = "destroying angel mushroom"
	desc = "An extremely poisonous white mushroom."
	id = "destroying_angel"
	icon_count = 1
	reagents = list(
		angel_toxin = 1,
	)

/plant_type/fly_amanita
	name = "fly amanita mushroom"
	desc = "A toxic and hallucinagetic mushroom."
	id = "fly_amanita"
	icon_count = 1
	reagents = list(
		fly_amanita_toxin = 1,
	)

/plant_type/glowshroom
	name = "glowshroom"
	desc = "A radioactive, glowing mushroom."
	id = "glowshroom"
	icon_count = 2
	reagents = list(
		radium = 1,
	)