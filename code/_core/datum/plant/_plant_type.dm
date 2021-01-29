/plant_type/
	var/name = "plant name"
	var/desc = "plant description"

	var/plant_icon = 'icons/obj/structure/botany.dmi'
	var/plant_icon_state = ""
	var/plant_icon_state_override //Set to something to override the grown icon state.
	var/plant_icon_count = 1

	var/seed_icon = 'icons/obj/item/seed.dmi'
	var/seed_icon_state = ""

	var/harvest_icon = 'icons/obj/item/consumable/food/plants.dmi'
	var/harvest_icon_state = ""

	var/typical_volume = 10

	var/list/reagents = list()

	var/list/allowed_turfs = list(
		/turf/simulated/floor/colored/dirt/soil
	)

	var/value = 100

	var/can_slice = FALSE

/plant_type/nitrogen_flower
	name = "nitrogen flower"
	desc = "An extremely cold flower filled with liquid nitrogen."
	plant_icon_state = "nitrogen"
	harvest_icon_state = "nitrogen_flower"
	seed_icon_state = "seed"

	plant_icon_count = 4
	reagents = list(
		/reagent/nitrogen = 1,
	)

	typical_volume = 10


/plant_type/oxygen_fruit
	name = "oxygen fruit"
	desc = "An extremely cold watermelon-like plant filled with liquid oxygen."
	plant_icon_state = "oxygen"
	harvest_icon_state = "oxygen_fruit"
	seed_icon_state = "seed"

	plant_icon_count = 4
	reagents = list(
		/reagent/oxygen = 1,
	)

	typical_volume = 15

/plant_type/wheat
	name = "wheat"
	desc = "The staple of everything."
	plant_icon_state = "wheat"
	harvest_icon_state = "wheat"
	seed_icon_state = "wheat"
	plant_icon_count = 6
	reagents = list(
		/reagent/nutrition/wheat_grain = 1,
	)

	typical_volume = 20


/plant_type/sugarcane
	name = "sugarcane chute"
	desc = "Some sort of health sugar? Who knows."
	plant_icon_state = "sugarcane"
	harvest_icon_state = "sugarcane"
	seed_icon_state = "sugarcane"
	plant_icon_count = 3
	reagents = list(
		/reagent/nutrition/sugar/cane = 1,
	)

	typical_volume = 10


/plant_type/liberty_cap
	name = "liberty cap"
	desc = "A magic mushroom that makes you feel LIBERTY."
	plant_icon_state = "liberty"
	harvest_icon_state = "liberty_cap"
	seed_icon_state = "liberty"
	plant_icon_count = 2
	reagents = list(
		/reagent/drug/liberty_dust = 1,
	)

	typical_volume = 10


/plant_type/chanterelle
	name = "chanterelle mushroom"
	desc = "A safe, edible mushroom."
	plant_icon_state = "chanter"
	harvest_icon_state = "chanterelle"
	seed_icon_state = "chanterelle"
	plant_icon_count = 2
	reagents = list(
		/reagent/nutrition/chanterelle = 1,
	)

	typical_volume = 15


/plant_type/destroying_angel
	name = "destroying angel mushroom"
	desc = "An extremely poisonous white mushroom."
	plant_icon_state = "destroying_angel"
	harvest_icon_state = "destroying_angel"
	seed_icon_state = "destroying_angel"
	plant_icon_count = 2
	reagents = list(
		/reagent/toxin/angel_toxin = 1,
	)

	typical_volume = 20


/plant_type/fly_amanita
	name = "fly amanita mushroom"
	desc = "A toxic and hallucinagetic mushroom."
	plant_icon_state = "amanita"
	harvest_icon_state = "fly_amanita"
	seed_icon_state = "fly_amanita"
	plant_icon_count = 2
	reagents = list(
		/reagent/toxin/fly_amanita_toxin = 0.25,
		/reagent/drug/space = 0.75
	)

	typical_volume = 10


/plant_type/glowshroom
	name = "glowshroom"
	desc = "A radioactive, glowing mushroom."
	plant_icon_state = "glowshroom"
	harvest_icon_state = "glowshroom"
	seed_icon_state = "glowshroom"
	plant_icon_count = 2
	reagents = list(
		/reagent/radioactive/radium = 1,
	)

	typical_volume = 10


/plant_type/tomato
	name = "tomato"
	desc = "A classic red tomato plant."
	plant_icon_state = "tomato"
	harvest_icon_state = "tomato"
	seed_icon_state = "tomato"
	plant_icon_count = 6
	reagents = list(
		/reagent/nutrition/tomato = 1,
	)

	typical_volume = 15

	can_slice = TRUE

/plant_type/lettuce
	name = "lettuce"
	desc = "A patch that grows lettuce."
	plant_icon_state = "lettuce"
	harvest_icon_state = "lettuce"
	seed_icon_state = "lettuce"
	plant_icon_count = 1
	reagents = list(
		/reagent/nutrition/lettuce = 1,
	)

	typical_volume = 30

	can_slice = TRUE

/plant_type/cabbage
	name = "cabbage"
	desc = "A patch that grows cabbage."
	plant_icon_state = "cabbage"
	harvest_icon_state = "cabbage"
	seed_icon_state = "cabbage"
	plant_icon_count = 1
	reagents = list(
		/reagent/nutrition/cabbage = 1,
	)

	typical_volume = 30

/plant_type/poppy
	name = "breadseed poppy"
	desc = "A flower that grows poppy."
	plant_icon_state = "poppy"
	harvest_icon_state = "poppy"
	seed_icon_state = "poppy"
	plant_icon_count = 3
	reagents = list(
		/reagent/nutrition/flower_petal = 0.75,
		/reagent/nutrition/poppy_seed/raw = 0.25
	)

	typical_volume = 10