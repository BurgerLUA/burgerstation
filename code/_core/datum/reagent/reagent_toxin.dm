/reagent/toxin/
	name = "toxin"
	desc = "A common toxin found nearly everywhere."
	color = "#FF8411"

	var/damage_per_unit = 1

	lethal = TRUE

	liquid = 0.5

/reagent/toxin/New(var/desired_loc)

	value *= 1+(damage_per_unit*2)

	return ..()

/reagent/toxin/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(tox=.*damage_per_unit*0.75)

	return .

/reagent/toxin/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(tox=.*damage_per_unit)

	return .



/reagent/toxin/angel_toxin
	name = "angel toxin"
	desc = "An incredibly lethal toxin. Injecting this will make you see angels."

	damage_per_unit = 15

	flavor = "mushroom"


/reagent/toxin/fly_amanita_toxin
	name = "fly amanita toxin"
	desc = "An moderately lethal toxin."

	damage_per_unit = 4

	flavor = "mushroom"

/reagent/toxin/xeno_acid
	name = "xeno acid"
	desc = "Literal fucking acid."

	damage_per_unit = 2

	flavor = "pain"

/reagent/toxin/spider_toxin
	name = "spider toxin"
	desc = "Toxins bad."

	damage_per_unit = 3

	flavor = "arachnophobia"