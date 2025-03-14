/mob/living/advanced/proc/add_sell_buttons()
	var/list/valid_buttons = subtypesof(/obj/hud/button/exchange/)
	for(var/k in valid_buttons)
		var/obj/hud/button/exchange/E = new k
		E.update_owner(src)
	HOOK_ADD("post_move","remove_sell_buttons_\ref[src]",src,src,src::remove_sell_buttons())
	return TRUE

/mob/living/advanced/proc/remove_sell_buttons()
	for(var/obj/hud/button/exchange/E in buttons)
		E.update_owner(null)
	HOOK_REMOVE("post_move","remove_sell_buttons_\ref[src]",src)
	return TRUE

/obj/hud/button/exchange/
	plane = PLANE_HUD
	layer = LAYER_HUD+100

/obj/hud/button/exchange/sell
	name = "sell"
	desc_extended = "Clicking here will sell the currently slotted object for currency. Items sold cannot be recovered."

	icon = 'icons/hud/hud.dmi'
	icon_state = "sell"

	screen_loc = "CENTER+1,CENTER-1"

/obj/hud/button/exchange/sell/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)
	. = ..()

	if(is_player(activator))
		var/mob/living/advanced/player/A = activator
		var/obj/hud/button/exchange/base/B = locate() in A.buttons
		if(B)
			var/obj/item/I = B.stored_object
			if(I && !I.qdeleting && get_dist(I,A) <= 1)
				B.calculate_value()
				if(B.stored_value <= 0)
					activator.to_chat(span("warning","\The [I.name] cannot be sold!"))
				else
					if(istype(B.stored_object,/obj/item/currency/gold_coin))
						var/currency_added = A.adjust_currency(B.stored_value)
						A.to_chat(span("notice","You exchange \the [B.stored_object] for [currency_added] credits."))
						B.set_stored_object(null)
						qdel(I)
					else
						var/turf/T = get_step(A,A.dir)
						if(!T)
							T = get_turf(A)
						var/obj/item/currency/gold_coin/G = new(T)
						INITIALIZE(G)
						G.amount = B.stored_value
						FINALIZE(G)
						A.to_chat(span("notice","You sell \the [B.stored_object] for [G.amount] gold."))
						B.set_stored_object(null)
						qdel(I)
						if(!G.qdeleting && is_item(object) && G.can_transfer_stacks_to(object))
							G.transfer_amount_to(object)
						if(!G.qdeleting && !A.put_in_hands(G,params))
							G.quick_equip(A,ignore_worn=TRUE,ignore_dynamic=TRUE)
			else
				B.set_stored_object(null)

/obj/hud/button/exchange/close
	name = "close"

	icon = 'icons/hud/hud.dmi'
	icon_state = "close_sell"

	screen_loc = "CENTER+3,CENTER"

/obj/hud/button/exchange/close/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(is_advanced(activator))
		var/mob/living/advanced/A = activator
		A.remove_sell_buttons()

/obj/hud/button/exchange/base
	name = "exchange"

	icon = 'icons/hud/exchange.dmi'
	icon_state = "exchange"

	var/obj/item/stored_object
	var/stored_value = 0

	maptext_width = 96
	maptext_height = 40
	maptext_x = 70
	maptext_y = 16

	screen_loc = "CENTER,CENTER"

/obj/hud/button/exchange/base/update_owner(var/mob/desired_owner)
	set_stored_object(null)
	. = ..()

/obj/hud/button/exchange/base/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	if(stored_object)
		set_stored_object(null)

	DEFER_OBJECT

	if(is_item(defer_object)) //Put the item in this inventory slot.
		set_stored_object(defer_object)
		HOOK_ADD("post_move","stored_object_post_move_\ref[src]",stored_object,src,src::stored_object_post_move())
		return TRUE

	. = ..()

/obj/hud/button/exchange/base/dropped_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	DEFER_OBJECT

	if(is_item(defer_object)) //Put the item in this inventory slot.
		set_stored_object(defer_object)
		HOOK_ADD("post_move","stored_object_post_move_\ref[src]",stored_object,src,src::stored_object_post_move())
		return TRUE

	. = ..()

/obj/hud/button/exchange/base/proc/stored_object_post_move(var/atom/movable/M)
	HOOK_REMOVE("post_move","stored_object_post_move_\ref[src]",M)
	if(M == stored_object)
		set_stored_object(null)
	return TRUE

/obj/hud/button/exchange/base/proc/set_stored_object(var/obj/item/I)
	stored_object = I
	calculate_value()
	update_sprite()
	return TRUE

/obj/hud/button/exchange/base/proc/calculate_value()
	if(stored_object)
		if(istype(stored_object,/obj/item/currency/gold_coin))
			stored_value = CEILING(stored_object.amount*CREDITS_PER_GOLD,1)
			stored_value = max(stored_value,0)
		else
			stored_value = CEILING((SELL_MULTIPLIER*stored_object.get_value())/CREDITS_PER_GOLD,1)
			stored_value = clamp(stored_value,0,1000)
	else
		stored_value = 0

/obj/hud/button/exchange/base/update_overlays()
	. = ..()
	if(stored_object)
		var/image/I = new/image(stored_object.icon,stored_object.icon_state)
		I.appearance = stored_object.appearance
		I.plane = FLOAT_PLANE
		I.layer = FLOAT_LAYER
		I.pixel_x = 4
		I.pixel_y = 0
		add_overlay(I)

/obj/hud/button/exchange/base/update_sprite()
	. = ..()
	if(stored_object)
		name = stored_object.name
		desc = stored_object.desc
		desc_extended = stored_object.desc_extended
		if(istype(stored_object,/obj/item/currency/gold_coin))
			maptext = "[nice_number(stored_value)] cr"
		else
			maptext = "[nice_number(stored_value)] g"
		maptext_x = 70
		maptext_y = 16
	else
		name = initial(name)
		desc = initial(desc)
		desc_extended = initial(desc_extended)
		maptext = "Click and drag an item here."
		maptext_x = 5
		maptext_y = 16

	tooltip_text = initial(tooltip_text)
	if(!tooltip_text)
		tooltip_text = generate_tooltip_text()
