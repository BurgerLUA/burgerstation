/obj/structure/interactive/powerbutton
	name = "big red power button"
	desc = "Wonder what it does? Oh it says right here."
	desc_extended = "A big red button that toggles power for the FOB. Controls lights, and most importantly, the FOB's gateway."

	icon = 'icons/obj/item/button.dmi'
	icon_state = "button"

	var/active = FALSE

	var/obj/structure/interactive/gateway/linked_gateway

	pixel_x = 0
	pixel_y = 4

	anchored = TRUE


/obj/structure/interactive/powerbutton/Initialize()
	if(!linked_gateway)
		linked_gateway = locate() in world
	. = ..()

/obj/structure/interactive/powerbutton/Finalize()

	for(var/area/fob/FOB in world)
		FOB.sync_lights(active)

	linked_gateway.set_active(active)

	. = ..()


/obj/structure/interactive/powerbutton/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A  = caller

	if(active && A.loyalty_tag == "NanoTrasen")
		A.to_chat(span("notice","The power for the FOB has already been enabled!"))
		return TRUE

	flick("button_anim",src)

	play_sound('sound/effects/deny.ogg',get_turf(src))

	active = !active

	for(var/area/fob/FOB in world)
		FOB.sync_lights(active)

	linked_gateway.set_active(active)

	. = ..()