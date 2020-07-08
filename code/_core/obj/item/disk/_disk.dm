/obj/item/disk/
	name = "data disk"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores information. This one is blank, though."
	icon = 'icons/obj/item/disk.dmi'
	icon_state = "disk"

	var/list/data = null

	var/frame_color = "#00FF00"
	var/writing_color = "#FFFFFF"
	var/metal_color = "#FFFFFF"

	value = 20

/obj/item/disk/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("data")
	return .

/obj/item/disk/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("data")
	return .

/obj/item/disk/New(var/desired_loc)
	. = ..()
	update_sprite()
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
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD."
	frame_color = "#DEB63D"
	writing_color = "#004A7F"
	metal_color = "#BBC5C7"

/obj/item/disk/random/New()
	frame_color = random_color()
	writing_color = random_color()
	metal_color = random_color()
	return ..()

/obj/item/disk/rcd/metal_wall
	name = "rcd data disk (steel wall)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a steel wall."
	data = list(
		"name" = "steel_wall.turf",
		"effect" = /obj/effect/temp/construction/wall,
		"object" = /turf/simulated/wall/metal,
		"cost" = 1000
	)

/obj/item/disk/rcd/glass_window
	name = "rcd data disk (glass window)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a glass window."
	data = list(
		"name" = "glass_window.spawner",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/marker/spawning/window/rcd,
		"cost" = 1000
	)

