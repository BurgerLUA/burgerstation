/obj/item/color/
	name = "Coloring Object"
	desc = "Color things with this!"

	var/uses = 1 //How many uses does this item have until it's useless?
	var/selected_color //Which color is currently selected?
	//var/possible_colors = list("#FFFFFF","#000000","#FF0000","#00FF00","#0000FF") //What possible colors can this object have selected?
	var/possible_colors = list("#FFFFFF")
	var/strength = 1 //The strength of the color. A strength of 1 sets it to the above color. A strength of 0.5 sets an average of the existing color and the desired color.

	var/list/type_blacklist = list()
	var/list/type_whitelist = list()

/obj/item/color/New(var/desired_loc)
	..()
	selected_color = possible_colors[1]

/obj/item/color/proc/get_selected_color()
	return selected_color

/obj/item/color/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(get_dist(caller,object) > 1)
		caller.to_chat(span("notice","You're too far away!"))
		return TRUE

	if(uses <= 0)
		caller.to_chat(span("notice","\The [src] seems to have run out of uses..."))
		return TRUE

	for(var/black_type in type_blacklist)
		if(istype(object,black_type))
			caller.to_chat(span("notice","You can't color \the [object] with \the [src]!"))
			return FALSE

	for(var/white_type in type_whitelist)
		if(!istype(object,white_type))
			caller.to_chat(span("notice","You can't color \the [object] with \the [src]!"))
			return FALSE

	var/color_to_set = get_selected_color(caller)

	if(strength < 1)
		var/object_r = GetRedPart(object.color)
		var/object_g = GetGreenPart(object.color)
		var/object_b = GetBluePart(object.color)

		var/desired_r = GetRedPart(selected_color)
		var/desired_g = GetGreenPart(selected_color)
		var/desired_b = GetBluePart(selected_color)


		var/dif_r = object_r - desired_r
		var/dif_g = object_g - desired_g
		var/dif_b = object_b - desired_b

		color_to_set = rgb(object_r + dif_r*strength,object_g + dif_g*strength,object_b + dif_b*strength)

	caller.to_chat(span("notice","You color \the [object] with \the [src]."))
	object.set_color(color_to_set)
	object.update_icon()
	uses--