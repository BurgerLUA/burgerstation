/obj/structure/interactive/fire_closet
	name = "fire extinguisher holder"
	icon = 'icons/obj/structure/fire_closet_new.dmi'
	icon_state = "extinguisher"

	plane = PLANE_WALL_ATTACHMENT

	var/obj/item/weapon/ranged/reagent_sprayer/fire_extinguisher/stored_extinguisher

/obj/structure/interactive/fire_closet/PreDestroy()
	QDEL_NULL(stored_extinguisher)
	. = ..()

/obj/structure/interactive/fire_closet/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	//Putting the object back in is handled in the weapon itself.

	if(is_inventory(object) && is_advanced(activator))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		var/mob/living/advanced/A = activator
		if(!stored_extinguisher)
			activator.to_chat(span("warning","\The [src.name] is empty!"))
			return TRUE
		A.put_in_hands(stored_extinguisher,params)
		stored_extinguisher = null
		update_sprite()
		return TRUE

	. = ..()

/obj/structure/interactive/fire_closet/Generate()
	. = ..()
	stored_extinguisher = new /obj/item/weapon/ranged/reagent_sprayer/fire_extinguisher(src)
	INITIALIZE(stored_extinguisher)
	GENERATE(stored_extinguisher)
	FINALIZE(stored_extinguisher)

/obj/structure/interactive/fire_closet/Initialize()
	try_attach_to()
	setup_dir_offsets()
	dir = SOUTH
	. = ..()

/obj/structure/interactive/fire_closet/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/fire_closet/update_icon()
	. = ..()
	if(stored_extinguisher)
		icon_state = "extinguisher_filled"
	else
		icon_state = "extinguisher_empty"
