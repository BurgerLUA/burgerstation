/obj/structure/interactive/ore_deposit
	name = "ore deposit"
	desc = "MINECRAFT."
	icon = 'icons/obj/structure/ore.dmi'
	icon_state = "deposit"
	var/material_id
	var/chance_delete = 0

	var/uses_current = 0
	var/uses_max = 5

	mouse_opacity = 2

/obj/structure/interactive/ore_deposit/New(var/desired_loc)

	uses_current = 5

	if(chance_delete && prob(chance_delete))
		qdel(src)
		return FALSE

	return ..()

/obj/structure/interactive/ore_deposit/proc/mine(var/mob/caller)

	if(uses_current <= 0)
		if(caller)
			caller.to_chat(span("notice","This ore vein is depleted!."))
		return TRUE

	var/obj/item/material/ore/O = new(src.loc)
	O.material_id = src.material_id
	INITIALIZE(O)
	GENERATE(O)

	var/move_direction = get_dir(src,caller)

	var/animation_offset_x = 0
	var/animation_offset_y = 0

	if(move_direction & NORTH)
		animation_offset_y -= 32

	if(move_direction & SOUTH)
		animation_offset_y += 32

	if(move_direction & EAST)
		animation_offset_x -= 32

	if(move_direction & WEST)
		animation_offset_x += 32

	O.pixel_x = animation_offset_x
	O.pixel_y = animation_offset_y

	animate(O, pixel_x = rand(-16,16), pixel_y=rand(-16,16), time = 1)

	uses_current -= 1
	update_sprite()


/obj/structure/interactive/ore_deposit/update_icon()

	if(uses_current)
		alpha = 100 + (uses_current/uses_max)*155
	else
		alpha = 0

	if(alpha)
		mouse_opacity = 2
	else
		mouse_opacity = 0

	return ..()

/obj/structure/interactive/ore_deposit/proc/can_mine_ore(var/mob/caller,var/atom/object)

	if(get_dist(src,caller) > 1)
		caller.to_chat("You're too far away to mine ore!")
		return FALSE

	if(uses_current <= 0)
		caller.to_chat(span("notice","This ore vein is depleted!."))
		return TRUE

	if(!is_item(object))
		caller.to_chat(span("notice","You need a mining tool in order to mine \the [src.name]."))
		return TRUE

	var/obj/item/I = object

	if(!(I.flags_tool & FLAG_TOOL_PICKAXE))
		caller.to_chat(span("notice","You need a mining tool in order to mine \the [src.name]."))
		return FALSE

	return TRUE

/obj/structure/interactive/ore_deposit/proc/mine_ore(var/mob/caller)

	return TRUE

/obj/structure/interactive/ore_deposit/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	object = object.defer_click_on_object(location,control,params)

	if(can_mine_ore(caller,object))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/mine_ore,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_mine_ore,caller,object)

	return TRUE

/obj/structure/interactive/ore_deposit/iron
	name = "iron deposit"
	icon_state = "deposit_iron"
	material_id = /material/iron

/obj/structure/interactive/ore_deposit/gold
	name = "gold deposit"
	icon_state = "deposit_gold"
	material_id = /material/gold

/obj/structure/interactive/ore_deposit/silver
	name = "silver deposit"
	icon_state = "deposit_silver"
	material_id = /material/silver

/obj/structure/interactive/ore_deposit/carbon //Found near the ocean.
	name = "coal deposit"
	icon_state = "deposit_coal"
	material_id = /material/carbon

/obj/structure/interactive/ore_deposit/aluminum //Found in surface.
	name = "aluminum deposit"
	color = "#C4C4C4"
	material_id = /material/aluminum

/obj/structure/interactive/ore_deposit/plasma
	name = "phoron plasma deposit"
	icon_state = "deposit_phoron"
	material_id = /material/phoron