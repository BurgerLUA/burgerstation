/obj/parallax
	name = "the void"
	mouse_opacity = 0
	icon = 'icons/obj/effects/parallax.dmi'
	var/ratio = 1 //For every tile moved, move x pixel in the opposite direction.
	plane = PLANE_PARALLAX
	var/mob/owner
	var/auto_resize = TRUE
	appearance_flags = LONG_GLIDE | PIXEL_SCALE

/obj/parallax/New(var/desired_loc)
	if(auto_resize)
		transform *= ((VIEW_RANGE*2 + 1)*TILE_SIZE)/(480)
	return ..()

/obj/parallax/Destroy()
	owner = null
	return ..()

/obj/parallax/defer_click_on_object(var/mob/caller,location,control,params)
	if(params && length(params) && params["screen-loc"])
		var/turf/T = get_turf(owner)
		var/list/screen_loc = parse_screen_loc(params["screen-loc"])
		var/x_c = FLOOR(T.x + (screen_loc[1]/TILE_SIZE) - caller?.client?.view,1)
		var/y_c = FLOOR(T.y + (screen_loc[2]/TILE_SIZE) - caller?.client?.view,1)
		var/z_c = FLOOR(T.z,1)
		var/turf/T2 = locate(x_c,y_c,z_c)
		if(T2) return T2
	return ..()

/obj/parallax/layer1
	icon_state = "layer1"
	layer = 1
	ratio = 0
	mouse_opacity = 2

/obj/parallax/layer2
	icon_state = "layer2"
	layer = 2
	blend_mode = BLEND_ADD
	ratio = 0.25

/obj/parallax/layer3
	icon_state = "layer3"
	layer = 3
	blend_mode = BLEND_ADD
	ratio = 0.5

/obj/parallax/layer4
	icon_state = "layer4"
	layer = 4
	ratio = 1
	auto_resize = FALSE