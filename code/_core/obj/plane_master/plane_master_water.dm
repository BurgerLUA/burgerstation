/obj/plane_master/water
	plane = PLANE_WATER

/obj/plane_master/water/apply_post_processing()
	. = ..()
	filters += filter(type="alpha", x=0, y=0, render_source="plane_floor", flags = MASK_INVERSE)
	filters += filter(type="alpha", x=0, y=0, render_source="plane_wall", flags = MASK_INVERSE)

/obj/plane_master/water_floor
	plane = PLANE_WATER_FLOOR
	render_target = "plane_water_floor"

/obj/plane_master/water_floor/apply_post_processing()
	. = ..()
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=-3, offset=0, color=rgb(0,0,0,200))

/obj/plane_master/water_mask
	plane = PLANE_MOVABLE_WATER_MASK
	render_target = "*plane_water_mask"

/obj/plane_master/water_mask/apply_post_processing()
	. = ..()
	filters += filter(type="alpha", x=0, y=0, render_source="plane_water_floor") //Masks only draw in water.

