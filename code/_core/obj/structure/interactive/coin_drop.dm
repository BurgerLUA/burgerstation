/obj/structure/interactive/coin_drop
	name = "gold coin"
	icon = 'icons/obj/item/currency/gold.dmi'
	icon_state = "1"
	value = 0 //Value is based on current economy.

	plane = PLANE_CURRENCY

	anchored = TRUE

	var/amount = 1

	var/list/valid_ckeys = list()

	var/image/cached_coin
	var/image/cached_sparkle

	var/falling = FALSE

/obj/structure/interactive/coin_drop/get_examine_list(var/mob/examiner)
	. = ..()
	if(amount > 1) . += div("weightsize","Quantity: [amount].")

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
	. = ..()

/obj/structure/interactive/coin_drop/proc/get_pickup_amount(var/mob/caller,var/loop_turf=TRUE)
	. = amount
	if(loop_turf)
		for(var/obj/structure/interactive/coin_drop/CD in loc.contents)
			if(CD == src)
				continue
			if(!(caller.client.ckey in CD.valid_ckeys))
				continue
			. += CD.get_pickup_amount(caller,FALSE)
			if(. >= 100) //100 at a time only.
				break

/obj/structure/interactive/coin_drop/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(!caller || !caller.client)
		INTERACT_DELAY(3)
		return TRUE

	if(!(caller.client.ckey in valid_ckeys))
		INTERACT_DELAY(3)
		return TRUE

	if(!istype(object,/obj/item/currency/gold_coin/) && !is_inventory(object))
		INTERACT_DELAY(3)
		return TRUE

	var/pickup_amount =	get_pickup_amount(caller,TRUE)
	pickup_amount = min(pickup_amount,100)
	if(pickup_amount <= 0)
		return TRUE
	var/obj/item/currency/gold_coin/G = new(get_turf(src))
	INITIALIZE(G)
	G.amount = pickup_amount
	SSeconomy.gold_in_circulation += pickup_amount
	FINALIZE(G)
	G.pixel_x = src.pixel_x
	G.pixel_y = src.pixel_y
	object.click_on_object(caller,G,location,control,params)
	valid_ckeys -= caller.client.ckey
	caller.client.images -= cached_coin
	caller.client.images -= cached_sparkle
	if(length(valid_ckeys) <= 0)
		qdel(src)
	return TRUE

/obj/structure/interactive/coin_drop/update_sprite()

	. = ..()

	var/image/new_coin = new/image(icon,icon_state)
	new_coin.appearance = appearance
	new_coin.loc = src

	var/image/new_sparkle
	if(!falling)
		new_sparkle = new/image(icon,"sparkle_fall_[clamp(amount,1,5)]")
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
		icon_state = "[clamp(amount,1,5)]_anim"
	else
		icon_state = "[clamp(amount,1,5)]_fall"

/obj/structure/interactive/coin_drop/proc/fly(var/turf/from_turf)

	if(amount > 5)
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

	amount = min(amount,100) //Enforce a limit, just in case.

	var/list/valid_ckeys = list()
	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		if(!P.client) //Inactive players don't get anything.
			continue
		if(get_dist(P,T) > BOSS_RANGE)
			continue
		valid_ckeys |= P.client.ckey

	var/list/valid_turfs = list()

	for(var/d in DIRECTIONS_ALL)
		var/turf/T2 = get_step(T,d)
		if(!T2)
			continue
		if(T2.density)
			continue
		valid_turfs += T2

	if(!length(valid_turfs))
		valid_turfs += T

	spawn while(amount>0)
		var/obj/structure/interactive/coin_drop/G = new(pick(valid_turfs))
		G.pixel_x = rand(-4,4)
		G.pixel_y = rand(-4,4)
		var/desired_value = rand(CEILING(amount/20,1),CEILING(amount/10,1))
		desired_value = max(desired_value,rand(3,5))
		desired_value = min(desired_value,amount)
		G.amount = desired_value
		amount -= G.amount
		G.valid_ckeys = valid_ckeys.Copy()
		INITIALIZE(G)
		FINALIZE(G)
		G.fly(T)
		sleep(1)