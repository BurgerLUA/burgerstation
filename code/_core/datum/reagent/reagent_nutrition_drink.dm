/reagent/nutrition/water
	name = "water"
	desc = "What most lifeforms drink."
	color = "#99D5FF"
	alpha = 150

	flavor = "water"
	flavor_strength = 0.1

	particle_size = 0
	liquid = 1

	hydration_amount = 25
	heal_factor = 0

	cooled_reagent_temp = T0C - 1
	cooled_reagent_amount = 0
	cooled_reagent_mul = 1
	cooled_reagent = /reagent/nutrition/ice

	value = 0.75

/reagent/nutrition/water/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)

	. = ..()

	if(.)
		if(is_turf(target))
			var/turf/T = target
			var/cleaning_power = volume_to_splash*5*strength_mod
			for(var/obj/effect/cleanable/C in T.contents)
				if(cleaning_power <= 0)
					break
				qdel(C)
				cleaning_power -= 10
			for(var/obj/fire_process/FP in T.contents)
				FP.fire_power -= volume_to_splash*strength_mod*10
			if(is_simulated(target))
				var/turf/simulated/S = target
				S.add_wet(volume_to_splash*10*strength_mod)
		else if(is_advanced(target))
			var/cleaning_power = volume_to_splash*strength_mod*0.2
			var/mob/living/advanced/A = target
			A.make_clean(clean_strength=cleaning_power)


/reagent/nutrition/water/holy
	name = "holy water"
	desc = "What most lifeforms bless with."
	color = "#99D5FF"
	alpha = 100

	flavor = "holy water"
	flavor_strength = 0.5

	particle_size = 0
	liquid = 1

	hydration_amount = 25

	heal_factor = 2

	value = 3

/reagent/nutrition/ice
	name = "ice"
	desc = "What most lifeforms use to cool their drinks."
	color = "#E5FFFF"
	alpha = 200

	flavor = "ice"
	flavor_strength = 0.1

	liquid = -0.5

	hydration_amount = 25
	heal_factor = 0

	heated_reagent_temp = T0C + 1
	heated_reagent_amount = REAGENT_ROUNDING
	heated_reagent_mul = 0
	heated_reagent = /reagent/nutrition/water

	temperature_mod = 50
	particle_size = 0.9

/reagent/nutrition/soda
	name = "carbonated water"
	desc = "Carbonated water."
	color = "#DDFFFF"
	alpha = 225

	hydration_amount = 15

	flavor = "white noise"

	heal_factor = 0

	liquid = 0.7
	particle_size = 0.2

/reagent/nutrition/soda/cola
	name = "\improper Space Cola"
	desc = "Drink Space Cola!"
	color = "#5D2500"

	flavor = "cola"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0

/reagent/nutrition/soda/grape
	name = "\improper Starkist Grape Soda"
	desc = "Head for the stars!"
	color = "#57007F"

	flavor = "grape soda"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0

/reagent/nutrition/soda/orange
	name = "\improper Starkist Orange Soda"
	desc = "Head for the stars!"
	color = "#590000"

	flavor = "orange soda"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0

/reagent/nutrition/soda/iced_tea
	name = "\improper Disk! Iced Tea"
	desc = "Secure that refreshing flavor!"
	color = "#A55C2B"

	nutrition_fast_amount = 5
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0

	flavor = "iced tea"

/reagent/nutrition/soda/mountain_wind
	name = "\improper Space Mountain Wind"
	desc = "Do the Mountain!"
	color = "#B6FF00"

	flavor = "citrus soda"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0


/reagent/nutrition/soda/dr_gibb
	name = "\improper Dr. Gibb"
	desc = "42 varierties of flavor!"
	color = "#590000"

	flavor = "cherry cola"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0

/reagent/nutrition/soda/space_up
	name = "\improper Space Up!"
	desc = "Space up with Space Up!"
	color = "#590000"

	flavor = "lemon lime soda"

	nutrition_fast_amount = 10
	nutrition_normal_amount = 0
	nutrition_quality_amount = 0