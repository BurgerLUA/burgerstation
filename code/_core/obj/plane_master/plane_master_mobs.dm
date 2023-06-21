/obj/plane_master/mobs
	plane = PLANE_MOVABLE

/obj/plane_master/mobs/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=-4, size=3, offset=0, color=rgb(0,0,0,200))
	filters += filter(type="alpha", x=0, y=0, render_source="*plane_water_mask", flags=MASK_INVERSE)

/obj/plane_master/mobs_stealth
	plane = PLANE_MOVABLE_STEALTH
	render_target = "plane_mob_stealth"

/obj/plane_master/mobs_stealth/apply_post_processing()
	. = ..()
	filters += filter(type="alpha",render_source="*fov_\ref[owner]")
	filters += filter(type="alpha", x=0, y=0, render_source="*plane_water_mask", flags=MASK_INVERSE)
