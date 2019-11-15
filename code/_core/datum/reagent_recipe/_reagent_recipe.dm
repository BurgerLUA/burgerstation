/reagent_recipe/
	name = "reagent recipe"
	desc = "A recipe for a reagent."
	id = null

	var/list/required_reagents = list()

	var/list/results = list()

	var/atom/result

	var/list/required_temperature_min = list()

	var/list/required_temperature_max = list()


/reagent_recipe/proc/on_react(var/mob/caller,var/reagent_container/container,var/magnitude)
	return TRUE