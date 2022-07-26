/proc/smoke(var/turf/desired_turf,var/desired_power=20,var/desired_duration=100,var/reagent_container/container,var/mob/owner,var/alpha=255)
	if(!desired_turf)
		return FALSE
	var/reagent_container/temp/smoke/T
	if(container)
		T = new(null,1000)
		T.owner = owner
		container.transfer_reagents_to(T,container.volume_current,caller=owner) //Transfer everything to this temp container.

	var/list/blacklist_turfs = list(T=TRUE)
	. = new/obj/effect/temp/smoke(desired_turf,desired_duration,blacklist_turfs,T,owner,desired_power,alpha)

/obj/effect/temp/smoke
	name = "smoke"
	mouse_opacity = 1
	icon = 'icons/obj/effects/smoke.dmi'
	icon_state = "layer_1"
	duration = SECONDS_TO_DECISECONDS(30)
	var/fade_time = SECONDS_TO_DECISECONDS(3)
	appearance_flags = PIXEL_SCALE | LONG_GLIDE | KEEP_TOGETHER

	var/smoke_volume = 20//in tiles. Not a width. If you want a rough width, get your volume and divide by 4.
	var/smoke_volume_original = 0
	var/reagent_volume_original = 0

	var/next_think = 0

	var/list/blacklist_turfs

	var/reagent_container/temp/smoke/container

	var/mob/owner

	density = TRUE

/obj/effect/temp/smoke/Destroy()
	. = ..()
	blacklist_turfs?.Cut()
	owner = null
	if(container)
		container.linked_smoke -= src
		if(!container.qdeleting && length(container.linked_smoke) <= 0)
			qdel(container) //delete the smoke container if there is no smoke left to spread it, as long as it hasn't been deleted already for having no reagents left.
		container = null

/obj/effect/temp/smoke/proc/try_splash(var/atom/A)
	if(container && container.volume_current > 0 && (A.reagents || isturf(A)))
		var/amount_to_actually_splash = max(1,reagent_volume_original/max(1,smoke_volume_original)) * 0.2
		container.splash(owner,A,amount_to_actually_splash,FALSE,5)
	return TRUE

/obj/effect/temp/smoke/Crossed(var/atom/movable/O)
	. = ..()
	if(O.density && O.reagents) try_splash(O)

/obj/effect/temp/smoke/New(var/desired_location,var/desired_time,var/list/desired_blacklist_turfs,var/reagent_container/desired_container,var/mob/desired_owner,var/desired_volume=20,var/desired_alpha=255,var/original_smoke_volume,var/original_reagent_volume)
	. = ..()

	CALLBACK("fade_out_\ref[src]",duration-fade_time,src,.proc/fade_out)

	container = desired_container
	if(isnum(desired_volume))
		smoke_volume = desired_volume

	if(isnum(original_reagent_volume))
		reagent_volume_original = original_reagent_volume
	else if(container)
		reagent_volume_original = container.volume_current

	if(isnum(original_smoke_volume))
		smoke_volume_original = original_smoke_volume
	else
		smoke_volume_original = smoke_volume

	blacklist_turfs = desired_blacklist_turfs
	alpha = desired_alpha
	if(alpha >= 255)
		opacity = TRUE
	update_sprite()

	try_splash(loc)

	spread()

/obj/effect/temp/smoke/proc/fade_out()
	var/matrix/M = get_base_transform()
	animate(src,transform=M,alpha=0,time=min(fade_time,duration*0.5))
	return TRUE

/obj/effect/temp/smoke/proc/spread()

	var/list/initial_possible_directions = DIRECTIONS_CARDINAL
	var/list/possible_turfs = list()

	for(var/k in initial_possible_directions)
		var/turf/T = get_step(src,k)
		if(blacklist_turfs[T])
			continue
		if(!T.Enter(src,src.loc))
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

	if(max_i)
		for(var/i=1,i<=max_i,i++)
			var/turf/T = pick(possible_turfs)
			possible_turfs -= T
			new /obj/effect/temp/smoke(T,duration,blacklist_turfs,container,owner,FLOOR(smoke_volume/2,1),alpha,smoke_volume_original,reagent_volume_original)
			blacklist_turfs[T] = TRUE
			smoke_volume--
	else
		smoke_volume--

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
		alpha = min(255,container.alpha) - 1
		if(alpha >= 255)
			opacity = TRUE


/obj/effect/temp/smoke/update_overlays()
	. = ..()
	var/spread_distance = TILE_SIZE
	var/image/I = new/image(initial(icon),"layer_[rand(1,3)]")
	I.pixel_x = rand(-spread_distance,spread_distance)
	I.pixel_y = rand(-spread_distance,spread_distance)
	add_overlay(I)
