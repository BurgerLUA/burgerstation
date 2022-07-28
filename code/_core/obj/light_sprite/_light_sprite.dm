/obj/light_sprite
	name = "light sprite"
	mouse_opacity = 0
	icon = 'icons/obj/light_sprite_new.dmi'
	icon_state = "radial"
	plane = PLANE_LIGHTING
	layer = 999
	blend_mode = BLEND_ADD

	appearance_flags = LONG_GLIDE | TILE_BOUND

	var/atom/movable/owner //What actually owns this. (ie a flare)
	var/atom/movable/top_atom //What the top atom actually is. (ie the person carrying the flare)

	var/power = 0
	size = 1 //Transform multiplier

/obj/light_sprite/Destroy()
	set_top_atom(null) //kills top_atom
	owner = null
	return ..()

/obj/light_sprite/set_dir(var/desired_dir,var/force = FALSE) //Override default.
	if(icon_state == "cone" && is_living(top_atom))
		var/mob/living/L = top_atom
		if(L.intent == INTENT_HARM && (L.client || L.ai?.objective_attack))
			desired_dir = NORTH
	dir = desired_dir
	return dir

/obj/light_sprite/force_move(var/atom/new_loc)
	if(top_atom) glide_size = top_atom.glide_size
	. = ..()

/obj/light_sprite/proc/set_top_atom(var/atom/movable/new_top_atom)

	if(top_atom == new_top_atom)
		return FALSE //No need. Even if it's null.

	if(top_atom) //Remove existing top_atom
		top_atom.light_sprite_sources -= src
		top_atom = null

	if(new_top_atom)
		var/turf/T = get_turf(new_top_atom)
		if(!T)
			CRASH("Invalid set_top_atom ([new_top_atom.get_debug_name()])!")
			return FALSE
		top_atom = new_top_atom
		top_atom.light_sprite_sources |= src
		force_move(T)
		set_dir(top_atom.dir)

	return TRUE

/obj/light_sprite/get_base_transform()
	. = ..()
	var/matrix/M = .
	M.Scale(size)
	if(icon_state == "cone" && is_living(top_atom))
		var/mob/living/L = top_atom
		if(L.intent == INTENT_HARM && !L.dead)
			if(L.client)
				M.Turn(get_angle(L,L.client.last_location))
			else if(L.ai?.objective_attack)
				M.Turn(get_angle(L,L.ai.objective_attack))
	M.Translate(TILE_SIZE*0.5 - (160*0.5))

/obj/light_sprite/update_sprite()
	. = ..()
	transform = get_base_transform()
	pixel_x = owner.light_offset_x
	pixel_y = owner.light_offset_y
	var/light_mod = 1
	if(is_inventory(owner.loc))
		var/obj/hud/inventory/I = owner.loc
		if(!I.worn)
			light_mod = I.light_mod

	alpha = power*255*light_mod

