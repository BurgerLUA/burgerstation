/obj/item/herald_mirror
	name = "the herald's mirror"
	desc = "Gaze upon it, and you will be transported to a realm of safety. Use the mirror again to return back."
	desc_extended = "A special mirror that will teleport the owner to a hidden realm."

	icon = 'icons/obj/item/herald_mirror.dmi'
	icon_state = "inventory"

	var/obj/marker/herald/destination/linked_destination
	var/obj/marker/herald/returning/linked_returning

	value = 5000

	rarity = RARITY_MYTHICAL

/obj/item/herald_mirror/Destroy()
	linked_destination = null
	linked_returning = null
	. = ..()

/obj/item/herald_mirror/Finalize()
	linked_destination = locate() in world
	return ..()

/obj/item/herald_mirror/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(!is_advanced(activator))
		activator.to_chat(span("warning","You don't know how to use this..."))
		return TRUE

	if(istype(activator,/mob/living/advanced/player/antagonist))
		activator.to_chat(span("warning","It's probably not a good idea to use with your explosive implant..."))
		return TRUE

	var/mob/living/advanced/A = activator

	if(!can_teleport(A))
		return FALSE

	PROGRESS_BAR(activator,src,SECONDS_TO_DECISECONDS(5),src::do_teleport(),A)
	PROGRESS_BAR_CONDITIONS(activator,src,src::can_teleport(),A)

	return TRUE

/obj/item/herald_mirror/proc/can_teleport(var/mob/living/advanced/A)

	if(!can_activator_interact_with(A, delay_checks = FALSE)) // This is INTERACT_CHECK_NO_DELAY(x) but 516 friendly
		return FALSE

	if(!linked_destination)
		A.to_chat(span("warning","Something went wrong... tell Burger on discord."))
		return FALSE

	if(!SSgamemode?.active_gamemode?.allow_launch)
		A.to_chat(span("warning","You can't use \the [src.name]... yet."))
		return FALSE

	if(!A.can_move())
		A.to_chat(span("warning","You can't use \the [src.name] in your current state!"))
		return FALSE

	if(!is_inventory(loc))
		A.to_chat(span("warning","You need to be holding \the [src.name] in order to teleport!"))
		return FALSE

	var/obj/hud/inventory/I = loc

	if(!I.click_flags || I.owner != A)
		A.to_chat(span("warning","You need to be holding \the [src.name] in order to teleport!"))
		return FALSE

	return TRUE


/obj/item/herald_mirror/proc/do_teleport(var/mob/living/advanced/A)

	var/area/A2 = get_area(A)

	if(istype(A2,/area/herald))
		var/turf/T = get_turf(linked_returning)
		if(!T)
			A.to_chat(span("notice","It seems you cannot go back to your previous location... perhaps the light can help you get back."))
			return TRUE
		A.force_move(T)
		A.visible_message(span("danger","\The [A.name] appears out of nowhere!"),span("notice","\The [src.name] whisks you away, back to where you were."))
		return TRUE

	if(linked_returning)
		qdel(linked_returning) //Get rid of existing one.
	linked_returning = new(get_turf(A))
	INITIALIZE(linked_returning)
	GENERATE(linked_returning)
	FINALIZE(linked_returning)

	A.force_move(get_turf(linked_destination))
	A.visible_message(span("danger","\The [A.name] disappears in a soft flash!"),span("notice","\The [src.name] whisks you away to safety."))

	return TRUE
