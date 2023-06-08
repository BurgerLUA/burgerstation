/obj/structure/interactive/fulton
	name = "fulton"
	desc = "oh no"
	desc_extended = "Better save them quick."

	icon = 'icons/obj/effects/fulton.dmi'
	icon_state = "none"

	plane = PLANE_EFFECT
	layer = LAYER_MOB_FLYING

	var/mob/owner
	var/atom/movable/stored_movable

	pixel_y = 16

	mouse_opacity = 1

	anchored = 2

/obj/structure/interactive/fulton/PreDestroy()
	if(stored_movable)
		if(loc)
			stored_movable.force_move(loc)
		else
			qdel(stored_movable)
		stored_movable = null
	. = ..()

/obj/structure/interactive/fulton/Destroy()
	owner = null
	. = ..()

/obj/structure/interactive/fulton/proc/do_invalid_fulton()

	var/turf/T = get_turf(src)

	stored_movable.force_move(T)

	if(is_living(stored_movable))
		var/mob/living/L = stored_movable
		L.add_status_effect(STUN,30,30)

	visible_message(span("danger","\The [src.name] fails to extract \the [stored_movable.name]!"))

	stored_movable = null

	var/obj/item/fulton_pack/F = new(T)
	INITIALIZE(F)
	F.amount = 1
	FINALIZE(F)

	qdel(src)

	return TRUE



/obj/structure/interactive/fulton/proc/fly_away()
	visible_message(span("danger","\The [src.name] flies up in the air, bringing \the [stored_movable.name] with it!"))
	play_sound('sound/effects/fultext_launch.ogg',get_turf(src))
	animate(src,pixel_z = TILE_SIZE*VIEW_RANGE,alpha=0,color="#000000",time=SECONDS_TO_DECISECONDS(1),easing=BACK_EASING | EASE_IN)
	CALLBACK("\ref[src]_sell",SECONDS_TO_DECISECONDS(2),src,src::sell_stored())
	return TRUE

/obj/structure/interactive/fulton/proc/sell_stored()

	. = 0

	if(!stored_movable)
		qdel(src)
		return 0

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
				L.to_chat(span("danger","You were forced to pay your taxes!"))
				. = SStax.pay_taxes(L)*0.25

			L.to_chat(span("danger","You were sold back to NanoTrasen!"))
			if(is_player(L))
				var/mob/living/advanced/player/P = L
				. += -P.adjust_currency(-3000)

			//Teleport to station.
			var/obj/structure/interactive/fulton_beacon/FB = locate() in world
			if(FB)
				L.force_move(get_turf(FB))
			else
				log_error("FATAL WARNING: No fulton beacon was found in world!")
				do_invalid_fulton()
				return 0
			return .
		else
			L.to_chat(span("danger","You were captured! Better luck next time!"))
		. = CEILING(L.get_value(),1)
		L.death(TRUE)
	else
		. = CEILING(stored_movable.get_value(),1)

	if(. && is_player(owner) && owner.client)
		var/mob/living/advanced/player/P = owner
		. = FLOOR(.*0.25,1)
		var/added_funds = P.adjust_currency(.)
		P.to_chat(span("notice","You've been given a share of [nice_number(added_funds)] credits for selling \the [stored_movable.name]."))

	qdel(stored_movable)
	stored_movable = null
	qdel(src)

/obj/structure/interactive/fulton/proc/can_be_extracted(var/mob/caller,var/atom/movable/M)

	if(is_player(M))
		var/mob/living/advanced/player/P = M
		if(P.loyalty_tag == "NanoTrasen" && P.dead)
			caller.to_chat(span("warning","NanoTrasen doesn't accept dead crewmembers!"))
			return FALSE
		return TRUE

	if(!M.is_safe_to_delete(check_loc = FALSE))
		caller.to_chat(span("warning","Something seems to be preventing \the [M.name] from being extracted..."))
		return FALSE

	if(istype(M,/obj/structure/interactive/artifact))
		caller.to_chat(span("warning","\The [M.name] is far to heavy to be lifted by \the Fulton System! "))
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
		if(is_living(M))
			var/mob/living/L = M
			if(!L.dead)
				L.rejuvenate() //Might as well.
		CALLBACK("\ref[src]_fly",SECONDS_TO_DECISECONDS(3),src,src::fly_away()) //CLIFF RACEEEEEEEEEEEER
	else
		CALLBACK("\ref[src]_fail",SECONDS_TO_DECISECONDS(3),src,src::do_invalid_fulton())

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
		I.layer = FLOAT_LAYER
		add_underlay(I)
