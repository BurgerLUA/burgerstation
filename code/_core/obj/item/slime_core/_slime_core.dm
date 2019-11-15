obj/item/slime_core
	name = "slime core"
	desc = "What wonders does this contained goo have?"
	color = "#FFFFFF"
	icon = 'icons/mob/living/simple/slimes_new.dmi'
	icon_state = "slime_core"
	alpha = 125

obj/item/slime_core/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(is_item(object))
		var/obj/item/I = object
		if(I.dye_self(caller,src,color,alpha/255))
			return TRUE

	return ..()

obj/item/slime_core/red
	color = "#FF0000"

obj/item/slime_core/green
	color = "#00FF00"

obj/item/slime_core/blue
	color = "#0000FF"
