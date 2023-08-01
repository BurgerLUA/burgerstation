//Basically food poisoning as a reagent. Reagent name is disguised as something else.
//Can be "transumted" into something good when cooked.

//Safe poulty temperature: 165F, or 347.039K (Made 340 for convience)
//Safe beef temperature: 145F, or 335.928K (Made to 325 for convience)


/reagent/nutrition/bad_meat

	name = "contaminated meat"

	flags_flavor = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW | FLAG_FLAVOR_MEAT
	liquid = 0.2

	flags_reagent = FLAG_REAGENT_RAW

	heated_reagent_temp = 325
	heated_reagent_mul = 0.05
	heated_reagent_amount = 5

	nutrition_fast_amount = 10
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0

	heated_reagent = /reagent/nutrition/flavor //Lazy, but it werks.
	disguised_reagent = /reagent/nutrition/meat

	lethal = TRUE

	heal_factor = -10

/reagent/nutrition/bad_meat/chicken
	heated_reagent_temp = 340
	flags_flavor = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW | FLAG_FLAVOR_CHICKEN
	heal_factor = -15

/reagent/nutrition/bad_meat/fish
	heated_reagent_temp = 325
	flags_flavor = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW | FLAG_FLAVOR_FISH
	heal_factor = -5

/reagent/nutrition/bad_meat/insect
	heated_reagent_temp = 360
	flags_flavor = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW
	heal_factor = -10

/reagent/nutrition/bad_meat/ancient
	heated_reagent_temp = 350
	flags_flavor = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW | FLAG_FLAVOR_NECRO
	heal_factor = -10