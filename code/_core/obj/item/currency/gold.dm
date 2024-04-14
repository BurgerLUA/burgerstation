//Coins
/obj/item/currency/gold_coin
	name = "gold coin"
	desc_extended = "Shiny gold coin, a currency often used by goblins. Its value is determined by the gold market."
	icon = 'icons/obj/item/currency/gold.dmi'
	icon_state = "1"
	value = 0 //Value is based on current economy, see get_base_value()

	amount_max = GOLD_AMOUNT_MAX

	size = 0.01
	weight = (35/GOLD_AMOUNT_MAX) * 5

	currency_class = "gold coin"

	drop_sound = null

	value = CREDITS_PER_GOLD

/obj/item/currency/gold_coin/update_sprite()
	. = ..()
	if(amount == 1)
		name = "1 gold coin"
	else
		name = "[amount] gold coins"

/obj/item/currency/gold_coin/update_icon()
	. = ..()
	switch(amount)
		if(1 to 40) //1 to 40, 1
			icon_state = "[FLOOR(amount,1)]"
		if(40 to 500) //40 to 100, 10
			// 40 + (i*(60/100))/5
			icon_state = "[40 + FLOOR((amount*(60/100))/5,10)]"
		if(500 to GOLD_AMOUNT_MAX) //100 to 200, 20
			icon_state = "[FLOOR(amount/5,20)]"

/obj/item/currency/gold_coin/update_overlays()

	. = ..()

	if(has_suffix(icon_state,"_anim"))
		return .

	var/desired_overlay
	if(amount < 10)
		desired_overlay = "sparkle_1"
	else
		desired_overlay = "sparkle_[min(50,FLOOR(amount,10))]"

	if(desired_overlay)
		var/image/I = new/image(icon,desired_overlay)
		add_overlay(I)



/obj/item/currency/gold_coin/proc/fly(var/turf/from_turf)

	if(amount > 5)
		return FALSE

	flick("[clamp(amount,1,5)]_anim",src)

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

/obj/item/currency/gold_coin/proc/finish_fly()
	play_sound(pick('sound/effects/coin_01.ogg','sound/effects/coin_02.ogg','sound/effects/coin_03.ogg'),get_turf(src))
	update_sprite()
	return TRUE


/proc/create_gold_drop(var/turf/T,var/amount=5)

	amount = min(amount,GOLD_DROP_AMOUNT_MAX) //Enforce a limit, just in case.

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
		var/obj/item/currency/gold_coin/G = new(pick(valid_turfs))
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
		INITIALIZE(G)
		FINALIZE(G)
		G.fly(T)
		sleep(1)







//Bars
/obj/item/currency/gold_bar
	name = "gold bar"
	desc = "We're rich!"
	desc_extended = "A bar of solid gold, likely valuable."
	icon = 'icons/obj/item/currency/gold_bar.dmi'
	icon_state = "1"

	amount_max = 5

	size = SIZE_1
	weight = 35 //Guess the reference
	value = CREDITS_PER_GOLD * GOLD_AMOUNT_MAX * (1/5) //Worth 1/5th of a full gold stack.

	currency_class = "gold bar"

	drop_sound = null

	rarity = RARITY_RARE

/obj/item/currency/gold_bar/update_sprite()
	. = ..()
	if(amount == 1)
		name = "1 gold bar"
	else
		name = "[amount] gold bars"

/obj/item/currency/gold_bar/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"sparkle_[amount]")
	add_overlay(I)

/obj/item/currency/gold_bar/update_icon()
	. = ..()
	icon_state = "[amount]"