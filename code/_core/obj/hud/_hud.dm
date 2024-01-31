/obj/hud/
	appearance_flags = NO_CLIENT_COLOR | PIXEL_SCALE | LONG_GLIDE | TILE_BOUND

	var/tooltip_text

	var/user_colors = TRUE

	var/flags_hud = 0x0

	var/mob/owner

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

	vis_flags = 0x0

	initialize_type = 0x0 //This type does not get initialized.

	var/delete_on_no_owner = TRUE
	var/bad_delete = TRUE

	desc_extended = null

	plane = PLANE_HUD
	layer = LAYER_HUD

/obj/hud/New(var/desired_loc)
	. = ..()
	if(!tooltip_text)
		tooltip_text = generate_tooltip_text()

var/regex/valid_punct = regex(@"[.?!]($|\s)")

#define TOOLTIP_LIMIT 99

/obj/hud/proc/generate_tooltip_text()

	if(length(desc_extended) <= TOOLTIP_LIMIT)
		return desc_extended

	var/checking_text = copytext(desc_extended,1,TOOLTIP_LIMIT)

	var/best_position = 0
	while(TRUE)
		var/result = valid_punct.Find(checking_text,best_position ? best_position + 1 : 1,0)
		if(!result)
			break
		best_position = result
	if(!best_position)
		return null

	return copytext(checking_text,1,best_position+1)

/obj/hud/proc/update_owner(var/mob/desired_owner)

	if(owner == desired_owner)
		return FALSE

	if(owner)
		owner.remove_button(src)

	if(!desired_owner && delete_on_no_owner)
		bad_delete = FALSE
		qdel(src)
		return TRUE

	owner = desired_owner
	if(owner)
		owner.add_button(src)
		update_sprite()

	return TRUE

/obj/hud/Destroy()
	owner = null
	. = ..()

/obj/hud/update_sprite()

	. = ..()

	if(user_colors)
		var/icon/I = new/icon(initial(icon),icon_state)
		swap_colors(I)
		icon = I

/obj/hud/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1,var/damagetype/damage_type_override)
	CRASH("[attacker.get_debug_name()] tried to attack [victim] with a HUD object!")

/obj/hud/proc/swap_colors(var/icon/I)

	var/list/color_scheme = DEFAULT_COLORS

	if(owner && owner.client && owner.client.settings)
		color_scheme = owner.client.settings.loaded_data["hud_colors"]

	I.SwapColor(rgb(255,0,0),color_scheme[1])
	I.SwapColor(rgb(0,255,0),color_scheme[2])
	I.SwapColor(rgb(0,0,255),color_scheme[3])

	I.SwapColor(rgb(255,255,255),color_scheme[4])
	I.SwapColor(rgb(255,0,255),color_scheme[5])
	I.SwapColor(rgb(0,255,255),color_scheme[6])

	I.SwapColor(rgb(255,255,0),color_scheme[7])



	return TRUE


/obj/hud/Initialize()
	CRASH("HUD objects should never be Initialized!")

/obj/hud/PostInitialize()
	CRASH("HUD objects should never be PostInitialized!")

/obj/hud/Finalize()
	CRASH("HUD objects should never be Finalized!")

/obj/hud/Generate()
	CRASH("HUD objects should never be Generated!")

/obj/hud/proc/set_tooltip(var/mob/caller)

	var/list/split_screen_loc = splittext(src.screen_loc,",")

	if(length(split_screen_loc) == 2)

		var/x_offset = 0
		var/y_offset = 0

		if(findtext(screen_loc,"TOP"))
			y_offset = -1
		else if(findtext(screen_loc,"BOTTOM"))
			y_offset = 1
		else if(findtext(split_screen_loc[2],"CENTER"))
			y_offset = 1

		if(findtext(screen_loc,"RIGHT"))
			x_offset = -1
		else if(findtext(screen_loc,"LEFT"))
			x_offset = 1
		else if(findtext(split_screen_loc[2],"CENTER"))
			x_offset = 1

		var/desired_screen_loc = "[split_screen_loc[1]]+[x_offset],[split_screen_loc[2]]+[y_offset]"
		caller?.tooltip?.set_text("[src.name]\n\n[src.tooltip_text]",desired_screen_loc)

	return TRUE


/obj/hud/MouseEntered(location,control,params)
	. = ..()
	if(tooltip_text && mouse_opacity > 0)
		CALLBACK("tooltip_\ref[src]",SECONDS_TO_DECISECONDS(1),src,src::set_tooltip(),usr)

/obj/hud/MouseExited(location,control,params)
	. = ..()
	CALLBACK_REMOVE("tooltip_\ref[src]")
	usr.tooltip?.set_text(null)