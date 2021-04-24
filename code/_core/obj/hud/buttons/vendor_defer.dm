/obj/hud/button/vendor_defer
	name = "vendor defer"
	icon_state = "square"
	screen_loc = "CENTER,CENTER"

	var/obj/structure/interactive/vending/associated_vendor

/obj/hud/button/vendor_defer/Destroy()
	associated_vendor = null
	. = ..()

/obj/hud/button/vendor_defer/update_overlays()
	. = ..()
	if(associated_vendor)
		var/image/I = new/image(initial(associated_vendor.icon),initial(associated_vendor.icon_state))
		add_overlay(I)

/obj/hud/button/vendor_defer/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	..()
	. = associated_vendor.clicked_on_by_object(caller,object,location,control,params)
	return .


/obj/hud/button/vendor_close
	name = "close vendor"
	icon_state = "arrow"
	screen_loc = "CENTER,CENTER"

/obj/hud/button/vendor_close/proc/close()

	if(!owner)
		return FALSE

	HOOK_REMOVE("post_move","\ref[src]_post_move",owner)

	for(var/obj/hud/button/vendor_defer/VD in owner.buttons)
		VD.update_owner(null)

	src.update_owner(null)



/obj/hud/button/vendor_close/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	close()

	. = ..()