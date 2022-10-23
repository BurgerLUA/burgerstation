/reagent_recipe/medicine/
	category = "Chemistry"
	results = list()


//Start of approved recipes.


/reagent_recipe/medicine/inaprovaline

	name = "Inaprovaline"
	desc = "a common stabilizer synthesised from basic elements and compounds. Only works when injected. Has a high overdose threshold. Provides the UNDYING effect."

	required_reagents = list(
		/reagent/carbon = 1,
		/reagent/fuel/oxygen = 1,
		/reagent/nutrition/sugar/glucose = 1
	)

	results = list(
		/reagent/medicine/inaprovaline = 3
	)

/reagent_recipe/medicine/bicaridine

	name = "Bicaridine"
	desc = "Red for brute."

	required_reagents = list(
		/reagent/carbon = 1,
		/reagent/medicine/inaprovaline = 1
	)

	results = list(
		/reagent/medicine/bicaridine = 2
	)

/reagent_recipe/medicine/dylovene

	name = "Dylovene"
	desc = "Green for toxin."

	required_reagents = list(
		/reagent/nitrogen = 1,
		/reagent/potassium = 1,
		/reagent/silicon = 1
	)

	results = list(
		/reagent/medicine/dylovene = 3
	)

/reagent_recipe/medicine/tricordrazine

	name = "Tricordrazine"
	desc = "Heals everything except for oxygen loss."

	required_reagents = list(
		/reagent/medicine/inaprovaline = 1,
		/reagent/medicine/dylovene = 1
	)

	results = list(
		/reagent/medicine/tricordrazine = 2
	)


/reagent_recipe/medicine/synthflesh

	name = "Synthflesh"
	desc = "Experimental synthetic flesh. Significantly heals brute and burn damage of the affected limb instantly. Warning: Do not use on open cuts."

	required_reagents = list(
		/reagent/medicine/bicaridine = 1,
		/reagent/medicine/synthblood = 1,
		/reagent/carbon = 1
	)

	results = list(
		/reagent/medicine/synthflesh = 3
	)

/reagent_recipe/medicine/dexalin

	name = "Dexalin"
	desc = "Blue for oxy."

	required_reagents = list(
		/reagent/fuel/acetone = 1,
		/reagent/fuel/phoron = 1
	)

	results = list(
		/reagent/medicine/dexalin = 1
	)


/reagent_recipe/medicine/kelotane

	name = "Kelotane"
	desc = "Yellow for burn."

	required_reagents = list(
		/reagent/carbon = 1,
		/reagent/silicon = 1,
	)

	results = list(
		/reagent/medicine/kelotane = 2
	)

/reagent_recipe/medicine/charcoal

	name = "Charcoal"
	desc = "Purges poisons from the system while healing a slight amount of toxins. Works just as well when consumed."

	required_reagents = list(
		/reagent/ash = 1,
		/reagent/salt/sodium_chloride = 1
	)

	results = list(
		/reagent/medicine/charcoal = 2
	)

	required_temperature_min = list(
		/reagent/ash = 380,
		/reagent/salt/sodium_chloride = 380
	)


/reagent_recipe/medicine/silver_sulfadiazine

	name = "Silver Sulfadiazine"
	desc = "Heals burn damage. Only works when applied to skin."

	required_reagents = list(
		/reagent/ammonia = 1,
		/reagent/silver = 1,
		/reagent/sulfur = 1,
		/reagent/fuel/oxygen = 1,
		/reagent/chlorine = 1
	)

	results = list(
		/reagent/medicine/silver_sulfadiazine = 1
	)

/reagent_recipe/medicine/styptic_powder

	name = "Styptic Powder"
	desc = "Heals brute damage. Only works when applied to skin."

	required_reagents = list(
		/reagent/aluminium = 1,
		/reagent/fuel/welding = 1,
		/reagent/acid/sulphuric = 1
	)

	results = list(
		/reagent/medicine/styptic_powder = 1
	)


/reagent_recipe/medicine/epinephrine

	name = "Epinephrine"
	desc = "Used for reviving dying patients. Provides the ADRENALINE! effect for a short period of time."

	required_reagents = list(
		/reagent/fuel/acetone = 1,
		/reagent/fuel/diethylamine = 1,
		/reagent/phenol = 1,
		/reagent/chlorine = 1,
		/reagent/fuel/welding = 1
	)

	results = list(
		 /reagent/medicine/adrenaline/epinephrine = 1
	)


/reagent_recipe/medicine/antihol

	name = "Antihol"
	desc = "Purges alcohol from your system quickly."

	required_reagents = list(
		/reagent/medicine/charcoal = 1,
		/reagent/copper = 1,
		/reagent/nutrition/ethanol = 1
	)

	results = list(
		 /reagent/medicine/antihol = 1
	)

/reagent_recipe/medicine/synthblood

	name = "Synthblood"
	desc = "A special synthetic blood that replicates the blood type of any organic being when injected. Usually more expensive than just using real blood, however it has some chemical applications."

	required_reagents = list(
		/reagent/medicine/inaprovaline = 1,
		/reagent/iron = 1,
		/reagent/sodium = 1
	)

	results = list(
		 /reagent/medicine/synthblood = 1
	)





//End of approved recipes


//Odd specific recipes that are mostly corporate owned and thus aren't listed.

/reagent_recipe/medicine/caridone

	name = "Caridone"

	required_reagents = list(
		/reagent/medicine/bicaridine = 1,
		/reagent/fuel/acetone = 1,
		/reagent/enzymes = 1
	)

	results = list(
		/reagent/medicine/caridone = 1
	)

	secret = TRUE

/reagent_recipe/medicine/percardone

	name = "Percardone"

	required_reagents = list(
		/reagent/medicine/bicaridine = 1,
		/reagent/medicine/adrenaline/epinephrine = 1,
		/reagent/enzymes = 1,
		/reagent/phenol = 1
	)

	results = list(
		/reagent/medicine/percardone = 1
	)

	secret = TRUE

/reagent_recipe/medicine/carotane

	name = "Carotane"

	required_reagents = list(
		/reagent/medicine/kelotane = 1,
		/reagent/medicine/bicaridine = 1,
		/reagent/enzymes = 1
	)

	results = list(
		/reagent/medicine/carotane = 1
	)

	secret = TRUE

/reagent_recipe/medicine/dicarditane

	name = "Dicarditane"

	required_reagents = list(
		/reagent/medicine/carotane = 1,
		/reagent/fuel/diethylamine = 1
	)

	results = list(
		/reagent/medicine/dicarditane = 1
	)

	secret = TRUE

/reagent_recipe/medicine/arentane

	name = "Arentane"

	required_reagents = list(
		/reagent/medicine/kelotane = 1,
		/reagent/fuel/acetone = 1,
		/reagent/enzymes = 1
	)

	results = list(
		/reagent/medicine/arentane = 1
	)

	secret = TRUE

/reagent_recipe/medicine/kenotone

	name = "Kenotone"

	required_reagents = list(
		/reagent/medicine/kelotane = 2,
		/reagent/fuel/phoron = 1
	)

	results = list(
		/reagent/medicine/arentane = 1
	)

	secret = TRUE

/reagent_recipe/medicine/extinatane

	name = "Extinatane "

	required_reagents = list(
		/reagent/medicine/kelotane = 1,
		/reagent/medicine/silver_sulfadiazine = 1,
		/reagent/fuel/diethylamine = 1,
		/reagent/nitrogen = 1
	)

	results = list(
		/reagent/medicine/extinatane = 1
	)

	secret = TRUE
