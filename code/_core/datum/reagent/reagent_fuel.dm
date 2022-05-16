/reagent/fuel
	name = "Generic Fuel"
	color = "#7F3300"
	alpha = 255

	particle_size = 0.5

	var/explosion_strength_per_unit = 0
	var/flash_strength_per_unit = 0
	var/bang_strength_per_unit = 0

	blood_toxicity_multiplier = 5

/reagent/fuel/act_explode(var/reagent_container/container,var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag) //What happens when this reagent is hit by an explosive.

	var/turf/T = get_turf(container.owner)

	var/volume_amount = container.remove_reagent(src.type,container.volume_current,caller = owner) //Can't be bothered to get the exact amount needed to be removed as it is handled in the proc anyways.

	if(explosion_strength_per_unit > 0)
		explode(epicenter,volume_amount*explosion_strength_per_unit,owner,source,desired_loyalty_tag)
		smoke(epicenter,volume_amount*explosion_strength_per_unit*0.02,SECONDS_TO_DECISECONDS(2*explosion_strength_per_unit),null,owner,alpha=100)

	if(flash_strength_per_unit > 0)
		var/flash_range = min(VIEW_RANGE*2,volume_amount*flash_strength_per_unit)
		for(var/mob/living/L in viewers(flash_range,T))
			var/strength_mod = 0.25 + (1 - (get_dist(L,T)/VIEW_RANGE))*0.75
			var/duration = SECONDS_TO_DECISECONDS(10)*strength_mod
			L.flash(duration)

	if(bang_strength_per_unit > 0)
		var/bang_range = min(VIEW_RANGE*2,volume_amount*bang_strength_per_unit)
		var/list/hearing = list()
		for(var/mob/living/L in hearers(bang_range,T))
			var/strength_mod = 0.25 + (1 - (get_dist(L,T)/VIEW_RANGE))*0.75
			var/duration = SECONDS_TO_DECISECONDS(10)*strength_mod
			L.flash(duration)
			L.bang(duration*2)
			hearing += L
		play_sound('sound/effects/flashbang.ogg',T,volume=75,range_min=bang_range*0.5,range_max=bang_range*2,channel=SOUND_CHANNEL_FLASHBANG)
		play_sound_global('sound/effects/flashring.ogg',hearers=hearing,volume=75,channel=SOUND_CHANNEL_FLASHBANG)

	. = ..()

/reagent/fuel/oxygen //Found in the snow biome as a magic plant
	name = "Liquid Oxygen"
	desc = "What most lifeforms breathe in, but in liquid form."
	color = "#E6F2F2"
	alpha = 200

	flavor = "oxygen"

	liquid = 0.25

	explosion_strength_per_unit = 0.25

	heated_reagent = null //Nothing.
	heated_reagent_temp = 54.36

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

/reagent/fuel/potassium_perchlorate
	name = "Potassium Perchlorate"
	desc = "What causes the bang in the flashbang."

	liquid = -0.5
	particle_size = 0.2

	explosion_strength_per_unit = 0.1
	bang_strength_per_unit = 30/VIEW_RANGE

/reagent/fuel/flash_powder
	name = "Flash Powder Mixture"
	desc = "What causes the flash and bang in the flashbang."

	liquid = -0.5
	particle_size = 0.3

	explosion_strength_per_unit = 0.05
	flash_strength_per_unit = 20/VIEW_RANGE
	bang_strength_per_unit = 40/VIEW_RANGE
