//Stats gathered here: https://www.healthline.com/health/rarest-blood-type#rarest-type

/reagent/blood //Found through organic things
	name = "Rh Null Human Blood"
	desc = "What most lifeforms do things with."
	color = "#880000"
	alpha = 255

	flavor = "blood"

	metabolism_blood = 10
	metabolism_stomach = 2

	liquid = 0.4

	var/list/compatible_blood = list(/reagent/blood)

	value = 2

/reagent/blood/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	. = ..()
	if(owner.health) owner.health.adjust_loss_smart(tox=.*0.25)
	return .

/reagent/blood/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		if(L.blood_type)
			var/reagent/blood/R = REAGENT(L.blood_type)
			if(R.compatible_blood[src.type])
				L.blood_volume += .
				L.queue_health_update = TRUE
		else
			if(owner.health) owner.health.adjust_loss_smart(tox=.*1)

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

	color = COLOR_BLACK

/reagent/blood/xenomorph
	name = "Xenomorph Blood"

	compatible_blood = list(
		/reagent/blood/xenomorph = TRUE
	)

	color = "#B6FF00"

/reagent/blood/reptile
	name = "Reptile Blood"

	compatible_blood = list(
		/reagent/blood/reptile = TRUE
	)

	color = "#88002B"