/plant_type/
	var/name = "plant name"
	var/desc = "plant description"
	var/icon_state = null
	var/icon_count = 1
	var/harvest_icon = 'icons/obj/item/consumable/food/plants.dmi'
	var/list/reagents = list()


/plant_type/nitrogen_flower
	name = "nitrogen flower"
	desc = "An extremely cold flower filled with liquid nitrogen."
	icon_state = "nitrogen_flower"
	icon_count = 3
	reagents = list(
		/reagent/nitrogen = 1,
	)


/plant_type/oxygen_fruit
	name = "oxygen fruit"
	desc = "An extremely cold watermelon-like plant filled with liquid oxygen."
	icon_state = "oxygen_fruit"
	icon_count = 3
	reagents = list(
		/reagent/oxygen = 1,
	)

/plant_type/wheat
	name = "wheat"
	desc = "The staple of everything."
	icon_state = "wheat"
	icon_count = 5
	reagents = list(
		/reagent/nutrition/wheat_grain = 1,
	)

/plant_type/sugarcane
	name = "sugarcane chute"
	desc = "Some sort of health sugar? Who knows."
	icon_state = "sugarcane"
	icon_count = 4
	reagents = list(
		/reagent/nutrition/sugar/cane = 1,
	)

/plant_type/liberty_cap
	name = "liberty cap"
	desc = "A magic mushroom that makes you feel LIBERTY."
	icon_state = "liberty_cap"
	icon_count = 1
	reagents = list(
		/reagent/drug/liberty_dust = 1,
	)

/plant_type/chanterelle
	name = "chanterelle mushroom"
	desc = "A safe, edible mushroom."
	icon_state = "chanterelle"
	icon_count = 1
	reagents = list(
		/reagent/nutrition/chanterelle = 1,
	)

/plant_type/destroying_angel
	name = "destroying angel mushroom"
	desc = "An extremely poisonous white mushroom."
	icon_state = "destroying_angel"
	icon_count = 1
	reagents = list(
		/reagent/toxin/angel_toxin = 1,
	)

/plant_type/fly_amanita
	name = "fly amanita mushroom"
	desc = "A toxic and hallucinagetic mushroom."
	icon_state = "fly_amanita"
	icon_count = 1
	reagents = list(
		/reagent/toxin/fly_amanita_toxin = 1,
		/reagent/drug/space = 1
	)

/plant_type/glowshroom
	name = "glowshroom"
	desc = "A radioactive, glowing mushroom."
	icon_state = "glowshroom"
	icon_count = 2
	reagents = list(
		/reagent/radioactive/radium = 1,
	)

/plant_type/tomato
	name = "tomato plant"
	desc = "A classic red tomato plant."
	icon_state = "tomato"
	icon_count = 5
	reagents = list(
		/reagent/nutrition/tomato = 1,
	)

/plant_type/cabbage
	name = "cabbage patch"
	desc = "A patch that grows cabbage"
	icon_state = "cabbage"
	icon_count = 0
	reagents = list(
		/reagent/nutrition/cabbage = 1,
	)