/obj/marker/prefab
	name = "prefab marker"
	var/dimensions = null
	icon_state = null
	var/chance_none = 50
	var/list/prefabs = null

/obj/marker/prefab/New(var/desired_loc)
	if(dimensions && !prob(chance_none))
		if(!SSdmm_suite.prefab_markers[dimensions]) SSdmm_suite.prefab_markers[dimensions] = list()
		SSdmm_suite.prefab_markers[dimensions] += src
	return ..()

/obj/marker/prefab/Destroy()
	if(dimensions)
		SSdmm_suite.prefab_markers[dimensions] -= src
	. = ..()

/obj/marker/prefab/large
	icon = 'icons/obj/markers/prefab_64x64.dmi'
	dimensions = "64x64"
	chance_none = 20

/obj/marker/prefab/medium
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	dimensions = "32x32"
	chance_none = 40

/obj/marker/prefab/antag
	icon = 'icons/obj/markers/prefab_antag.dmi'
	dimensions = "antag"
	chance_none = 50

/obj/marker/prefab/small
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	dimensions = "16x16"
	chance_none = 70

/obj/marker/prefab/boss
	icon = 'icons/obj/markers/prefab_boss.dmi'
	chance_none = 0

/obj/marker/prefab/boss/easy
	prefabs = list(
		"maps/prefabs/boss/broodmother.dmi",
		"maps/prefabs/boss/colossus.dmi",
		"maps/prefabs/boss/frog.dmi",
		"maps/prefabs/boss/goblin_king.dmi",
	)

/obj/marker/prefab/boss/medium
	prefabs = list(
		"maps/prefabs/boss/ash_drake.dmi",
		"maps/prefabs/boss/hierophant.dmi",
		"maps/prefabs/boss/herald.dmi",
	)

/obj/marker/prefab/boss/hard
	prefabs = list(
		"maps/prefabs/boss/bubblegum.dmi",
		"maps/prefabs/boss/can_man.dmi",
	)

/obj/marker/prefab/forrest
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	dimensions = "forest"
	chance_none = 25

/obj/marker/prefab/base
	icon = 'icons/obj/markers/prefab_64x64.dmi'
	dimensions = "base"
	chance_none = 0