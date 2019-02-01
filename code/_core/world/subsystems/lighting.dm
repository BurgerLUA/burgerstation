/datum/subsystem/lighting/
	name = "Lighting Subsystem"
	desc = "Controls the lighting."
	tick_rate = 100
	priority = SS_ORDER_LIGHTING

/datum/subsystem/lighting/on_life()
	if(lighting_controller)
		lighting_controller.update_icon()

	return TRUE