/reagent/nutrition/
	name = "nutrients"
	desc = "A source of nutrition."
	color = "#FFFFFF"

	metabolism_stomach = 1

	var/nutrition_amount = 0 //Per unit
	var/hydration_amount = 0 //Per unit
	var/heal_factor = 1 //Per unit.

	value = 1

	liquid = -0.25

	heated_reagent = /reagent/carbon
	heated_reagent_temp = 300
	heated_reagent_amount = 0
	heated_reagent_mul = 0.01

/reagent/nutrition/New(var/desired_loc)
	//Automatically set value.
	value *= 0.1+((nutrition_amount*0.1)+(hydration_amount*0.05)+(heal_factor*2)*0.1)
	return ..()


/reagent/nutrition/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(amount_added && (container.flags_metabolism & REAGENT_METABOLISM_INGEST) && is_living(container.owner.loc))
		var/mob/living/L = container.owner.loc
		. *= 0.5
		if(nutrition_amount)
			L.add_nutrition(nutrition_amount*.)
		if(hydration_amount)
			L.add_hydration(hydration_amount*.)

	return .


/reagent/nutrition/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	var/mob/living/L = owner
	if(nutrition_amount)
		L.add_nutrition(nutrition_amount*.)
		L.blood_volume = clamp(L.blood_volume + nutrition_amount*.*0.1,0,L.blood_volume_max)
	if(hydration_amount)
		L.add_hydration(hydration_amount*.)

	if(owner && owner.health)
		var/amount_to_heal = heal_factor*.

		if(amount_to_heal > 0)
			owner.health.adjust_loss_smart(brute=-amount_to_heal,burn=-amount_to_heal,tox=-amount_to_heal)
		else if(amount_to_heal < 0)
			owner.health.adjust_loss_smart(tox=-amount_to_heal)

	return .

/reagent/nutrition/sugar
	name = "white sugar"
	desc = "Processed sugar."
	color = "#F4FFF8"

	nutrition_amount = 16

	flavor = "sweetness"

	liquid = -0.4

/reagent/nutrition/sugar/cane
	name = "cane sugar"
	desc = "Unprocessed sugarcane sugar."
	color = "#CEA171"

	nutrition_amount = 16

	flavor = "sweetness"

/reagent/nutrition/sugar/icing
	name = "icing sugar"
	desc = "White and fluffy icing sugar."
	color = "#F4FFF8"

	nutrition_amount = 14

	flavor = "icing sugar"

/reagent/nutrition/icing
	name = "white icing"
	desc = "White icing."
	color = "#FFFFFF"

	nutrition_amount = 16

	flavor = "icing"


/reagent/nutrition/chanterelle
	name = "chanterelle"
	desc = "Nutrition and flavor from a chanterelle mushroom."
	color = "#FFDD8F"

	nutrition_amount = 20

	flavor = "mushroom"

	liquid = -0.2

/reagent/nutrition/tomato
	name = "tomato paste"
	desc = "Nutrition and flavor from a tomato."
	color = "#C90000"

	nutrition_amount = 20

	flavor = "tomato"

	liquid = 0.3

/reagent/nutrition/cabbage
	name = "cabbage"
	desc = "Nutrition and flavor from a cabbage."
	color = "#658268"

	nutrition_amount = 20

	flavor = "cabbage"

	liquid = 0

/reagent/nutrition/egg_white
	name = "egg whites"
	desc = "Nutrition and flavor from egg whites."
	color = "#FFD865"

	nutrition_amount = 10
	heal_factor = 1

	flavor = "egg white"

/reagent/nutrition/egg_yellow
	name = "egg yolk"
	desc = "Nutrition and flavor from egg yellows."
	color = "#FFFFE4"

	nutrition_amount = 40
	heal_factor = 3

	flavor = "egg yolk"