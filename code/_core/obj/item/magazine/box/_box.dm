/obj/item/magazine/box
	name = "box of bullets"
	desc = "A box of bullets for easy carrying needs."
	icon = 'icons/obj/items/bullet/boxes.dmi'
	icon_state = "default"


/obj/item/magazine/box/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(src,/obj/item/magazine/clip))
		return FALSE

	object = object.defer_click_on_object()

	if(!is_bullet_gun(object))
		return ..()

	caller.to_chat(span("notice","You can't insert bullets into weapons like this!"))

	return TRUE