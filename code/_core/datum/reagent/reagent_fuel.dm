/reagent/fuel
	name = "Generic Fuel"
	color = "#7F3300"
	alpha = 255

	particle_size = 0.5

	var/explosion_strength_per_unit = 1

/reagent/fuel/act_explode(var/reagent_container/container,var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty) //What happens when this reagent is hit by an explosive.

	if(explosion_strength_per_unit)
		var/volume_amount = container.remove_reagent(src.type,container.volume_current,caller = owner) //Can't be bothered to get the exact amount needed to be removed as it is handled in the proc anyways.
		explode(epicenter,volume_amount*explosion_strength_per_unit,owner,source,desired_loyalty)
		smoke(epicenter,volume_amount*explosion_strength_per_unit*0.02,SECONDS_TO_DECISECONDS(2*explosion_strength_per_unit),null,owner,alpha=100)

	. = ..()

/reagent/fuel/oil
	name = "Processed Oil"
	color = "#131616"
	alpha = 255

	particle_size = 0.25

	explosion_strength_per_unit = 0.75

/reagent/fuel/oil/crude
	name = "Crude Oil"
	color = "#0F0F0F"
	alpha = 255

	particle_size = 0.5

	heated_reagent = /reagent/fuel/oil
	heated_reagent_temp = 800
	heated_reagent_amount = 0
	heated_reagent_mul = 0.01

	explosion_strength_per_unit = 0.5

/reagent/fuel/oil/carbon
	name = "Carbonized Oil"
	color = "#000000"
	alpha = 255

	particle_size = 0.75

	heated_reagent = /reagent/ash
	heated_reagent_temp = 480
	heated_reagent_amount = 0
	heated_reagent_mul = 0.01

	explosion_strength_per_unit = 0.25

/reagent/fuel/welding
	name = "Welding Fuel"
	color = "#7F3300"
	alpha = 255

	particle_size = 0.3

	explosion_strength_per_unit = 1.5

/reagent/fuel/hydrogen
	name = "Solid Hydrogen"
	color = "#7F0000"
	alpha = 255

	particle_size = 0.75

	explosion_strength_per_unit = 2

/reagent/fuel/phoron
	name = "Solid Phoron"
	color = "#FF00DC"
	alpha = 255

	particle_size = 1

	explosion_strength_per_unit = 5

/reagent/fuel/acetone
	name = "Acetone"
	desc = "A colorless, corrosive flammable liquid used for solvents."
	alpha = 100

	particle_size = 0.1

	explosion_strength_per_unit = 0.5

/reagent/fuel/diethylamine
	name = "Diethylamine"
	alpha = 255

	particle_size = 0.75

	explosion_strength_per_unit = 1.5

/reagent/fuel/tnt
	name = "Trinitrotoluene"
	desc = "Also know as TNT, this material is very explosive."

	particle_size = 0.75

	explosion_strength_per_unit = 2.5