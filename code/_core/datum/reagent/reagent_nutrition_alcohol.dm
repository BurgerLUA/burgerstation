// https://en.wikipedia.org/wiki/Alcohol_by_volume#Typical_levels

/reagent/nutrition/ethanol //Found through organic things
	name = "ethanol"
	desc = "What most lifeforms drink."
	color = "#778877"

	flavor = "ethanol"
	flavor_strength = 3

	liquid = 0.5

	hydration_amount = 10

	var/power = 100 //Also known as alcohol by volume.

/reagent/nutrition/ethanol/New(var/desired_loc)
	. = ..()

	value += power*0.02

	return .


/reagent/nutrition/ethanol/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.intoxication += power*.

	return .

/reagent/nutrition/ethanol/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.intoxication += power*.

	return .


/reagent/nutrition/ethanol/fernet
	name = "fernet"
	color = "#370000"

	flavor = "fernet"

	power = 45


/reagent/nutrition/ethanol/beer
	name = "beer"
	color = "#CCAE57"

	flavor = "beer"

	power = 5

/reagent/nutrition/ethanol/ale
	name = "ale"
	color = "#C67217"

	flavor = "ale"

	power = 25

/reagent/nutrition/ethanol/cider
	name = "cider"
	color = "#FFBE3D"

	flavor = "cider"

	power = 6

/reagent/nutrition/ethanol/rum
	name = "rum"
	color = "#D37D43"

	flavor = "rum"

	power = 40

/reagent/nutrition/ethanol/whiskey
	name = "whiskey"
	color = "#CD6500"

	flavor = "whiskey"

	power = 43

/reagent/nutrition/ethanol/vodka
	name = "vodka"
	color = "#F4FFFF"

	flavor = "vodka"

	power = 40

/reagent/nutrition/ethanol/vodka/premium
	name = "premium vodka"
	color = "#FFFFFF"

	flavor = "premium vodka"

	power = 95

/reagent/nutrition/ethanol/gin
	name = "gin"
	color = "#FFFFFF"

	flavor = "gin"

	power = 45

/reagent/nutrition/ethanol/brandy
	name = "brandy"
	color = "#CE4A1E"

	flavor = "brandy"

	power = 45

/reagent/nutrition/ethanol/schnapps/gold
	name = "gold schnapps"
	color = "#FFF6CC"

	flavor = "gold"

	power = 40

/reagent/nutrition/ethanol/nothing
	name = "nothing"
	color = "#FFFFFF"

	flavor = "nothing"

	power = 0

/reagent/nutrition/ethanol/coffee_liqueur
	name = "coffee liqueur"
	color = "#A85721"

	flavor = "coffee liqueur"

	power = 20

/reagent/nutrition/ethanol/tequila
	name = "tequila"
	color = "#CC9B4E"

	flavor = "tequila"

	power = 40

/reagent/nutrition/ethanol/tequila/premium
	name = "premium tequila"
	color = "#CC9B4E"

	flavor = "premium tequila"

	power = 60

/reagent/nutrition/ethanol/wine
	name = "red wine"
	color = "#7F0000"

	flavor = "red wine"

	power = 12.5

/reagent/nutrition/ethanol/wine/vermouth
	name = "vermouth"
	color = "#F3FFD6"

	flavor = "vermouth"

	power = 14.5

/reagent/nutrition/ethanol/wine/lizard
	name = "lizard wine"
	color = "#2EC17A"

	flavor = "lizard wine"

	power = 16


/reagent/nutrition/ethanol/hearty_punch
	name = "hearty punch"
	color = "#E06967"

	flavor = "hearty punch"

	power = 20

/reagent/nutrition/ethanol/absinthe
	name = "absinthe"
	color = "#26A300"

	flavor = "absinthe"

	power = 45

/reagent/nutrition/ethanol/absinthe/premium
	name = "premium absinthe"
	color = "#2DC400"

	flavor = "absinthe"

	power = 89.9

/reagent/nutrition/ethanol/grappa
	name = "grappa"
	color = "#FFF9C9"

	flavor = "grappa"

	power = 50