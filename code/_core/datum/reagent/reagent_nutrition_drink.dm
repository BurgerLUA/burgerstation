/reagent/nutrition/water
	name = "water"
	desc = "What most lifeforms drink."
	color = "#99D5FF"
	alpha = 150

	flavor = "water"
	flavor_strength = 0.1

	liquid = 0.5

	hydration_amount = 25
	nutrition_quality_amount = 3
	heal_factor = 0

	cooled_reagent_temp = T0C - 1
	cooled_reagent_amount = 1
	cooled_reagent_mul = 0.25

/reagent/nutrition/water/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(. && isturf(target))
		var/turf/T = target
		var/cleaning_power = volume_to_splash*5*strength_mod
		for(var/obj/effect/cleanable/C in T.contents)
			if(cleaning_power <= 0)
				break
			qdel(C)
			cleaning_power -= 10
		if(is_simulated(target))
			var/turf/simulated/S = target
			S.add_wet(volume_to_splash*10*strength_mod)

	return .

/reagent/nutrition/ice
	name = "ice"
	desc = "What most lifeforms use to cool their drinks."
	color = "#E5FFFF"
	alpha = 200

	flavor = "ice"
	flavor_strength = 0.1

	liquid = -0.5

	hydration_amount = 25
	nutrition_quality_amount = 3
	heal_factor = 0

	heated_reagent_temp = T0C + 1
	heated_reagent_amount = 0.25
	heated_reagent_mul = 0.25
	heated_reagent = /reagent/nutrition/water

	temperature_mod = 50

/reagent/nutrition/soda
	name = "carbonated water"
	desc = "Carbonated water."
	color = "#DDFFFF"
	alpha = 225

	nutrition_amount = 5
	hydration_amount = 15
	nutrition_quality_amount = -3

	flavor = "white noise"

	heal_factor = 0

	liquid = 0.7

/reagent/nutrition/soda/cola
	name = "\improper Space Cola"
	desc = "Drink Space Cola!"
	color = "#5D2500"

	flavor = "cola"

/reagent/nutrition/soda/grape
	name = "\improper Starkist Grape Soda"
	desc = "Head for the stars!"
	color = "#57007F"

	flavor = "grape soda"

/reagent/nutrition/soda/orange
	name = "\improper Starkist Orange Soda"
	desc = "Head for the stars!"
	color = "#590000"

	flavor = "orange soda"

/reagent/nutrition/soda/iced_tea
	name = "\improper Disk! Iced Tea"
	desc = "Secure that refreshing flavor!"
	color = "#A55C2B"

	nutrition_amount = 2
	hydration_amount = 15
	nutrition_quality_amount = -2

	flavor = "iced tea"

/reagent/nutrition/soda/mountain_wind
	name = "\improper Space Mountain Wind"
	desc = "Do the Mountain!"
	color = "#B6FF00"

	flavor = "citrus soda"


/reagent/nutrition/soda/dr_gibb
	name = "\improper Dr. Gibb"
	desc = "42 varierties of flavor!"
	color = "#590000"

	flavor = "cherry cola"

/reagent/nutrition/soda/space_up
	name = "\improper Space Up!"
	desc = "Space up with Space Up!"
	color = "#590000"

	flavor = "lemon lime soda"