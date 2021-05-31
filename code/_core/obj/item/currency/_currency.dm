/obj/item/currency/
	name = "currency"
	desc = "DOSH"
	desc_extended = "Grab it while it's hot!"

	item_count_current = 1
	item_count_max = 5000

	size = 0.002
	weight = 0.002

	var/currency_class = "none"

	value_burgerbux = 1 //Prevents being sold in vendors.

	glide_size = 1

/obj/item/currency/can_transfer_stacks_to(var/obj/item/I)

	if(I != src && istype(I,/obj/item/currency/))
		var/obj/item/currency/C = I
		return C.currency_class == src.currency_class

	return FALSE

/obj/item/currency/Finalize()
	. = ..()
	update_sprite()

/obj/item/currency/telecrystals
	name = "telecrystals"
	desc = "These are pretty sus crystals."
	desc_extended = "Currency primarily used by syndicate operatives."
	icon = 'icons/obj/item/currency/telecrystals.dmi'
	icon_state = "1"
	value = 200

	currency_class = "Telecrystals"

/obj/item/currency/telecrystals/goblin/Generate()
	item_count_current = pick(1,1,1,1,1,1,2,2,3,3,4,5)
	return ..()

/obj/item/currency/telecrystals/treasure/Generate()
	item_count_current = pick(1,1,1,1,1,1,2,2,3,3,4,5)*5

/obj/item/currency/telecrystals/player_antagonist_spawn/Generate()
	item_count_current = 50
	return ..()

/obj/item/currency/telecrystals/update_icon()
	switch(item_count_current)
		if(1 to 10)
			icon_state = "[item_count_current]"
		if(11 to 100)
			icon_state = "[FLOOR(item_count_current/10, 1)*10]"
		if(101 to 1000)
			icon_state = "[FLOOR(item_count_current/100, 1)*100]"
		if(1001 to 5000)
			icon_state = "[FLOOR(value/1000, 1)*1000]"
	return ..()

/obj/item/currency/prize_ticket
	name = "prize ticket"
	desc = "What, another useless currency? Isn't burgerbux enough???"
	desc_extended = "A prize ticket that can be redeemed at a prize vendor. Earned by completing minigames in arcade vendors."
	icon = 'icons/obj/item/currency/ticket.dmi'
	icon_state = "1"
	value = 0.25

	currency_class = "Prize Ticket"

/obj/item/currency/prize_ticket/update_icon()
	switch(item_count_current)
		if(1)
			icon_state = "1"
		if(2 to 10)
			icon_state = "2"
		if(11 to 50)
			icon_state = "3"
		if(51 to item_count_max)
			icon_state = "4"
	return ..()


/obj/item/currency/magic_token
	name = "magic shard token"
	desc = "Magically delicious!"
	desc_extended = "A special magic shard token that is commonly used to trade with the Wizard Federation. Used to buy magic items."
	icon = 'icons/obj/item/currency/magic_token.dmi'
	icon_state = "1"
	value = 800

	item_count_max = 4

	currency_class = "Magic Shard"

/obj/item/currency/magic_token/random/Generate()
	item_count_current = pick(1,1,1,1,1,1,1,1,2,2,2,3,3,4)
	return ..()

/obj/item/currency/magic_token/update_icon()
	icon_state = "[item_count_current]"
	return ..()

/obj/item/currency/magic_token/max/Generate()
	item_count_current = item_count_max


/obj/item/currency/gold
	name = "gold coin"
	icon = 'icons/obj/item/currency/gold.dmi'
	icon_state = "1"
	value = 0 //Value is based on current economy.

	item_count_max = 200

	size = SIZE_4/200
	weight = 50/200

	currency_class = "gold"

	drop_sound = null

	plane = PLANE_CURRENCY

	var/scattered = FALSE

/obj/item/currency/gold/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up or worn.

	if(isturf(old_location))
		var/turf/T = old_location
		for(var/obj/item/currency/gold/G in T.contents)
			if(G == src || G.qdeleting)
				continue
			G.transfer_item_count_to(src)

	. = ..()

/obj/item/currency/gold/Finalize()
	. = ..()
	if(generated)
		fly()

/obj/item/currency/gold/update_icon()
	. = ..()
	if(scattered)
		icon_state = "[clamp(item_count_current,1,5)]_fall"
	else
		switch(item_count_current)
			if(1 to 40)
				icon_state = "[item_count_current]"
			if(40 to 100)
				icon_state = "[FLOOR(item_count_current,10)]"
			if(100 to 200)
				icon_state = "[FLOOR(item_count_current,20)]"

/obj/item/currency/gold/update_overlays()

	. = ..()

	if(has_suffix(icon_state,"_anim"))
		return .

	var/desired_overlay

	if(scattered)
		desired_overlay = "sparkle_fall_[clamp(item_count_current,1,5)]"
	else if(item_count_current < 10)
		desired_overlay = "sparkle_1"
	else
		desired_overlay = "sparkle_[min(50,FLOOR(item_count_current,10))]"

	if(desired_overlay)
		var/image/I = new/image(icon,desired_overlay)
		add_overlay(I)


/obj/item/currency/gold/post_move(var/atom/old_loc)

	if(scattered && !isturf(loc))
		scattered = FALSE
		update_sprite()

	. = ..()

/obj/item/currency/gold/proc/fly(var/turf/from_turf)

	if(item_count_current > 5)
		return FALSE

	icon_state = "[clamp(item_count_current,1,5)]_anim"

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

/obj/item/currency/gold/proc/finish_fly()
	scattered = TRUE
	play_sound(pick('sound/effects/coin_01.ogg','sound/effects/coin_02.ogg','sound/effects/coin_03.ogg'),get_turf(src))
	update_sprite()
	return TRUE

/proc/create_gold_drop(var/turf/T,var/amount=5)

	spawn while(amount>0)
		var/obj/item/currency/gold/G = new(get_step(T,pick(DIRECTIONS_ALL)))
		G.pixel_x = rand(-4,4)
		G.pixel_y = rand(-4,4)
		G.item_count_current = min(amount,rand(min(5,CEILING(amount/10,1)),5))
		amount -= G.item_count_current
		G.fly(T)
		INITIALIZE(G)
		FINALIZE(G)