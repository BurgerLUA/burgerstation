/proc/smoke(var/turf/desired_turf,var/desired_power=20,var/desired_duration=100,var/reagent_container/container,var/mob/owner,var/alpha=255)
	if(!desired_turf)
		return FALSE
	var/reagent_container/temp/T
	if(container)
		T = new(src,1000)
		T.owner = owner
		container.transfer_reagents_to(T,container.volume_current,caller=owner)
		queue_delete(T,desired_duration)

	var/obj/effect/temp/smoke/S = new(desired_turf,desired_duration,list(),T,owner,desired_power,alpha)
	return S

/obj/effect/temp/smoke
	name = "smoke"
	mouse_opacity = 1
	icon = 'icons/obj/effects/smoke.dmi'
	icon_state = "layer_1"
	duration = SECONDS_TO_DECISECONDS(30)
	var/fade_time = SECONDS_TO_DECISECONDS(3)
	appearance_flags = KEEP_TOGETHER | PIXEL_SCALE

	var/smoke_volume = 20//in tiles. Not a width. If you want a rough width, get your width and multiply by 4.

	var/next_think = 0

	var/list/blacklist_turfs

	var/reagent_container/container

	var/mob/owner

	density = TRUE

/obj/effect/temp/smoke/Destroy()
	. = ..()
	blacklist_turfs?.Cut()

/obj/effect/temp/smoke/proc/try_splash(var/atom/A)
	if(container && container.volume_current > 0 && (A.reagents || isturf(A)))
		container.splash(owner,A,1,FALSE,5) //I mean it's pulling shit out of nothing but whatever.

/obj/effect/temp/smoke/Crossed(var/atom/movable/O)
	. = ..()
	try_splash(O)

/obj/effect/temp/smoke/New(var/desired_location,var/desired_time,var/list/desired_blacklist_turfs,var/reagent_container/desired_container,var/mob/desired_owner,var/desired_volume=20,var/desired_alpha=255)
	. = ..()
	CALLBACK("fade_out_\ref[src]",duration-fade_time,src,.proc/fade_out)
	container = desired_container
	if(isnum(desired_volume))
		smoke_volume = desired_volume
	update_sprite()
	start_thinking(src)
	if(!desired_blacklist_turfs)
		blacklist_turfs = list()
	else
		blacklist_turfs = desired_blacklist_turfs
	if(desired_location)
		try_splash(desired_location)
	alpha = desired_alpha
	if(alpha >= 255)
		opacity = TRUE

/obj/effect/temp/smoke/proc/fade_out()
	animate(src,alpha=0,time=fade_time)
	return TRUE

/obj/effect/temp/smoke/think()

	if(next_think > world.time)
		return TRUE

	if(!blacklist_turfs)
		return FALSE

	next_think = world.time + 10

	var/list/initial_possible_directions = list(NORTH,EAST,SOUTH,WEST)
	var/list/possible_turfs = list()

	for(var/k in initial_possible_directions)
		var/turf/T = get_step(src,k)
		if(blacklist_turfs[T] || !T.Enter(src,src.loc))
			blacklist_turfs[T] = TRUE
			continue
		var/should_fail = FALSE
		for(var/j in T.contents)
			if(!T.Crossed(src))
				should_fail = TRUE
				break
		if(should_fail)
			continue
		possible_turfs += T

	var/max_i = min(smoke_volume,rand(3,4),length(possible_turfs))

	if(!max_i)
		return FALSE

	for(var/i=1,i<=max_i,i++)
		var/turf/T = pick(possible_turfs)
		possible_turfs -= T
		new /obj/effect/temp/smoke(T,duration,blacklist_turfs,container,owner,FLOOR(smoke_volume/2,1))
		blacklist_turfs[T] = TRUE
		smoke_volume--

	if(smoke_volume <= 0)
		return FALSE

	var/turf/T = get_turf(src)
	try_splash(T)

/obj/effect/temp/smoke/get_base_transform()
	. = ..()
	var/matrix/M = .
	M.Translate(-(160 - TILE_SIZE)*0.5,-(160 - TILE_SIZE)*0.5)

/obj/effect/temp/smoke/update_sprite()
	. = ..()

	icon_state = "none"

	var/icon/I = new/icon(initial(icon),"white")

	filters += filter(type="alpha",icon = I,x=80 - TILE_SIZE*0.5,y=80 - TILE_SIZE*0.5)

	transform = get_base_transform()

	animate(src,pixel_x=rand(-16,16),pixel_y=rand(-16,16),loop=1,time=20)
	var/duration_left=duration
	while(duration_left>0)
		var/time_to_take = min(duration_left,rand(10,20))
		animate(pixel_x=rand(-16,16),pixel_y=rand(-16,16),time=time_to_take)
		duration_left -= time_to_take

	if(container)
		color = container.color
		alpha = container.alpha


/obj/effect/temp/smoke/update_overlays()
	. = ..()
	var/spread_distance = TILE_SIZE
	var/image/I = new/image(initial(icon),"layer_[rand(1,3)]")
	I.pixel_x = rand(-spread_distance,spread_distance)
	I.pixel_y = rand(-spread_distance,spread_distance)
	add_overlay(I)
