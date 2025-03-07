/obj/item/experience_scroll

	name = "scroll of experience"
	desc = "Knowledge in the palms of your hands."
	desc_extended = "A special scroll that increases the reader's experience by a certain amount. One time use."

	icon = 'icons/obj/item/experience_scroll.dmi'
	icon_state = "scroll"

	amount_max = 1

	weight = WEIGHT_0
	size = SIZE_2

	var/overlay_icon_state = "gem"
	var/overlay_color = "#FFFFFF"

	value_burgerbux = 1 //Prevents being sold in vendors or found in random loot.

	rarity = RARITY_MYTHICAL

	var/level_to_give = 3

/obj/item/experience_scroll/Finalize()
	. = ..()
	update_sprite()

/obj/item/experience_scroll/get_base_value()
	return level_to_give*300

/obj/item/experience_scroll/update_overlays()
	. = ..()
	if(overlay_icon_state)
		var/image/I = new/image(icon,overlay_icon_state)
		if(overlay_color) I.color = overlay_color
		add_overlay(I)

/obj/item/experience_scroll/proc/gain_knowledge(var/mob/living/advanced/A)
	play_sound('sound/ui/friendly.ogg',get_turf(src),range_max=VIEW_RANGE)
	return TRUE

/obj/item/experience_scroll/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(!is_advanced(activator) || !activator.is_player_controlled())
		activator.to_chat(span("warning","You don't know how to read this..."))
		return TRUE

	var/mob/living/advanced/A = activator

	if(!A.allow_experience_gains)
		activator.to_chat(span("warning","You don't know how to read this..."))
		return TRUE

	if(gain_knowledge(activator))
		activator.visible_message(span("notice","\The [activator.name] reads \the [src.name], taking in the knowledge..."),span("notice","You read \the [src.name], taking in the knowledge..."))
		add_item_count(-1)

	return TRUE