/obj/item/container/simple/
	icon = 'icons/obj/item/container/alcohol.dmi'
	reagents = /reagent_container/beaker/large
	size = SIZE_2

/obj/item/container/simple/fernet
	name = "Fernet Italiano"
	icon_state = "fernet"
	initial_reagent = /reagent/nutrition/ethanol/fernet

/obj/item/container/simple/beer
	name = "Space Beer"
	icon_state = "beer"
	reagents = /reagent_container/beaker
	initial_reagent = /reagent/nutrition/ethanol/beer

/obj/item/container/simple/ale
	name = "Urist's Ale"
	icon_state = "ale"
	reagents = /reagent_container/beaker
	initial_reagent = /reagent/nutrition/ethanol/ale

/obj/item/container/simple/cider
	name = "Toolbox Hard Cider"
	icon_state = "cider"
	reagents = /reagent_container/beaker
	initial_reagent = /reagent/nutrition/ethanol/cider

/obj/item/container/simple/rum
	name = "Captain Pete's Spiced Rum"
	icon_state = "rum"
	initial_reagent = /reagent/nutrition/ethanol/rum

/obj/item/container/simple/whiskey
	name = "Uncle Git's Special Reserve Whiskey"
	icon_state = "whiskey"
	initial_reagent = /reagent/nutrition/ethanol/whiskey

/obj/item/container/simple/vodka
	name = "Vladimr Vodka"
	icon_state = "vodka"
	initial_reagent = /reagent/nutrition/ethanol/vodka

/obj/item/container/simple/vodka/premium
	name = "Badminka Vodka"
	icon_state = "badminka"
	initial_reagent = /reagent/nutrition/ethanol/vodka/premium

/obj/item/container/simple/gin
	name = "Griffeater's Gin"
	icon_state = "gin"
	initial_reagent = /reagent/nutrition/ethanol/gin

/obj/item/container/simple/brandy
	name = "Woody & Andy's Brandy"
	icon_state = "brandy"
	initial_reagent = /reagent/nutrition/ethanol/brandy

/obj/item/container/simple/schnapps/gold
	name = "Gold Sparkle Schnapps"
	icon_state = "schnapps_gold"
	initial_reagent = /reagent/nutrition/ethanol/schnapps/gold

/obj/item/container/simple/nothing
	name = "Nothing"
	icon_state = "nothing"
	initial_reagent = /reagent/nutrition/ethanol/nothing

/obj/item/container/simple/coffee_liqueur
	name = "Robusto Coffee Liqueur"
	icon_state = "coffee_liqueur"
	initial_reagent = null

/obj/item/container/simple/coffee_liqueur/Generate()
	reagents.add_reagent(/reagent/nutrition/ethanol/coffee_liqueur,reagents.volume_max*0.5)
	reagents.add_reagent(/reagent/nutrition/energy/coffee,reagents.volume_max*0.5)
	return ..()

/obj/item/container/simple/tequila
	name = "Spaceworm Tequila"
	icon_state = "tequila"
	initial_reagent = /reagent/nutrition/ethanol/tequila

/obj/item/container/simple/tequila/premium
	name = "Star Premium Tequila"
	icon_state = "tequila_premium"
	initial_reagent = /reagent/nutrition/ethanol/tequila/premium

/obj/item/container/simple/wine
	name = "Doublebeard's Red Wine"
	icon_state = "wine"
	initial_reagent = /reagent/nutrition/ethanol/wine

/obj/item/container/simple/wine/vermouth
	name = "Bernie Sander's Vermouth"
	icon_state = "vermouth"
	initial_reagent = /reagent/nutrition/ethanol/wine/vermouth

/obj/item/container/simple/wine/lizard
	name = "Lizard Wine"
	icon_state = "lizardwine"
	initial_reagent = /reagent/nutrition/ethanol/wine/lizard

/obj/item/container/simple/hearty_punch
	name = "Hearty Punch"
	icon_state = "hearty_punch"
	initial_reagent = /reagent/nutrition/ethanol/hearty_punch

/obj/item/container/simple/absinthe
	name = "Absinthe"
	icon_state = "absinthe"
	initial_reagent = /reagent/nutrition/ethanol/absinthe

/obj/item/container/simple/absinthe/New(var/desired_loc)

	var/list/possible_names = list(
		"\[CENSORED]-Strong Absinthe",
		"Extra-Strong Absinthe",
		"EXTREMELY ROBUST Absinthe"
	)

	name = pick(possible_names)

	return ..()

/obj/item/container/simple/absinthe/premium
	name = "Premium Yellowliver Absinthe"
	icon_state = "absinthepremium"
	initial_reagent = /reagent/nutrition/ethanol/absinthe/premium

/obj/item/container/simple/grappa
	name = "Grandpa's Grappa"
	icon_state = "grappa"
	initial_reagent = /reagent/nutrition/ethanol/grappa