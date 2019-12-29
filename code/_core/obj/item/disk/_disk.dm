/obj/item/disk/
	name = "data disk"
	icon = 'icons/obj/items/disk.dmi'
	icon_state = "disk"

	var/list/disk_data = null

	var/frame_color = "#FF0000"
	var/writing_color = "#FFFFFF"
	var/metal_color = "#FFFFFF"

/obj/item/disk/New(var/desired_loc)
	. = ..()
	update_icon()
	return .

/obj/item/disk/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new(icon,"[icon_state]_frame")
	I.Blend(frame_color,ICON_MULTIPLY)
	var/icon/I2 = new(icon,"[icon_state]_writing")
	I2.Blend(writing_color,ICON_MULTIPLY)
	var/icon/I3 = new(icon,"[icon_state]_metal")
	I3.Blend(metal_color,ICON_MULTIPLY)
	I.Blend(I2,ICON_OVERLAY)
	I.Blend(I3,ICON_OVERLAY)
	icon = I

	return ..()


/obj/item/disk/rcd
	name = "rcd data disk"
	frame_color = "#DEB63D"
	writing_color = "#004A7F"
	metal_color = "#BBC5C7"

/obj/item/disk/rcd/metal_wall
	name = "rcd data disk (steel wall)"
	disk_data = list(
		"name" = "steel_wall.turf",
		"object" = /turf/simulated/wall/metal,
		"cost" = 1000
	)

/obj/item/disk/random/New()
	frame_color = random_color()
	writing_color = random_color()
	metal_color = random_color()
	return ..()

