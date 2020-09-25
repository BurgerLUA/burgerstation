/reagent_recipe/explosion/
	category = "Explosions"

/reagent_recipe/explosion/water_potassium
	name = "Water-Potassium Explosion"
	category = "Explosions"
	required_reagents = list(
		/reagent/nutrition/water = 1,
		/reagent/potassium = 1
	)

	results = list()

/reagent_recipe/explosion/water_potassium/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)

	var/turf/explosion_location = get_turf(container.owner)

	if(is_item(container.owner))
		var/obj/item/I = container.owner
		I.drop_item(explosion_location)

	var/explosion_power = round( ((magnitude ** 0.3) * 0.5) + magnitude*0.0125, 0.01)

	var/shrapnel_volume = 0

	var/list/shapnel_reagents = list(
		/reagent/iron = TRUE,
		/reagent/steel = TRUE
	)

	var/tag_to_use
	if(is_living(caller))
		var/mob/living/L = caller
		tag_to_use = L.loyalty_tag

	for(var/reagent_type in container.stored_reagents)
		var/reagent_volume = container.stored_reagents[reagent_type]
		if(shapnel_reagents[reagent_type])
			shrapnel_volume += reagent_volume
	var/shrapnel_amount = CEILING(shrapnel_volume/6,1)
	container.owner.shoot_projectile(caller,explosion_location,null,null,/obj/projectile/bullet/firearm/shotgun_pellet,/damagetype/ranged/shrapnel,16,16,4,TILE_SIZE*0.5,shrapnel_amount,"#FFFFFF",0,0,1,null,tag_to_use,2,1)
	explode(explosion_location,explosion_power,caller,container.owner,tag_to_use)

	return TRUE