/reagent/core/carbon //Found while mining carbon ore deposits
	name = "Carbon"
	id = "carbon"
	desc = "What most lifeforms are made out of."
	color = "#000000"

	flavor = "coal"

	liquid = -0.75

/reagent/core/iron //Found while mining iron ore deposits
	name = "Iron"
	id = "iron"
	desc = "What most lifeforms build weapons out of."
	color = COLOR_IRON

	flavor = "iron"

	liquid = -0.25

/reagent/core/iron/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		if(L.spawn_blood && L.reagents && L.spawn_blood == "blood")
			L.reagents.add_reagent("blood",.*2)

	return .

/reagent/core/oxygen //Found in the snow biome as a magic plant
	name = "Liquid Oxygen"
	id = "oxygen"
	desc = "What most lifeforms breathe in.."
	color = "#E6F2F2"

	flavor = "oxygen"

	liquid = 0.25

/reagent/core/nitrogen //Found in the snow biome as a magic plant
	name = "Liquid Nitrogen"
	id = "nitrogen"
	desc = "What most lifeforms also breathe in but don't really use."
	color = "#D9E2E2"

	flavor = "cold"

	liquid = 0.25

/reagent/core/silicon //Found while mining silicon ore deposits
	name = "Silicon"
	id = "silicon"
	desc = "What most lifeforms do things with."
	color = COLOR_BLACK

	flavor = "dildos"

	liquid = -0.25

/reagent/core/potassium //Found through potash
	name = "Potassium"
	id = "potassium"
	desc = "What most lifeforms do things with."
	color = "#ADADAD"

	flavor = "bananas"

	flavor_strength = 2

	liquid = -0.25

/reagent/core/blood //Found through organic things
	name = "Blood"
	id = "blood"
	desc = "What most lifeforms do things with."
	color = "#880000"

	flavor = "blood"

	metabolism_blood = 0

	liquid = 0.4

/reagent/core/water //Found through organic things
	name = "Water"
	id = "water"
	desc = "What most lifeforms drink."
	color = "#99D5FF"

	flavor = "water"
	flavor_strength = 0.1

	liquid = 0.5

/reagent/core/salt
	name = "salt"
	id = "salt"
	desc = "Down here, everything is salt."
	color = "#FFFFFF"

	flavor = "salt"
	flavor_strength = 4

	liquid = -1