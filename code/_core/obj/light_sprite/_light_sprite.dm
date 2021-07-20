/obj/light_sprite
	name = "light sprite"
	mouse_opacity = 0
	icon = 'icons/obj/light_sprite_new.dmi'
	icon_state = "radial"
	plane = PLANE_LIGHTING
	layer = 999
	blend_mode = BLEND_ADD

	appearance_flags = LONG_GLIDE | TILE_BOUND

	var/atom/movable/owner //Who actually owns this.
	var/atom/movable/top_atom //What the top atom actually is.

	size = 1 //Transform multiplier

/obj/light_sprite/Destroy()
	update(null) //kills top_atom
	owner = null
	return ..()

/obj/light_sprite/set_dir(var/desired_dir,var/force = FALSE)
	dir = desired_dir
	return dir

/obj/light_sprite/force_move(var/atom/new_loc)
	if(top_atom) glide_size = top_atom.glide_size
	return ..()

/obj/light_sprite/proc/update(var/atom/movable/new_source)

	if(!new_source)
		if(top_atom)
			top_atom.light_sprite_sources -= src
			top_atom = null
		return TRUE

	if(top_atom != new_source)
		if(top_atom)
			top_atom.light_sprite_sources -= src
		top_atom = new_source
		top_atom.light_sprite_sources |= src
		force_move(get_turf(top_atom))
		set_dir(top_atom.dir)
		return TRUE

	return FALSE

/obj/light_sprite/get_base_transform()
	. = ..()
	var/matrix/M = .
	M.Scale(size)
	M.Translate(TILE_SIZE*0.5 - (160*0.5))

/obj/light_sprite/update_sprite()
	. = ..()
	transform = get_base_transform()

