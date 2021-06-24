/obj/structure/interactive/coin_drop
	name = "gold coin"
	icon = 'icons/obj/item/currency/gold.dmi'
	icon_state = "1"
	value = 0 //Value is based on current economy.

	plane = PLANE_CURRENCY

	anchored = TRUE

	var/item_count_current = 1

	var/list/valid_players = list()

	var/image/cached_image

	var/falling = FALSE

/obj/structure/interactive/coin_drop/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	if(!caller || !caller.client)
		return TRUE
	if(!(caller in valid_players))
		return TRUE
	var/obj/item/currency/gold/G = new(get_turf(src))
	G.item_count_current = item_count_current
	INITIALIZE(G)
	FINALIZE(G)
	G.pixel_x = pixel_x
	G.pixel_y= pixel_y
	valid_players -= caller
	caller.client.images -= cached_image
	object.click_on_object(caller,G,location,control,params)
	SSeconomy.gold_in_circulation += item_count_current
	if(length(valid_players) <= 0)
		qdel(src)
	return TRUE


/obj/structure/interactive/coin_drop/Destroy()
	. = ..()
	if(cached_image)
		for(var/k in valid_players)
			var/mob/M = k
			if(M.client)
				M.client -= cached_image
		cached_image = null
	valid_players.Cut()
	valid_players = null

/obj/structure/interactive/coin_drop/update_sprite()
	. = ..()
	var/image/new_image = new/image(icon,icon_state)
	new_image.appearance = appearance
	new_image.loc = src
	for(var/k in valid_players)
		var/mob/M = k
		if(!M.client)
			continue
		if(cached_image)
			M.client.images -= cached_image
		M.client.images += new_image
	cached_image = new_image
	icon = null

/obj/structure/interactive/coin_drop/update_icon()
	. = ..()
	icon = initial(icon)
	if(falling)
		icon_state = "[clamp(item_count_current,1,5)]_anim"
	else
		icon_state = "[clamp(item_count_current,1,5)]_fall"

/obj/structure/interactive/coin_drop/update_overlays()
	. = ..()
	if(!falling)
		var/image/I = new/image(icon,"sparkle_fall_[clamp(item_count_current,1,5)]")
		add_overlay(I)

/obj/structure/interactive/coin_drop/proc/fly(var/turf/from_turf)

	if(item_count_current > 5)
		return FALSE

	falling = TRUE
	update_sprite()

	var/desired_z = rand(16,32)

	var/desired_time = rand(6,8)

	var/list/offsets = direction_to_pixel_offset(get_dir(src,from_turf))
	pixel_x = offsets[1]*TILE_SIZE
	pixel_y = offsets[2]*TILE_SIZE

	var/desired_pixel_x = rand(-6,6)
	var/desired_pixel_y = rand(-6,6)

	animate(src,pixel_z=desired_z,time=desired_time*0.5,easing=QUAD_EASING|EASE_OUT,flags=ANIMATION_PARALLEL)
	animate(pixel_z=0,time=desired_time*0.5,easing=QUAD_EASING|EASE_IN)

	animate(src,pixel_x = desired_pixel_x, pixel_y = desired_pixel_y,time=desired_time,flags=ANIMATION_PARALLEL)

	CALLBACK("\ref[src]_update_sprite",desired_time,src,.proc/finish_fly)

	return TRUE

/obj/structure/interactive/coin_drop/proc/finish_fly()
	play_sound(pick('sound/effects/coin_01.ogg','sound/effects/coin_02.ogg','sound/effects/coin_03.ogg'),get_turf(src))
	falling = FALSE
	update_sprite()
	return TRUE

/proc/create_gold_drop(var/turf/T,var/amount=5)

	amount = min(amount,100)

	var/list/valid_players = list()
	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		if(get_dist(P,T) > BOSS_RANGE)
			continue
		valid_players |= P

	spawn while(amount>0)
		var/obj/structure/interactive/coin_drop/G = new(get_step(T,pick(DIRECTIONS_ALL)))
		G.pixel_x = rand(-4,4)
		G.pixel_y = rand(-4,4)
		G.item_count_current = min(amount,rand(min(5,CEILING(amount/10,1)),5))
		amount -= G.item_count_current
		G.valid_players = valid_players.Copy()
		INITIALIZE(G)
		FINALIZE(G)
		G.fly(T)
		sleep(1)