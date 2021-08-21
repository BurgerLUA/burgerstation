/obj/item/portal_scroll
	name = "portal scroll"
	desc = "Seems stable-ish."
	desc_extended = "A scroll that when read, creates a portal to the nearest safe place. In this case, it's the station."
	icon = 'icons/obj/item/portal_scroll.dmi'
	icon_state = "inventory"
	has_quick_function = TRUE //Allows scrolls to show up in the belt slots.
	value = 500

/obj/item/portal_scroll/quick(var/mob/caller,var/atom/object,location,params)
	click_self(caller)

/obj/item/portal_scroll/click_self(var/mob/caller)

	if(!is_player(caller))
		caller.to_chat(span("warning","You don't know how to use this..."))
		return TRUE

	var/mob/living/advanced/player/P = caller

	if(!isturf(P.loc))
		caller.to_chat(span("warning","You can't use this here!"))
		return TRUE

	var/area/A = P.loc.loc
	if(A.area_identifier != "Mission")
		caller.to_chat(span("warning","You can't use this here!"))
		return TRUE

	if(!P.loyalty_tag || !portal_markers[P.loyalty_tag])
		caller.to_chat(span("warning","You don't know how to use this..."))
		return TRUE

	if(!length(portal_markers[P.loyalty_tag]))
		caller.to_chat(span("warning","Failed to create a portal... there are too many portals that exist already!"))
		return TRUE

	P.clear_portals()

	var/turf/T = get_turf(src)
	var/turf/T2 = get_step(T,caller.dir)
	if(T2.is_safe_teleport())
		T = T2

	var/obj/marker/portal/PM = pick(portal_markers[P.loyalty_tag])
	var/turf/PMT = get_turf(PM)

	if(!T || !PMT)
		caller.to_chat(span("warning","Failed to create a portal. Something horribly went wrong."))
		return TRUE

	var/obj/effect/temp/portal/start_portal = new(T,SECONDS_TO_DECISECONDS(300))
	var/obj/effect/temp/portal/end_portal = new(PMT,SECONDS_TO_DECISECONDS(300))

	start_portal.linked_portal = end_portal
	start_portal.loyalty_tag = P.loyalty_tag

	end_portal.linked_portal = start_portal
	end_portal.loyalty_tag = P.loyalty_tag

	end_portal.linked_marker = PM
	P.linked_portals = list(start_portal,end_portal)

	var/area/A1 = T.loc
	var/area/A2 = PMT.loc

	start_portal.name = "[P.name]'s portal to [A2.name]"
	end_portal.name = "[P.name]'s portal to [A1.name]"

	qdel(src)

	play_sound('sound/effects/portal.ogg',T)
	play_sound('sound/effects/portal.ogg',PMT)

	return TRUE