/obj/structure/interactive/statue
	name = "statue"
	desc = "For the ego."
	desc_extended = "A fancy statue of something."

	icon = 'icons/obj/structure/statue.dmi'
	icon_state = "base"

	var/atom/movable/stored_object
	var/offset_x = 0
	var/offset_y = 0

	color = "#F7EFDC"

	anchored = TRUE
	density = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	pixel_y = 6

/obj/structure/interactive/statue/Destroy()
	QDEL_NULL(stored_object)
	. = ..()

/obj/structure/interactive/statue/Finalize()
	. = ..()
	color = "#FFFFFF"

/obj/structure/interactive/statue/proc/set_stored_object(var/atom/A)
	stored_object = A
	update_sprite()
	return TRUE

/obj/structure/interactive/statue/update_sprite()
	. = ..()
	color = "#FFFFFF"

/obj/structure/interactive/statue/update_overlays()

	. = ..()

	if(stored_object)
		var/image/I = new/image(stored_object.icon,stored_object.icon_state)
		I.appearance = stored_object.appearance

		var/old_color = initial(color)
		var/r = (GetRedPart(old_color)/255)*0.5
		var/g = (GetGreenPart(old_color)/255)*0.5
		var/b = (GetBluePart(old_color)/255)*0.5
		var/main = (1 - max(r,g,b))*0.5
		I.color = list(main,main,main, main,main,main, main,main,main, r,g,b)
		I.pixel_y = offset_y
		add_overlay(I)




/obj/structure/interactive/statue/assistant/Generate()
	. = ..()
	offset_x = 0
	offset_y = 17
	var/mob/living/advanced/A = new(src)
	INITIALIZE(A)
	A.equip_loadout(/loadout/new_player)
	A.update_all_blends()
	GENERATE(A)
	FINALIZE(A)
	set_stored_object(A)


/obj/structure/interactive/statue/debug/
	color = "#FFCC69"

/obj/structure/interactive/statue/debug/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	. = ..()
	offset_x = 0
	offset_y = 17
	set_stored_object(caller)


/obj/structure/interactive/statue/director/
	color = "#FFCC69"

/obj/structure/interactive/statue/director/Generate()
	. = ..()
	offset_x = 0
	offset_y = 17
	var/mob/living/advanced/A = new(src)
	INITIALIZE(A)
	A.equip_loadout(/loadout/research_director)
	A.update_all_blends()
	GENERATE(A)
	FINALIZE(A)
	set_stored_object(A)