/obj/decal/poster/
	name = "poster"
	desc = "Do not ERP, ERP is bad."
	desc_extended = "A randomized poster as decor to liven up the area."
	icon = 'icons/obj/decal/poster.dmi'
	mouse_opacity = 1
	icon_state = null
	plane = PLANE_WALL
	layer = LAYER_WALL_DECAL

	var/collectable_poster/stored_poster

/obj/decal/poster/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(stored_poster && is_inventory(object))
		INTERACT_CHECK
		var/obj/hud/inventory/I = object
		var/obj/item/poster/P = new(get_turf(src))
		P.stored_poster = stored_poster
		INITIALIZE(P)
		FINALIZE(P)
		I.add_object(P)
		qdel(src)

	. = ..()

/obj/decal/poster/Initialize()
	setup_dir_offsets(src)
	dir = SOUTH
	return ..()

/obj/decal/poster/off_station/Generate()
	. = ..()
	if(prob(1))
		stored_poster = pick(SSposter.all_posters)
		var/collectable_poster/P = SSposter.all_posters[stored_poster]
		name = "Collectable Poster: [P.name]"
		icon = P.icon
		icon_state = P.icon_state
		desc = P.desc
		desc_extended = P.desc_extended

	else if(prob(25))
		icon_state = "poster[rand(1,35)]_legit"
	else
		icon_state = "poster[rand(1,44)]"

/obj/decal/poster/collectable/Generate()
	. = ..()
	stored_poster = pick(SSposter.all_posters)
	var/collectable_poster/P = SSposter.all_posters[stored_poster]
	name = "Collectable Poster: [P.name]"
	icon = P.icon
	icon_state = P.icon_state
	desc = P.desc
	desc_extended = P.desc_extended

/obj/decal/poster/nanotrasen/Generate() //Random positive poster.
	. = ..()
	if(prob(0.5))
		stored_poster = pick(SSposter.all_posters)
		var/collectable_poster/P = SSposter.all_posters[stored_poster]
		name = "Collectable Poster: [P.name]"
		icon = P.icon
		icon_state = P.icon_state
		desc = P.desc
		desc_extended = P.desc_extended
	else
		icon_state = "poster[rand(1,35)]_legit"

/obj/decal/poster/syndicate/Generate() //Random negative poster.
	. = ..()
	icon_state = "poster[rand(1,44)]"

/obj/decal/poster/painting
	name = "painting"
	desc = "Wow."
	desc_extended = "A randomized painting to liven up the area."

/obj/decal/poster/painting/PostInitialize() //Random painting poster.
	. = ..()
	icon_state = "painting[rand(1,14)]"