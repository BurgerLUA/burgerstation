/obj/marker/prefab
	name = "prefab marker"
	icon = 'icons/obj/markers/prefab.dmi'
	icon_state = "yellow"

/obj/marker/prefab/New(var/desired_loc)
	SSdmm_suite.prefab_markers += src
	return ..()

/obj/marker/prefab/Destroy()
	SSdmm_suite.prefab_markers -= src
	return ..()