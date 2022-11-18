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

	rarity = RARITY_UNCOMMON

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
		"object" = /obj/structure/table,
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

/obj/item/disk/nuke
	name = "nuclear authentication disk"
	desc = "GET THAT FUKKEN DISK."
	desc_extended = "Stores the very advanced 4-bit encryption codes."
	frame_color = "#007F0E"
	writing_color = "#0094FF"
	metal_color = "#FFE38F"
	value_burgerbux = 1
	value = 10000

	rarity = RARITY_LEGENDARY


/obj/item/disk/genetic
	name = "genetic data disk"
	desc = "GET THAT FUKKEN D-- Oh, nevermind."
	desc_extended = "Stores blueprints for use for altering genetic data. Inserting it into an Ability machine will unlock the stored ability."
	frame_color = COLOR_PURPLE
	writing_color = COLOR_BLACK
	metal_color = COLOR_GOLD

	data = list(
		"ability" = null
	)

	rarity = RARITY_UNCOMMON

/obj/item/disk/genetic/Finalize()

	. = ..()

	desc_extended = initial(desc_extended)

	var/ability/A = data["ability"]
	if(!A)
		desc_extended = "[desc_extended] This one is blank."
		return .

	var/ability_name = initial(A.name)
	var/ability_desc = initial(A.desc)

	desc_extended = "[desc_extended] This one unlocks the ability \"[ability_name]\" which will apparantly \"[ability_desc]\" Neat."


/obj/item/disk/genetic/update_overlays()

	. = ..()

	var/ability/A = data["ability"]
	if(A)
		var/image/I = new(initial(A.icon),initial(A.icon_state))
		var/matrix/M = matrix()
		M.Scale(0.5,0.5)
		I.transform = M
		add_overlay(I)

/obj/item/disk/genetic/dash
	name = "genetic data disk (dash)"
	data = list(
		"ability" = /ability/dash
	)

/obj/item/disk/genetic/dash/controlled
	name = "genetic data disk (controlled dash)"
	data = list(
		"ability" = /ability/dash/controlled
	)

/obj/item/disk/genetic/dash/targeted
	name = "genetic data disk (targeted dash)"
	data = list(
		"ability" = /ability/dash/targeted
	)

/obj/item/disk/genetic/dash/random
	name = "genetic data disk (random dash)"
	data = list(
		"ability" = /ability/dash/random
	)

/obj/item/disk/genetic/dash/fleeting
	name = "genetic data disk (fleeting dash)"
	data = list(
		"ability" = /ability/dash/fleeting
	)

/obj/item/disk/genetic/quick_draw
	name = "genetic data disk (quick draw)"
	data = list(
		"ability" = /ability/quick_draw
	)

/obj/item/disk/genetic/quick_draw/plus
	name = "genetic data disk (quick draw plus)"
	data = list(
		"ability" = /ability/quick_draw/plus
	)