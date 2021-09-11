/obj/structure/interactive/coin_drop
	name = "gold coin"
	icon = 'icons/obj/item/currency/gold.dmi'
	icon_state = "1"
	value = 0 //Value is based on current economy.

	plane = PLANE_CURRENCY

	anchored = TRUE

	var/item_count_current = 1

	var/list/valid_ckeys = list()

	var/image/cached_coin
	var/image/cached_sparkle

	var/falling = FALSE

/obj/structure/interactive/coin_drop/get_examine_list(var/mob/examiner)
	. = ..()
	if(item_count_current > 1) . += div("weightsize","Quantity: [item_count_current].")

/obj/structure/interactive/coin_drop/Destroy()
	if(cached_coin || cached_sparkle)
		for(var/k in valid_ckeys)
			var/client/C = CLIENT(k)
			if(cached_coin)
				C -= cached_coin
			if(cached_sparkle)
				C -= cached_sparkle
		cached_coin = null
		cached_sparkle = null
	valid_ckeys?.Cut()
	. = ..()

/obj/structure/interactive/coin_drop/proc/get_pickup_amount(var/mob/caller,var/loop_turf=TRUE)
	. = item_count_current
	if(loop_turf)
		for(var/obj/structure/interactive/coin_drop/CD in loc.contents)
			if(CD == src)
				continue
			if(!(caller.client.ckey in CD.valid_ckeys))
				continue
			. += CD.get_pickup_amount(caller,FALSE)
			if(. >= 100) //100 at a time only.
				break
	valid_ckeys -= caller.client.ckey
	caller.client.images -= cached_coin
	caller.client.images -= cached_sparkle
	if(length(valid_ckeys) <= 0)
		queue_delete(src,10)

/obj/structure/interactive/coin_drop/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(3)

	if(!caller || !caller.client)
		return TRUE
	if(!(caller.client.ckey in valid_ckeys))
		return TRUE
	if(!istype(object,/obj/item/currency/gold_coin/) && !is_inventory(object))
		return TRUE

	var/pickup_amount =	get_pickup_amount(caller,TRUE)
	pickup_amount = min(pickup_amount,100)
	if(pickup_amount <=0)
		return TRUE
	var/obj/item/currency/gold_coin/G = new(get_turf(src))
	G.item_count_current = pickup_amount
	SSeconomy.gold_in_circulation += pickup_amount
	INITIALIZE(G)
	FINALIZE(G)
	G.pixel_x = pixel_x
	G.pixel_y = pixel_y
	object.click_on_object(caller,G,location,control,params)
	return TRUE

/obj/structure/interactive/coin_drop/update_sprite()

	. = ..()

	var/image/new_coin = new/image(icon,icon_state)
	new_coin.appearance = appearance
	new_coin.loc = src

	var/image/new_sparkle
	if(!falling)
		new_sparkle = new/image(icon,"sparkle_fall_[clamp(item_count_current,1,5)]")
		new_sparkle.appearance = appearance
		new_sparkle.loc = src
		new_sparkle.layer = layer + 0.1

	for(var/k in valid_ckeys)
		var/client/C = CLIENT(k)
		if(!C)
			continue
		if(cached_coin)
			C.images -= cached_coin
		if(cached_sparkle)
			C.images -= cached_sparkle
		C.images += new_coin
		if(new_sparkle)
			C.images += new_sparkle

	cached_sparkle = new_sparkle
	cached_coin = new_coin
	icon = null

/obj/structure/interactive/coin_drop/update_icon()
	. = ..()
	icon = initial(icon)
	if(falling)
		icon_state = "[clamp(item_count_current,1,5)]_anim"
	else
		icon_state = "[clamp(item_count_current,1,5)]_fall"

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

	var/list/valid_ckeys = list()
	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		if(!P.client)
			continue
		if(get_dist(P,T) > BOSS_RANGE)
			continue
		valid_ckeys |= P.client.ckey

	spawn while(amount>0)
		var/obj/structure/interactive/coin_drop/G = new(get_step(T,pick(DIRECTIONS_ALL)))
		G.pixel_x = rand(-4,4)
		G.pixel_y = rand(-4,4)
		G.item_count_current = min(amount,rand(min(5,CEILING(amount/10,1)),5))
		amount -= G.item_count_current
		G.valid_ckeys = valid_ckeys.Copy()
		INITIALIZE(G)
		FINALIZE(G)
		G.fly(T)
		sleep(1)