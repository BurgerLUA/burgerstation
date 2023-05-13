/*
TOO LAGGY FOR PARTICLES.
RIP PLANS.
/particles/fire
	width = TILE_SIZE*2
	height = TILE_SIZE*2
	count = 20
	spawning = 1
	bound1 = list(-TILE_SIZE*2,-TILE_SIZE*2,-TILE_SIZE*2)
	bound2 = list(TILE_SIZE*2,TILE_SIZE*2,TILE_SIZE*2)
	icon = 'icons/particle/fire_floor.dmi'
	icon_state = list("1"=1,"2"=1,"3"=1,"4"=1,"5"=1)
	gravity = list(0,0.5)
	gradient = list(0,"#FFF6BE",0.2,"#FABA5F",0.3,"#FF9D20",0.4,"#DB680B",0.6,"#DB680B",0.8,"7F7F7F",1,"#777777")

	lifespan = 20
	fade = 5
	fadein = 2
	color = 0
	color_change = 0.1
	position = generator("box",list(-TILE_SIZE*0.5,-TILE_SIZE*0.5,0),list(TILE_SIZE*0.5,TILE_SIZE*0.5,0))
	scale = list(0.5,0.5)
	grow = list(0.2,0.2)
	friction = 0.1
*/

/obj/fire_process

	icon = 'icons/obj/effects/fire_turf.dmi'
	icon_state = "fire_3"

	var/fire_power = 0
	var/initial_fire_power = 0

	var/momentum = 0x0

	var/loyalty_tag

	var/multiplier = 1

	var/atom/owner

	collision_flags = FLAG_COLLISION_CRAWLING

	damage_type = /damagetype/fire_turf

	density = TRUE

	hazardous = TRUE

	mouse_opacity = 0

	pixel_x = -8
	pixel_y = -8

/obj/fire_process/proc/do_damage(var/atom/movable/victim,var/distance_check=0)

	if(!victim || !victim.z || !src.z || victim.z != src.z)
		return FALSE

	if(multiplier <= 0)
		return FALSE

	if(CALLBACK_EXISTS("\ref[victim]_do_fire_ground_damage"))
		return FALSE

	if(distance_check <= 0)
		if(victim.loc != src.loc)
			return FALSE
	else
		if(get_dist(victim,src) > distance_check)
			return FALSE

	var/damagetype/DT = all_damage_types[damage_type]
	var/list/params = get_params()
	if(!victim.can_be_attacked(owner,src,params,DT))
		return FALSE
	var/atom/object_to_damage = victim.get_object_to_damage(owner,src,damage_type,params,TRUE,TRUE)

	var/list/returning_damage = DT.process_damage(owner,victim,src,object_to_damage,owner,multiplier)

	if(returning_damage && returning_damage[1] > 0)
		var/expected_damage = DT.get_damage_per_hit()*multiplier
		fire_power += min(5,1*(returning_damage[1]/expected_damage))

	CALLBACK("\ref[victim]_do_fire_ground_damage",10,src,src::do_damage(),victim) //Check again in 10 seconds.

/obj/fire_process/Crossed(atom/movable/O)
	. = ..()
	if(O.health) do_damage(O)

/obj/fire_process/Finalize()
	. = ..()
	SSexplosion.active_fires += src
	if(loc)
		for(var/k in loc.contents)
			var/atom/movable/M = k
			if(M == src)
				continue
			if(M.health) do_damage(k)

	set_light(3, 0.5, "#FF8C77",LIGHT_OMNI)

/obj/fire_process/Destroy()

	. = ..()

/obj/fire_process/proc/do_delete()
	qdel(src)
	return TRUE

/obj/fire_process/proc/process()

	if(!loc || fire_power <= 0)
		multiplier = 0
		SSexplosion.active_fires -= src
		animate(src,alpha=0,time=10)
		CALLBACK("fire_delete_\ref[src]",10,src,src::do_delete())
		return FALSE

	fire_power = min(fire_power,300) //Limit of 30 seconds.

	fire_power -= 0.1*0.5 //10% of a tile per explosion process tick.

	var/desired_alpha = min(100 + (fire_power/20)*(255-100),255)
	animate(src,alpha=desired_alpha,time=0.5)

	switch(fire_power)
		if(0 to 40)
			icon_state = "fire_1"
		if(40 to 80)
			icon_state = "fire_2"
		if(80 to INFINITY)
			icon_state = "fire_3"

	var/light_power = min(8,fire_power/20)

	set_light_sprite(light_power,light_power, "#A8916A",LIGHT_OMNI)

	if(fire_power < 40) //Don't spread if we don't have enough fuel to spread.
		momentum = NORTH | EAST | SOUTH | WEST //Reset momentum.
		return FALSE

	if(!momentum)
		return TRUE

	var/turf/current_turf = loc

	for(var/d in DIRECTIONS_ALL)

		if(!(d & momentum))
			continue

		var/turf/T = get_step(current_turf,d)
		if(!T)
			continue

		if(T.density && !T.Enter(src,src.loc))
			if(T.health) do_damage(T,1)
			momentum &= ~d
			return TRUE

		if(T.has_dense_atom)
			var/should_return = FALSE
			for(var/k in T.contents)
				var/atom/movable/M = k
				if(M.density && !M.Cross(src,current_turf))
					momentum &= ~d
					should_return = TRUE
					if(M.health) do_damage(M,1)
			if(should_return)
				return TRUE

		var/obj/fire_process/FP = locate() in T.contents
		if(!FP || FP.loyalty_tag != src.loyalty_tag)
			FP = new(T)
			FP.initial_fire_power = src.initial_fire_power
			FP.fire_power = src.fire_power - 10
			FP.momentum = d
			FP.multiplier = src.multiplier
			FP.loyalty_tag = src.loyalty_tag
			FP.owner = src.owner
			INITIALIZE(FP)
			FINALIZE(FP)
			var/list/directional_offset = direction_to_pixel_offset(d)
			FP.pixel_x = -directional_offset[1]*TILE_SIZE
			FP.pixel_y = -directional_offset[2]*TILE_SIZE
			animate(FP,pixel_x = initial(pixel_x),pixel_y = initial(pixel_y), time = 0.5)
		else
			FP.fire_power = max(FP.fire_power,src.fire_power - 10)
			FP.momentum = FP.momentum & momentum
			FP.multiplier = (FP.multiplier + src.multiplier) / 2

	momentum = 0x0

	return TRUE


/obj/fire_process/proc/get_params(var/atom/victim)
	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0,8)