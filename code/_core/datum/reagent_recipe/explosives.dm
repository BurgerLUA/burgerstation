/reagent_recipe/explosion/
	category = "Chemistry"

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
	var/shrapnel_amount = min(12,CEILING(shrapnel_volume/4,1))
	container.owner.shoot_projectile(caller,explosion_location,null,null,/obj/projectile/bullet/firearm/shotgun_pellet,/damagetype/ranged/shrapnel,16,16,4,TILE_SIZE*0.5,shrapnel_amount,"#FFFFFF",0,0,1,null,tag_to_use,2,2)
	explode(explosion_location,explosion_power*10,caller,container.owner,tag_to_use)
	smoke(explosion_location,magnitude*0.05,40,container,caller)

	return TRUE

/reagent_recipe/explosion/smoke
	name = "Smoke"
	category = "Explosions"
	required_reagents = list(
		/reagent/nutrition/sugar = 1,
		/reagent/phosphorous = 1,
		/reagent/potassium = 1
	)

	results = list()

/reagent_recipe/explosion/smoke/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)
	var/turf/smoke_location = get_turf(container.owner)
	smoke(smoke_location,magnitude*1.2,max(40,magnitude*7.5),container,caller)
	return TRUE


/reagent_recipe/explosion/flashbang
	name = "Flashbang"
	category = "Explosions"
	required_reagents = list(
		/reagent/ammonia = 1,
		/reagent/nitrogen = 1,
		/reagent/fuel/hydrogen = 1
	)

	results = list()

/reagent_recipe/explosion/flashbang/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)

	var/turf/T = get_turf(container.owner)

	var/flash_range = min(2,magnitude/40)*VIEW_RANGE

	var/list/hearers = list()
	for(var/mob/living/L in view(flash_range,T))
		var/sound_mod = 0.25 + (1 - (get_dist(L,T)/VIEW_RANGE))*0.75
		var/duration = SECONDS_TO_DECISECONDS(10)*sound_mod
		L.flash(duration)
		L.bang(duration*2)
		hearers += L

	play_sound('sound/effects/flashbang.ogg',T,volume=75,range_min=flash_range*0.5,range_max=flash_range*2,channel=SOUND_CHANNEL_FLASHBANG)
	play_sound_global('sound/effects/flashring.ogg',hearers=hearers,volume=75,channel=SOUND_CHANNEL_FLASHBANG)

	return TRUE