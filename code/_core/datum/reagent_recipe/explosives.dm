/reagent_recipe/explosion_water_potassium

	name = "water potassium explosion"
	id = "explosion_water_potassium"

	required_reagents = list(
		"water" = 1,
		"potassium" = 1
	)

	results = list()

	var/list/explosion_sounds = list(
		'sounds/effects/explosion/Explosion1.ogg',
		'sounds/effects/explosion/Explosion2.ogg',
		'sounds/effects/explosion/Explosion3.ogg'
	)


/reagent_recipe/explosion_water_potassium/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)

	var/turf/explosion_location = get_turf(container.owner)

	var/explosion_power = round( ((magnitude ** 0.3) * 0.5) + magnitude*0.0125, 0.01)

	var/shrapnel_volume = 0

	var/list/shapnel_reagents = list(
		"steel" = TRUE,
		"iron" = TRUE
	)

	for(var/reagent_type in container.stored_reagents)
		var/reagent_volume = container.stored_reagents[reagent_type]
		if(shapnel_reagents[reagent_type])
			shrapnel_volume += reagent_volume
	var/shrapnel_amount = CEILING(shrapnel_volume/6,1)
	container.owner.shoot_projectile(caller,get_step(explosion_location,pick(DIRECTIONS_ALL)),null,null,/obj/projectile/bullet/shotgun_pellet,"shrapnel",16,16,4,TILE_SIZE*0.25,shrapnel_amount)
	explode(explosion_location,explosion_power,caller,container.owner)

	play(pick(explosion_sounds),explosion_location, alert = ALERT_LEVEL_CAUTION, alert_source = caller)

	return TRUE