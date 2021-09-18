/obj/structure/sign/
	name = "sign"
	desc = "What does it say?"
	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	icon = 'icons/obj/sign/signs.dmi'
	icon_state = ""
	plane = PLANE_WALL
	layer = LAYER_WALL_DECAL
	var/use_dir_offsets = FALSE

/obj/structure/sign/Initialize()
	if(use_dir_offsets)
		setup_dir_offsets(src)
		dir = SOUTH
	return ..()

/obj/structure/sign/secure
	name = "secure area"
	icon_state = "secure"
	desc_extended = "A sign designating the area as secure."

/obj/structure/sign/space
	name = "space warning"
	icon_state = "space"
	desc_extended = "A sign designating the area ahead as space."

/obj/structure/sign/fire
	name = "fire warning"
	icon_state = "fire"
	desc_extended = "A sign designating the area ahead as a fire hazard."

/obj/structure/sign/no_smoking
	name = "no smoking"
	icon_state = "no_smoking"
	desc_extended = "A sign designating a smoke-free zone."

/obj/structure/sign/shock
	name = "electrical hazard"
	icon_state = "shock"
	desc_extended = "A sign designating an electrical hazard ahead."

/obj/structure/sign/shock
	name = "electrical hazard"
	icon_state = "shock"
	desc_extended = "A sign designating an electrical hazard ahead."

/obj/structure/sign/department
	name = "department sign"

#define SING_Y_OFFSET 8

//Part 1
/obj/structure/sign/department/a/med
	pixel_y = 0
	icon_state = "direction_med"

/obj/structure/sign/department/a/engineering
	pixel_y = SING_Y_OFFSET
	icon_state = "direction_eng"

/obj/structure/sign/department/a/supply
	pixel_y = -SING_Y_OFFSET
	icon_state = "direction_supply"

//Part 2
/obj/structure/sign/department/b/sci
	pixel_y = 0
	icon_state = "direction_sci"

/obj/structure/sign/department/b/sec
	pixel_y = SING_Y_OFFSET
	icon_state = "direction_sec"

/obj/structure/sign/department/b/evac
	pixel_y = -SING_Y_OFFSET
	icon_state = "direction_evac"

//Part 3
/obj/structure/sign/department/c/bridge
	pixel_y = 0
	icon_state = "direction_bridge"

/obj/structure/sign/department/c/infirm
	pixel_y = SING_Y_OFFSET
	icon_state = "direction_infirm"

/obj/structure/sign/department/c/other
	pixel_y = -SING_Y_OFFSET
	icon_state = "direction_other"



/obj/structure/sign/restroom/male
	icon_state = "male"

/obj/structure/sign/restroom/female
	icon_state = "female"