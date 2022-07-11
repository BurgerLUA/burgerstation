/obj/marker/prefab
	name = "prefab marker"
	var/category
	icon_state = null
	var/chance_none = 50
	var/list/prefabs = null

/obj/marker/prefab/New(var/desired_loc)

	if(!category) category = "none"

	if(chance_none <= 0 || !prob(chance_none))
		if(!SSdmm_suite.prefab_markers[category]) SSdmm_suite.prefab_markers[category] = list()
		SSdmm_suite.prefab_markers[category] += src
	. = ..()

/obj/marker/prefab/Destroy()
	SSdmm_suite.prefab_markers[category] -= src
	. = ..()

/obj/marker/prefab/large
	icon = 'icons/obj/markers/prefab_64x64.dmi'
	category = "64x64"
	chance_none = 20

/obj/marker/prefab/medium
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	category = "32x32"
	chance_none = 40

/obj/marker/prefab/antag
	icon = 'icons/obj/markers/prefab_antag.dmi'
	category = "antag"
	chance_none = 50

/obj/marker/prefab/small
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	category = "16x16"
	chance_none = 70

/obj/marker/prefab/house
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	category = "house"
	chance_none = 0

/obj/marker/prefab/boss
	icon = 'icons/obj/markers/prefab_boss.dmi'
	category = "boss"
	chance_none = 0

/obj/marker/prefab/boss/easy
	prefabs = list(
		"maps/prefabs/boss/colossus.dmi",
		"maps/prefabs/boss/frog.dmi",
		"maps/prefabs/boss/goblin_king.dmi",
	)

/obj/marker/prefab/boss/medium
	prefabs = list(
		"maps/prefabs/boss/ash_drake.dmi",
		"maps/prefabs/boss/hierophant.dmi",
		"maps/prefabs/boss/herald.dmi",
		"maps/prefabs/boss/broodmother.dmi",
	)

/obj/marker/prefab/boss/hard
	prefabs = list(
		"maps/prefabs/boss/bubblegum.dmi",
		"maps/prefabs/boss/can_man.dmi",
	)

/obj/marker/prefab/forest
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	category = "forest"
	chance_none = 25

/obj/marker/prefab/base
	icon = 'icons/obj/markers/prefab_64x64.dmi'
	category = "base"
	chance_none = 0