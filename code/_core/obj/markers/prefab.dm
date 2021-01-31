/obj/marker/prefab
	name = "prefab marker"
	var/dimensions = null
	icon_state = null

/obj/marker/prefab/New(var/desired_loc)
	if(dimensions)
		if(!SSdmm_suite.prefab_markers[dimensions]) SSdmm_suite.prefab_markers[dimensions] = list()
		SSdmm_suite.prefab_markers[dimensions] += src
	return ..()

/obj/marker/prefab/Destroy()
	if(dimensions)
		SSdmm_suite.prefab_markers[dimensions] -= src
	return ..()


/obj/marker/prefab/large
	icon = 'icons/obj/markers/prefab_64x64.dmi'
	dimensions = "64x64"

/obj/marker/prefab/medium
	icon = 'icons/obj/markers/prefab_32x32.dmi'
	dimensions = "32x32"

/obj/marker/prefab/antag
	icon = 'icons/obj/markers/prefab_antag.dmi'
	dimensions = "antag"

/obj/marker/prefab/small
	icon = 'icons/obj/markers/prefab_16x16.dmi'
	dimensions = "16x16"