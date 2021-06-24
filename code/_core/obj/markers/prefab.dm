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
	dimensions = "boss"
	chance_none = 0


/obj/marker/prefab/forrest
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	dimensions = "forest"
	chance_none = 25
