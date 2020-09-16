
var/global/list/all_reagent_recipes = list()

var/global/list/reagent_container/all_reagent_containers = list()

SUBSYSTEM_DEF(reagent)
	name = "Reagent Subsystem"
	desc = "Store all the reagents."
	priority = SS_ORDER_PRELOAD
	tick_rate = SECONDS_TO_TICKS(4)

	var/list/all_reagents = list()

	cpu_usage_max = 70
	tick_usage_max = 70

/subsystem/reagent/on_life()

	for(var/k in all_reagent_containers)
		var/reagent_container/R = k
		CHECK_TICK(tick_usage_max,FPS_SERVER*4)
		if(R.flags_temperature & REAGENT_TEMPERATURE_NO_AMBIENT)
			continue
		R.process_temperature()

	return ..()

/subsystem/reagent/Initialize()

	for(var/k in subtypesof(/reagent/))
		var/reagent/R = k
		R = new k
		all_reagents[R.type] = R

	log_subsystem(name,"Initialized [length(all_reagents)] reagents.")

	for(var/k in subtypesof(/reagent_recipe/))
		var/reagent_recipe/R = new k
		all_reagent_recipes[R.type] = R

	log_subsystem(name,"Initialized [length(all_reagent_recipes)] reagent recipes.")

	return ..()