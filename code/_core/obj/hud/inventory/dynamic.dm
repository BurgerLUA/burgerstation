/obj/hud/inventory/dynamic
	name = "inventory space"
	icon_state = "square_round"

	alpha = 0 //Hidden until enabled
	mouse_opacity = 0 //Off until enabled.

	max_size = -1
	max_weight = -1

	should_draw = FALSE
	drag_to_take = FALSE

	held_slots = 1
	worn_slots = 0

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_SPECIAL | FLAGS_HUD_CONTAINER

	var/list/add_sounds = list(
		'sounds/effects/inventory/rustle1.ogg',
		'sounds/effects/inventory/rustle2.ogg',
		'sounds/effects/inventory/rustle3.ogg',
		'sounds/effects/inventory/rustle4.ogg',
		'sounds/effects/inventory/rustle5.ogg'
	)

	should_add_worn = FALSE
	should_add_held = FALSE

	var/slot_num = 0

/obj/hud/inventory/dynamic/New(var/desired_loc)

	if(desired_loc && is_atom(desired_loc))
		var/atom/A = desired_loc
		name = "inventory space of [A.name]"

	return ..()

/obj/hud/inventory/dynamic/remove_object(var/obj/item/I,var/turf/drop_loc,var/pixel_x_offset=0,var/pixel_y_offset=0)

	. = ..()

	if(. && owner && !qdeleting)
		play_sound(pick(add_sounds),src)

	return .