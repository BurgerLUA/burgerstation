//Stats gathered here: https://www.healthline.com/health/rarest-blood-type#rarest-type

/reagent/blood //Found through organic things
	name = "Rh Null Human Blood"
	desc = "What most lifeforms do things with."
	color = "#880000"
	alpha = 255

	flavor = "blood"

	metabolism_blood = 0

	liquid = 0.4

	var/list/compatible_blood = list(/reagent/blood)

/reagent/blood/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)
	. = ..()
	if(amount_added && (container.flags_metabolism & REAGENT_METABOLISM_BLOOD) && is_living(container.owner.loc))
		var/mob/living/L = container.owner.loc
		if(L.blood_type)
			var/reagent/blood/R = REAGENT(L.blood_type)
			if(R.compatible_blood[src.type])
				L.blood_volume += .
				. = 0

	return .

/reagent/blood/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(owner.health) owner.health.adjust_loss_smart(tox=.*5)
	return .

/reagent/blood/human/ab_negative
	name = "AB Negative Human Blood"

	compatible_blood = list(
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/b_negative = TRUE,
		/reagent/blood/human/a_negative = TRUE,
		/reagent/blood/human/ab_negative = TRUE
	)

/reagent/blood/human/b_negative
	name = "B Negative Human Blood"

	compatible_blood = list(
		/reagent/blood/human/b_negative = TRUE,
		/reagent/blood/human/o_negative = TRUE
	)

/reagent/blood/human/ab_positive
	name = "AB Positive Human Blood"

	compatible_blood = list(
		/reagent/blood/human/ab_negative = TRUE,
		/reagent/blood/human/b_negative = TRUE,
		/reagent/blood/human/ab_positive = TRUE,
		/reagent/blood/human/a_negative = TRUE,
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/b_positive = TRUE,
		/reagent/blood/human/a_positive = TRUE,
		/reagent/blood/human/o_positive = TRUE
	)

/reagent/blood/human/a_negative
	name = "A Negative Human Blood"

	compatible_blood = list(
		/reagent/blood/human/a_negative = TRUE,
		/reagent/blood/human/o_negative = TRUE,
	)

/reagent/blood/human/o_negative
	name = "O Negative Human Blood"

	compatible_blood = list(
		/reagent/blood/human/o_negative = TRUE
	)

/reagent/blood/human/b_positive
	name = "B Positive Human Blood"

	compatible_blood = list(
		/reagent/blood/human/b_positive = TRUE,
		/reagent/blood/human/b_negative = TRUE,
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/o_positive = TRUE
	)

/reagent/blood/human/a_positive
	name = "A Positive Human Blood"

	compatible_blood = list(
		/reagent/blood/human/a_negative = TRUE,
		/reagent/blood/human/a_positive = TRUE,
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/o_positive = TRUE
	)

/reagent/blood/human/o_positive
	name = "O Positive Human Blood"

	compatible_blood = list(
		/reagent/blood/human/o_negative = TRUE,
		/reagent/blood/human/o_positive = TRUE
	)

/reagent/blood/robot
	name = "Robotic Oil Enzymes"

	compatible_blood = list(
		/reagent/blood/robot = TRUE
	)

/reagent/blood/xenomorph
	name = "Xenomorph Blood"

	compatible_blood = list(
		/reagent/blood/xenomorph = TRUE
	)

/reagent/blood/reptile
	name = "Reptile Blood"

	compatible_blood = list(
		/reagent/blood/reptile = TRUE
	)