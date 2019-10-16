/reagent/medicine/bicaridine
	name = "Bicaridine"
	id = "bicaridine"
	desc = "Red for brute."
	color = "#FF0000"

/reagent/medicine/bicaridine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_brute_loss(-.*HEALING_C)
	return .

/reagent/medicine/bicaridine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_brute_loss(-.*HEALING_C*0.5)
	return .

/reagent/medicine/kelotane
	name = "Kelotane"
	id = "kelotane"
	desc = "Yellow for burn."
	color = "#FFFF00"

/reagent/medicine/kelotane/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_burn_loss(-.*HEALING_C)
	return .

/reagent/medicine/kelotane/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_burn_loss(-.*HEALING_C*0.5)
	return .

/reagent/medicine/dylovene
	name = "Dylovene"
	id = "dylovene"
	desc = "Green for toxin."
	color = "#00FF00"

/reagent/medicine/dylovene/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_tox_loss(-.*HEALING_C)
	return .

/reagent/medicine/dylovene/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_tox_loss(-.*HEALING_C*0.5)
	return .

/reagent/medicine/dexalin
	name = "Dexalin"
	id = "dexalin"
	desc = "Blue for oxy."
	color = "#0000FF"

/reagent/medicine/dexalin/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_oxy_loss(-.*HEALING_C)
	return .

/reagent/medicine/dexalin/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_oxy_loss(-.*HEALING_C*0.5)
	return .

/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	id = "tricordrazine"
	desc = "Heals everything except for oxygen loss."
	color = "#B21FFF"

/reagent/medicine/tricordrazine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_brute_loss(-.*HEALING_D*0.33)
		owner.health.adjust_burn_loss(-.*HEALING_D*0.33)
		owner.health.adjust_tox_loss(-.*HEALING_D*0.33)
	return .

/reagent/medicine/tricordrazine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_brute_loss(-.*HEALING_D*0.33*0.5)
		owner.health.adjust_burn_loss(-.*HEALING_D*0.33*0.5)
		owner.health.adjust_tox_loss(-.*HEALING_D*0.33*0.5)
	return .

/reagent/medicine/omnizine
	name = "Omnizine"
	id = "omnizine"
	desc = "Heals everything."
	desc_extended = "Works just as good when consumed."
	color = "#F7F7F7"

/reagent/medicine/omnizine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_brute_loss(-.*HEALING_D*0.25)
		owner.health.adjust_burn_loss(-.*HEALING_D*0.25)
		owner.health.adjust_tox_loss(-.*HEALING_D*0.25)
		owner.health.adjust_oxy_loss(-.*HEALING_D*0.25)
	return .

/reagent/medicine/omnizine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()
	if(owner && owner.health)
		owner.health.adjust_brute_loss(-.*HEALING_D*0.25)
		owner.health.adjust_burn_loss(-.*HEALING_D*0.25)
		owner.health.adjust_tox_loss(-.*HEALING_D*0.25)
		owner.health.adjust_oxy_loss(-.*HEALING_D*0.25)
	return .