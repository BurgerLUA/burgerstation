/obj/effect/temp/portal
	name = "portal"
	desc = "Should be safe."
	icon = 'icons/obj/effects/portal.dmi'
	icon_state = "blue"

	var/obj/effect/temp/portal/linked_portal
	var/obj/marker/portal/linked_marker

	density = FALSE
	anchored = TRUE

	mouse_opacity = 1

	var/loyalty_tag

	pixel_y = 8

	alpha = 200

	plane = PLANE_OBJ
	layer = LAYER_OBJ_AIRLOCK

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_HORIZONTAL
	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	desired_light_range = 3
	desired_light_power = 0.25
	desired_light_color = "#0384E2"

/obj/effect/temp/portal/update_atom_light()
	set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	return TRUE

/obj/effect/temp/portal/New(var/desired_loc,var/desired_time)
	. = ..()
	transform *= 0.01
	animate(src,transform=get_base_transform(),time=5,easing=BOUNCE_EASING)

	filters += filter(type="drop_shadow",size=1,offset=0,color="#0384E2")
	animate(filters[length(filters)],size=6,color="#0384E2",easing=SINE_EASING,time=5,loop=-1,flags=ANIMATION_PARALLEL)
	animate(size=10,easing=SINE_EASING,time=5)
	animate(size=2,easing=SINE_EASING,time=5)

	filters += filter(type="ripple",x=0,y=0,size=10,repeat=4,radius=0,falloff=0.5,flags=WAVE_BOUNDED)
	animate(filters[length(filters)],radius=0,size=10,easing=SINE_EASING,time=7,loop=-1,flags=ANIMATION_PARALLEL)
	animate(radius=10,size=0,easing=SINE_EASING,time=7)
	animate(radius=5,size=10,easing=SINE_EASING,time=7)

	update_atom_light()

/obj/effect/temp/portal/Destroy()
	if(linked_portal)
		if(linked_portal.linked_portal == src)
			linked_portal.linked_portal = null
		linked_portal = null
	if(linked_marker)
		portal_markers |= linked_marker
		linked_marker = null
	. = ..()

/obj/effect/temp/portal/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object) && linked_portal)
		INTERACT_CHECK
		INTERACT_DELAY(10)
		var/mob/living/L = caller
		if(L.loyalty_tag == loyalty_tag)
			var/turf/destination_turf = get_turf(linked_portal)
			L.visible_message(span("notice","\The [caller.name] steps into \the [src.name]."),span("notice","You step into \the [src.name]."))
			L.force_move(destination_turf)
			L.visible_message(span("notice","\The [caller.name] walks out from out of \the [linked_portal.name]"),span("notice","You walk out of \the [linked_portal.name]"))
			play_sound('sound/effects/portal_exit.ogg',destination_turf)
			play_sound('sound/effects/portal_exit.ogg',get_turf(src))
			return TRUE

	. = ..()