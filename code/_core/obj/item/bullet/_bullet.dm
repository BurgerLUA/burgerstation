/obj/item/bullet/ //NOT TO BE CONFUSED WITH PROJECTILES.
	name = "bullet"
	desc = "just a regular bullet"
	id = "bullet"
	icon = 'icons/obj/items/bullet/bullet.dmi'
	icon_state = "bullet"
	var/is_spent = FALSE

/obj/item/bullet/update_icon()

	if(!is_spent)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_spent"
		pixel_x = rand(-8,8)
		pixel_y = rand(-8,8)
	..()

/obj/item/bullet/proc/spend_bullet()
	is_spent = TRUE
	update_icon()

/obj/item/bullet/proc/insert_into_gun(var/mob/caller as mob,var/obj/item/weapon/ranged/bullet/G,location,control,params,var/display_message = TRUE)

	if(!G.open)
		caller.to_chat(span("notice","You must open \the [G] first before loading it!"))
		return FALSE

	if(G.bullet_type != id)
		caller.to_chat(span("notice","You can't insert this type of bullet into \the [src]!"))
		return FALSE

	if(G.bullet_capacity <= G.get_ammo_count())
		caller.to_chat(span("notice","You can't fit any more bullets into \the [src]!"))
		return FALSE

	src.loc = G
	G.stored_bullets += src
	if(display_message)
		caller.to_chat(span("notice","You insert \the [src] into \the [G]."))

	return TRUE

/obj/item/bullet/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_bullet_gun(object))
		return ..()

	var/obj/item/weapon/ranged/bullet/G = object
	insert_into_gun(G)



	return TRUE

/obj/item/bullet/revolver_38
	name = "\improper .38 special"
	desc = "For revolvers that require .38 ammo."
	id = ".38"
	icon_state = ".38"