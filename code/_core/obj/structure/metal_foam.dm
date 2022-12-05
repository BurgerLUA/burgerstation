/obj/structure/metal_foam
	name = "metal foam"
	desc = "Foamy!"
	desc_extended = "An annoying block of metal foam meant for patching holes like a lazy person. Slightly fragile."

	icon = 'icons/obj/structure/metal_foam.dmi'
	icon_state = "0,0"

	anchored = TRUE
	density = TRUE
	opacity = TRUE

	health = /health/construction

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = NORTH | EAST | SOUTH | WEST

	health_base = 100

/obj/structure/metal_foam/New(var/desired_loc)
	. = ..()
	icon_state = "[rand(0,7)],[rand(0,7)]"

/obj/structure/metal_foam/Finalize()
	. = ..()
	update_sprite()

/obj/structure/metal_foam/proc/cut_overlays()
	overlays.Cut()
	return TRUE

/obj/structure/metal_foam/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"foam-disolve")
	I.appearance_flags = src.appearance_flags
	add_overlay(I)
	CALLBACK("\ref[src]_cut_overlays",SECONDS_TO_DECISECONDS(3),src,.proc/cut_overlays)


/obj/structure/metal_foam/on_destruction(var/mob/caller,var/damage = FALSE)
	. = ..()
	qdel(src)