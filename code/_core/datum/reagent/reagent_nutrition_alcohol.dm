// https://en.wikipedia.org/wiki/Alcohol_by_volume#Typical_levels

/reagent/nutrition/ethanol //Found through organic things
	name = "ethanol"
	desc = "What most lifeforms drink."
	color = "#778877"
	alpha = 225

	flavor = "ethanol"
	flavor_strength = 3

	liquid = 0.75

	//Hydration, nutrition, and nutrition_quality are generated in new.

	var/power = 100 //Also known as alcohol by volume.

	heal_factor = 0

	value = 3

	lethal = TRUE

	blood_toxicity_multiplier = 3

/reagent/nutrition/ethanol/New(var/desired_loc)
	var/power_mod = power*0.01
	nutrition_amount = power_mod*10
	hydration_amount = max(0,(1-power_mod)*5)
	nutrition_quality_amount = -nutrition_amount*0.5
	particle_size = 0.1 + min(power_mod,1)*0.2
	liquid = 1 - min(power_mod,1)*0.5
	. = ..()

/reagent/nutrition/ethanol/get_flammability()
	return power*0.001 //100 means it would be 0.1

/reagent/nutrition/ethanol/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		owner.intoxication += power*.
		owner.sanity_regen_buffer += power*.

/reagent/nutrition/ethanol/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner.health)
		owner.intoxication += power*.*0.5*multiplier
		owner.sanity_regen_buffer += power*.*multiplier

/reagent/nutrition/ethanol/fernet
	name = "fernet"
	color = "#370000"

	flavor = "fernet"
	flavor_strength = 4

	power = 45


/reagent/nutrition/ethanol/beer
	name = "beer"
	color = "#CCAE57"

	flavor = "beer"
	flavor_strength = 2

	power = 5

/reagent/nutrition/ethanol/ale
	name = "ale"
	color = "#C67217"

	flavor = "ale"
	flavor_strength = 2

	power = 25

/reagent/nutrition/ethanol/cider
	name = "cider"
	color = "#FFBE3D"

	flavor = "cider"
	flavor_strength = 3

	power = 6

/reagent/nutrition/ethanol/rum
	name = "rum"
	color = "#D37D43"

	flavor = "rum"
	flavor_strength = 2

	power = 40

/reagent/nutrition/ethanol/whiskey
	name = "whiskey"
	color = "#CD6500"

	flavor = "whiskey"
	flavor_strength = 3

	power = 43

/reagent/nutrition/ethanol/vodka
	name = "vodka"
	color = "#F4FFFF"

	flavor = "vodka"
	flavor_strength = 4

	power = 40

/reagent/nutrition/ethanol/vodka/premium
	name = "premium vodka"
	color = "#FFFFFF"

	flavor = "premium vodka"
	flavor_strength = 3

	power = 95

/reagent/nutrition/ethanol/gin
	name = "gin"
	color = "#FFFFFF"

	flavor = "gin"
	flavor_strength = 4

	power = 45

/reagent/nutrition/ethanol/brandy
	name = "brandy"
	color = "#CE4A1E"

	flavor = "brandy"
	flavor_strength = 6

	power = 45

/reagent/nutrition/ethanol/schnapps/gold
	name = "gold schnapps"
	color = "#FFF6CC"

	flavor = "gold"
	flavor_strength = 2

	power = 40

/reagent/nutrition/ethanol/nothing
	name = "nothing"
	color = "#FFFFFF"

	flavor = "nothing"
	flavor_strength = 1

	power = 0

/reagent/nutrition/ethanol/coffee_liqueur
	name = "coffee liqueur"
	color = "#A85721"

	flavor = "coffee liqueur"
	flavor_strength = 2

	power = 20

/reagent/nutrition/ethanol/tequila
	name = "tequila"
	color = "#CC9B4E"

	flavor = "tequila"
	flavor_strength = 4

	power = 40

/reagent/nutrition/ethanol/tequila/premium
	name = "premium tequila"
	color = "#CC9B4E"

	flavor = "premium tequila"
	flavor_strength = 5

	power = 60

/reagent/nutrition/ethanol/wine
	name = "red wine"
	color = "#7F0000"

	flavor = "red wine"
	flavor_strength = 3

	power = 12.5

/reagent/nutrition/ethanol/wine/vermouth
	name = "vermouth"
	color = "#F3FFD6"

	flavor = "vermouth"
	flavor_strength = 4

	power = 14.5

/reagent/nutrition/ethanol/wine/lizard
	name = "lizard wine"
	color = "#2EC17A"

	flavor = "lizard wine"
	flavor_strength = 5

	power = 16


/reagent/nutrition/ethanol/hearty_punch
	name = "hearty punch"
	color = "#E06967"

	flavor = "hearty punch"
	flavor_strength = 3
	heal_factor = 4

	power = 30

/reagent/nutrition/ethanol/absinthe
	name = "absinthe"
	color = "#26A300"

	flavor = "absinthe"
	flavor_strength = 6

	power = 45

/reagent/nutrition/ethanol/absinthe/premium
	name = "premium absinthe"
	color = "#2DC400"

	flavor = "absinthe"
	flavor_strength = 8

	power = 89.9

/reagent/nutrition/ethanol/grappa
	name = "grappa"
	color = "#FFF9C9"

	flavor = "grappa"
	flavor_strength = 3

	power = 50
