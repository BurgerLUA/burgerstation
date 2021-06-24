/obj/structure/interactive/lighting/mounted_torch
	name = "mounted torch"
	icon = 'icons/obj/structure/wall_torch.dmi'
	icon_state = "torch"

	desired_light_power = 0.75
	desired_light_range = VIEW_RANGE * 0.75
	desired_light_color = "#C6B8AF"

	dir_offset = TILE_SIZE - 8

/obj/structure/interactive/lighting/mounted_torch/Initialize()
	setup_dir_offsets()
	return ..()