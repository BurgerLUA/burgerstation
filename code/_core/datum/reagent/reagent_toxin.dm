/reagent/toxin/
	name = "toxin"
	id = "toxin"
	desc = "A common toxin found nearly everywhere."
	color = "#FF8411"

	var/damage_per_unit = 1

	lethal = TRUE

	liquid = 0.5

/reagent/toxin/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_tox_loss(.*damage_per_unit*0.75)

	return .

/reagent/toxin/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_tox_loss(.*damage_per_unit)

	return .



/reagent/toxin/angel_toxin
	name = "angel toxin"
	id = "angel_toxin"
	desc = "An incredibly lethal toxin. Injecting this will make you see angels."

	damage_per_unit = 15

	flavor = "mushroom"


/reagent/toxin/fly_amanita_toxin
	name = "fly amanita toxin"
	id = "fly_amanita_toxin"
	desc = "An moderately lethal toxin."

	damage_per_unit = 4

	flavor = "mushroom"