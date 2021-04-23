/proc/smoke(var/turf/desired_turf,var/desired_power=20,var/desired_duration=100)
	if(!desired_turf)
		return FALSE
	var/obj/effect/temp/smoke/S = new(desired_turf,desired_duration,list())
	S.smoke_volume = desired_power
	return TRUE

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

/obj/effect/temp/smoke/Destroy()
	. = ..()
	blacklist_turfs.Cut()

/obj/effect/temp/smoke/New(var/desired_location,var/desired_time,var/list/desired_blacklist_turfs)
	. = ..()
	CALLBACK("fade_out_\ref[src]",duration-fade_time,src,.proc/fade_out)
	update_sprite()
	start_thinking(src)
	if(!desired_blacklist_turfs)
		blacklist_turfs = list()
	else
		blacklist_turfs = desired_blacklist_turfs

/obj/effect/temp/smoke/proc/fade_out()
	animate(src,alpha=0,time=fade_time)
	return TRUE

/obj/effect/temp/smoke/think()

	if(next_think > world.time)
		return TRUE

	if(!blacklist_turfs)
		return FALSE

	next_think = world.time + 4

	var/list/initial_possible_directions = list(NORTH,EAST,SOUTH,WEST)
	var/list/possible_turfs = list()

	for(var/k in initial_possible_directions)
		var/turf/T = get_step(src,k)
		if(blacklist_turfs[T] || !T.Enter(src,src.loc))
			blacklist_turfs[T] = TRUE
		else
			possible_turfs += T

	var/max_i = min(smoke_volume,rand(3,4),length(possible_turfs))

	if(!max_i)
		return FALSE

	for(var/i=1,i<=max_i,i++)
		var/turf/T = pick(possible_turfs)
		possible_turfs -= T
		var/obj/effect/temp/smoke/S = new(T,duration,blacklist_turfs)
		blacklist_turfs[T] = TRUE
		S.smoke_volume = FLOOR(smoke_volume/2,1)
		smoke_volume--

	if(smoke_volume <= 0)
		return FALSE

/obj/effect/temp/smoke/update_sprite()
	. = ..()

	icon_state = "none"

	var/icon/I = new/icon(initial(icon),"white")

	filters += filter(type="alpha",icon = I,x=80 - TILE_SIZE*0.5,y=80 - TILE_SIZE*0.5)

	var/matrix/M = matrix()
	M.Translate(-(160 - TILE_SIZE)*0.5,-(160 - TILE_SIZE)*0.5)
	transform = M

	animate(src,pixel_x=rand(-16,16),pixel_y=rand(-16,16),loop=1,time=20)
	var/duration_left=duration
	while(duration_left>0)
		var/time_to_take = min(duration_left,rand(10,20))
		animate(pixel_x=rand(-16,16),pixel_y=rand(-16,16),time=time_to_take)
		duration_left -= time_to_take


/obj/effect/temp/smoke/update_overlays()
	. = ..()
	var/spread_distance = TILE_SIZE
	var/image/I = new/image(initial(icon),"layer_[rand(1,3)]")
	I.pixel_x = rand(-spread_distance,spread_distance)
	I.pixel_y = rand(-spread_distance,spread_distance)
	add_overlay(I)
