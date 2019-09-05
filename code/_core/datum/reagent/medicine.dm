/reagent/medicine/bicaridine
	name = "Bicaridine"
	id = "bicaridine"
	desc = "Red for brute."
	color = "#FF0000"

/reagent/medicine/bicaridine/on_metabolize_blood(var/atom/owner)
	. = ..()
	owner.adjust_brute_loss(-.)
	return .

/reagent/medicine/bicaridine/on_metabolize_stomach(var/atom/owner)
	. = ..()
	owner.adjust_brute_loss(-.*0.5)
	return

/reagent/medicine/kelotane
	name = "Kelotane"
	id = "kelotane"
	desc = "Yellow for burn."
	color = "#FFFF00"

/reagent/medicine/kelotane/on_metabolize_blood(var/atom/owner)
	. = ..()
	owner.adjust_burn_loss(-.)
	return .

/reagent/medicine/kelotane/on_metabolize_stomach(var/atom/owner)
	. = ..()
	owner.adjust_burn_loss(-.*0.5)
	return .

/reagent/medicine/dylovene
	name = "Dylovene"
	id = "dylovene"
	desc = "Green for toxin."
	color = "#00FF00"

/reagent/medicine/dylovene/on_metabolize_blood(var/atom/owner)
	. = ..()
	owner.adjust_tox_loss(-.)
	return .

/reagent/medicine/dylovene/on_metabolize_stomach(var/atom/owner)
	. = ..()
	owner.adjust_tox_loss(-.*0.5)
	return .

/reagent/medicine/dexalin
	name = "Dexalin"
	id = "dexalin"
	desc = "Blue for oxy."
	color = "#0000FF"

/reagent/medicine/dexalin/on_metabolize_blood(var/atom/owner)
	. = ..()
	owner.adjust_oxy_loss(-.)
	return .

/reagent/medicine/dexalin/on_metabolize_stomach(var/atom/owner)
	. = ..()
	owner.adjust_oxy_loss(-.*0.5)
	return .