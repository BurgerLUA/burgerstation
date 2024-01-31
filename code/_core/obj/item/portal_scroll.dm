/obj/item/portal_scroll
	name = "portal scroll"
	desc = "Seems stable-ish."
	desc_extended = "A scroll that when read, creates a portal to the nearest safe place."
	icon = 'icons/obj/item/portal_scroll.dmi'
	icon_state = "inventory"
	has_quick_function = TRUE //Allows scrolls to show up in the belt slots.
	value = 500

	rarity = RARITY_RARE

/obj/item/portal_scroll/get_examine_list(var/mob/examiner)
	. = ..()
	if(is_living(examiner))
		var/mob/living/L = examiner
		if(L.loyalty_tag && length(portal_markers[L.loyalty_tag]))
			var/obj/marker/M = portal_markers[L.loyalty_tag][1]
			var/area/A = get_area(M)
			if(A) . += span("notice","Using this will teleport you to \the [A.name].")

/obj/item/portal_scroll/quick(var/mob/caller,var/atom/object,location,params)
	click_self(caller)

/obj/item/portal_scroll/click_self(var/mob/caller,location,control,params)

	if(!is_player(caller) || !caller.client)
		caller.to_chat(span("warning","You don't know how to use this..."))
		return TRUE

	var/mob/living/advanced/player/P = caller

	if(!P.z)
		caller.to_chat(span("warning","You can't use this here!"))
		return TRUE

	var/area/A = P.loc.loc
	if(A.area_identifier != "Mission")
		caller.to_chat(span("warning","You can't use this here!"))
		return TRUE

	if(enable_friendly_fire)
		caller.to_chat(span("warning","This doesn't seem to be working for some reason..."))
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
	if(T2.can_move_to())
		T = T2

	var/obj/marker/portal/PM = pick(portal_markers[P.loyalty_tag])
	var/turf/PMT = get_turf(PM)

	if(!T || !PMT)
		caller.to_chat(span("warning","Failed to create a portal. Something horribly went wrong."))
		return TRUE

	var/obj/effect/temp/portal/start_portal = new(T,SECONDS_TO_DECISECONDS(300))
	var/obj/effect/temp/portal/end_portal = new(PMT,SECONDS_TO_DECISECONDS(300))
	if(SSdmm_suite.is_pvp_coord(T.x,T.y,T.z)) //Effectively one way.
		end_portal.mouse_opacity = 0
		end_portal.alpha = 0
		end_portal.invisibility = 101

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

	start_portal.update_sprite()
	end_portal.update_sprite()

	qdel(src)

	play_sound('sound/effects/portal.ogg',T)
	play_sound('sound/effects/portal.ogg',PMT)

	return TRUE