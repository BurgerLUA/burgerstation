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

/obj/structure/interactive/coin_drop/PreDestroy()
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

/obj/structure/interactive/coin_drop/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(!caller || !caller.client)
		INTERACT_DELAY(3)
		return TRUE

	if(!(caller.client.ckey in valid_ckeys))
		INTERACT_DELAY(3)
		return TRUE

	var/obj/item/currency/gold_coin/GC = object

	if(!istype(GC))
		GC = null
		if(!is_inventory(object))
			INTERACT_DELAY(3) //Don't bother.
			return TRUE

	var/turf/T = get_turf(src)

	var/pickup_limit = GOLD_AMOUNT_MAX*0.1 //100
	if(GC)
		pickup_limit = min(pickup_limit,GC.amount_max - GC.amount)

	if(pickup_limit <= 0)
		INTERACT_DELAY(3) //Don't bother.
		caller.to_chat(span("warning","You can't carry any more gold!"))
		return FALSE

	var/pickup_amount = 0
	for(var/obj/structure/interactive/coin_drop/CD in T.contents)
		if(!CD.valid_ckeys[caller.client.ckey])
			continue
		if(pickup_amount + CD.amount >= pickup_limit)
			break
		pickup_amount += CD.amount
		CD.valid_ckeys -= caller.client.ckey
		caller.client.images -= CD.cached_coin
		caller.client.images -= CD.cached_sparkle
		if(length(CD.valid_ckeys) <= 0)
			qdel(CD)
	if(pickup_amount <= 0) //This shouldn't happen, but this is just in case.
		return TRUE

	var/obj/item/currency/gold_coin/G = new(T)
	INITIALIZE(G)
	G.amount = pickup_amount
	SSeconomy.gold_in_circulation += pickup_amount
	FINALIZE(G)
	object.click_on_object(caller,G,location,control,params) //Either an inventory or a gold coin.
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

	CALLBACK("\ref[src]_update_sprite",desired_time,src,src::finish_fly())

	return TRUE

/obj/structure/interactive/coin_drop/proc/finish_fly()
	play_sound(pick('sound/effects/coin_01.ogg','sound/effects/coin_02.ogg','sound/effects/coin_03.ogg'),get_turf(src))
	falling = FALSE
	update_sprite()
	return TRUE

/proc/create_gold_drop(var/turf/T,var/amount=5,var/list/valid_ckeys)

	amount = min(amount,GOLD_DROP_AMOUNT_MAX) //Enforce a limit, just in case.

	if(!length(valid_ckeys))
		valid_ckeys = list()
		for(var/k in all_players)
			var/mob/living/advanced/player/P = k
			if(get_dist(P,T) > BOSS_RANGE)
				continue
			if(!P.client)
				continue
			valid_ckeys[P.client.ckey] = TRUE

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
		G.amount = min(
			amount,
			rand(
				min(
					CEILING( (amount/GOLD_DROP_AMOUNT_MAX) * 2,1),
					5
				),
				5
			)
		)
		amount -= G.amount
		G.valid_ckeys = valid_ckeys.Copy()
		INITIALIZE(G)
		FINALIZE(G)
		G.fly(T)
		sleep(1)