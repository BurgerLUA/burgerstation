/reagent/carbon //Found while mining carbon ore deposits. Or burning food.
	name = "Carbon"
	desc = "What most lifeforms are made out of."
	color = "#000000"

	flavor = "burnt food"

	liquid = -0.75

/reagent/iron //Found while mining iron ore deposits
	name = "Iron"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_IRON

	flavor = "iron"

	liquid = -0.25

/reagent/iron/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	/*
	if(is_living(owner))
		var/mob/living/L = owner
		if(L.spawn_blood && L.reagents && L.spawn_blood == /reagent/blood)
			L.reagents.add_reagent(/reagent/blood,.*2)
	*/

	return .

/reagent/steel
	name = "Steel"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_STEEL

	flavor = "steel"

	liquid = -0.25

/reagent/oxygen //Found in the snow biome as a magic plant
	name = "Liquid Oxygen"
	desc = "What most lifeforms breathe in.."
	color = "#E6F2F2"

	flavor = "oxygen"

	liquid = 0.25

/reagent/nitrogen //Found in the snow biome as a magic plant
	name = "Liquid Nitrogen"
	desc = "What most lifeforms also breathe in but don't really use."
	color = "#D9E2E2"

	flavor = "cold"

	liquid = 0.25

/reagent/silicon //Found while mining silicon ore deposits
	name = "Silicon"
	desc = "What most lifeforms do things with."
	color = COLOR_BLACK

	flavor = "dildos"

	liquid = -0.25

/reagent/potassium //Found through potash
	name = "Potassium"
	desc = "What most lifeforms do things with."
	color = "#ADADAD"

	flavor = "bananas"

	flavor_strength = 2

	liquid = -0.25

/reagent/blood //Found through organic things
	name = "Blood"
	desc = "What most lifeforms do things with."
	color = "#880000"

	flavor = "blood"

	metabolism_blood = 0

	liquid = 0.4

/reagent/salt
	name = "salt"
	desc = "Down here, everything is salt."
	color = "#FFFFFF"

	flavor = "salt"
	flavor_strength = 4

	liquid = -1