/obj/item/experience_scroll

	name = "scroll of experience"
	desc = "Knowledge in the palms of your hands."
	desc_extended = "A special scroll that increases the reader's experience by a certain amount. One time use."

	icon = 'icons/obj/item/experience_scroll.dmi'
	icon_state = "scroll"

	item_count_current = 1
	item_count_max = 10

	weight = WEIGHT_0
	size = SIZE_2

	value = -1

	var/overlay_icon_state = "gem"
	var/overlay_color = "#FFFFFF"

/obj/item/experience_scroll/update_overlays()
	var/image/I = new/image(icon,overlay_icon_state)
	I.color = overlay_color
	add_overlay(I)
	return ..()

/obj/item/experience_scroll/proc/gain_knowledge(var/mob/living/advanced/A)
	play_sound('sound/ui/friendly.ogg',get_turf(src),range_max=VIEW_RANGE)
	return TRUE

/obj/item/experience_scroll/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(!is_advanced(caller) || !caller.is_player_controlled())
		caller.to_chat(span("warning","You don't know how to read this..."))
		return TRUE

	var/mob/living/advanced/A = caller

	if(!A.allow_experience_gains)
		caller.to_chat(span("warning","You don't know how to read this..."))
		return TRUE

	if(gain_knowledge(caller))
		caller.visible_message(span("notice","\The [caller.name] reads \the [src.name], taking in the knowledge..."),span("notice","You read \the [src.name], taking in the knowledge..."))
		add_item_count(-1)

	return TRUE