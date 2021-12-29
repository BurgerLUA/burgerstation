/obj/structure/interactive/fulton
	name = "fulton"
	desc = "oh no"
	desc_extended = "Better save them quick."

	icon = 'icons/obj/effects/fulton.dmi'
	icon_state = "none"

	plane = PLANE_EFFECT
	layer = 100

	var/mob/owner
	var/atom/movable/stored_movable

	pixel_y = 16

	mouse_opacity = 1

/obj/structure/interactive/fulton/Destroy()

	if(stored_movable)
		if(loc)
			stored_movable.force_move(get_turf(loc))
		else
			qdel(stored_movable)
		stored_movable = null

	owner = null

	. = ..()

/obj/structure/interactive/fulton/proc/do_invalid_fulton()

	stored_movable.force_move(get_turf(src))

	if(is_living(stored_movable))
		var/mob/living/L = stored_movable
		L.add_status_effect(STUN,30,30)

	visible_message(span("danger","\The [src.name] fails to extract \the [stored_movable.name]!"))

	stored_movable = null
	qdel(src)

	return TRUE



/obj/structure/interactive/fulton/proc/fly_away()
	visible_message(span("danger","\The [src.name] flies up in the air, bringing \the [stored_movable.name] with it!"))
	play_sound('sound/effects/fultext_launch.ogg',get_turf(src))
	animate(src,pixel_z = TILE_SIZE*VIEW_RANGE,alpha=0,color="#000000",time=SECONDS_TO_DECISECONDS(1),easing=BACK_EASING | EASE_IN)
	CALLBACK("\ref[src]_sell",SECONDS_TO_DECISECONDS(2),src,.proc/sell_stored)
	return TRUE

/obj/structure/interactive/fulton/proc/sell_stored()

	. = 0

	if(!stored_movable)
		qdel(src)
		return

	if(is_living(stored_movable))
		var/mob/living/L = stored_movable
		if(L.is_player_controlled() && L.loyalty_tag == "NanoTrasen")
			var/has_tax = FALSE
			if(is_player(L))
				var/mob/living/advanced/player/P = L
				var/delinq = SStax.check_delinquent(P)
				if(delinq)
					has_tax = TRUE
			if(has_tax)
				L.to_chat(span("danger","You were forced to pay your taxes and sold back to NanoTrasen!"))
				. = SStax.pay_taxes(L)*0.25
			else
				L.to_chat(span("danger","You were sold back to NanoTrasen!"))
				. = 3000
			//Teleport to station.
			var/obj/structure/interactive/fulton_beacon/FB = locate() in world
			if(FB)
				L.force_move(get_turf(FB))
			else
				log_error("FATAL WARNING: No fulton beacon was found in world!")
				L.force_move(locate(pick(rand(1,255),rand(1,255),1)))
			return .
		else
			L.to_chat(span("danger","You were captured and sold to a prison! Better luck next time!"))
		. = CEILING(L.get_value(),1)
		L.death(TRUE)
	else
		. = CEILING(stored_movable.get_value(),1)

	if(. && is_player(owner))
		var/mob/living/advanced/player/P = owner
		. = FLOOR(.*0.25,1)
		var/added_funds = P.adjust_currency(.)
		P.to_chat(span("notice","You've been given a share of [nice_number(added_funds)] credits for selling \the [stored_movable.name]."))

	qdel(stored_movable)
	stored_movable = null
	qdel(src)

/obj/structure/interactive/fulton/proc/can_be_extracted(var/mob/caller,var/atom/movable/M)
	if(!M.is_player_controlled() && !M.is_safe_to_delete(check_loc = FALSE))
		return FALSE
	return TRUE

/obj/structure/interactive/fulton/proc/add_movable(var/mob/caller,var/atom/movable/M)

	if(stored_movable)
		return FALSE

	owner = caller
	stored_movable = M
	M.force_move(src)
	update_sprite()

	caller.visible_message(span("danger","\The [caller.name] attaches \the [src.name] to \the [M.name]."),span("warning","You attach \the [src.name] to \the [M.name]."))

	if(can_be_extracted(caller,M))
		CALLBACK("\ref[src]_fly",SECONDS_TO_DECISECONDS(3),src,.proc/fly_away) //CLIFF RACEEEEEEEEEEEER
	else
		CALLBACK("\ref[src]_fail",SECONDS_TO_DECISECONDS(3),src,.proc/do_invalid_fulton)

	animate(src,pixel_z = TILE_SIZE, time=SECONDS_TO_DECISECONDS(2),easing=BOUNCE_EASING)

	play_sound('sound/effects/fultext_deploy.ogg',get_turf(src))

	return TRUE


/obj/structure/interactive/fulton/update_icon()

	. = ..()

	if(stored_movable)
		icon_state = "expand"
	else
		icon_state = "retract"


/obj/structure/interactive/fulton/update_underlays()

	. = ..()

	if(stored_movable)
		var/image/I = new
		I.appearance = stored_movable
		I.pixel_x = initial(stored_movable.pixel_x)
		I.pixel_y = initial(stored_movable.pixel_y) - pixel_y
		I.plane = PLANE_EFFECT
		add_underlay(I)
