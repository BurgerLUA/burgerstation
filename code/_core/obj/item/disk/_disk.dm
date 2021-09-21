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

	drop_sound = 'sound/items/drop/card.ogg'

	weight = 0.5

/obj/item/disk/New(var/desired_loc)
	. = ..()
	update_sprite()

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

/obj/item/disk/random/Generate()
	frame_color = random_color()
	writing_color = random_color()
	metal_color = random_color()
	return ..()

/obj/item/disk/rcd/metal_plating
	name = "rcd data disk (metal plating)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for some floors."
	data = list(
		"name" = "steel_wall.turf",
		"effect" = /obj/effect/temp/construction/wall,
		"object" = /turf/simulated/floor/plating,
		"cost" = 500
	)

/obj/item/disk/rcd/metal_wall
	name = "rcd data disk (steel wall)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a steel wall."
	data = list(
		"name" = "plating.turf",
		"effect" = /obj/effect/temp/construction/wall,
		"object" = /turf/simulated/wall/metal,
		"cost" = 1000
	)

/obj/item/disk/rcd/conveyor
	name = "rcd data disk (conveyor belt)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a Conveyor Belt."
	data = list(
		"name" = "conveyor_belt.obj",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/structure/interactive/conveyor,
		"cost" = 500
	)

/obj/item/disk/rcd/diverter
	name = "rcd data disk (air diverter)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a Air Diverter."
	data = list(
		"name" = "air_diverter.obj",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/structure/interactive/diverter,
		"cost" = 500
	)

/obj/item/disk/rcd/orestorage
	name = "rcd data disk (ore storage)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for an ore silo."
	data = list(
		"name" = "ore_storage.obj",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/structure/interactive/ore_storage,
		"cost" = 2000
	)

/obj/item/disk/rcd/oresmelter
	name = "rcd data disk (smelter)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a smelter."
	data = list(
		"name" = "smelter.obj",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/structure/interactive/smelter,
		"cost" = 2000
	)

/obj/item/disk/rcd/stacker
	name = "rcd data disk (stacker)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a stacker."
	data = list(
		"name" = "stacker.obj",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/structure/interactive/stacker,
		"cost" = 2000
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

/obj/item/disk/rcd/airlock
	name = "rcd data disk (airlock)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for an airlock."
	data = list(
		"name" = "airlock.obj",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/structure/interactive/door/airlock,
		"cost" = 1000
	)

/obj/item/disk/rcd/table
	name = "rcd data disk (table)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for table."
	data = list(
		"name" = "table.obj",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/structure/smooth/table,
		"cost" = 500
	)

/obj/item/disk/rcd/chair
	name = "rcd data disk (chair)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a chair."
	data = list(
		"name" = "chair.obj",
		"effect" = /obj/effect/temp/sparkles,
		"object" = /obj/structure/interactive/chair,
		"cost" = 250
	)

/obj/item/disk/rcd/metal_wall/bunker
	name = "rcd data disk (bunker wall)"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use in an RCD. This one contains schematics for a reinforce bunker wall."
	data = list(
		"name" = "bunker_wall.turf",
		"effect" = /obj/effect/temp/construction/wall,
		"object" = /turf/simulated/wall/bunker,
		"cost" = 2500
	)

/obj/item/disk/nuke
	name = "nuclear authentication disk"
	desc = "GET THAT FUKKEN DISK."
	desc_extended = "Stores the very advanced 4-bit encryption codes."
	frame_color = "#007F0E"
	writing_color = "#0094FF"
	metal_color = "#FFE38F"
	value_burgerbux = 1
	value = 10000
