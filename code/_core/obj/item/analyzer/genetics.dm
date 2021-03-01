/obj/item/analyzer/genetic
	name = "genetic analyzer"
	desc = "HOLD STILL AND LET ME SEE YOUR GENES!"
	desc_extended = "A handheld portable genetic analyzer that prints the target's prominent genes."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/analyzers/genetic.dmi'
	icon_state = "inventory"
	value = 300

/obj/item/analyzer/genetic/can_be_scanned(var/mob/caller,var/atom/target)

	if(get_dist(caller,target) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	return is_living(target)


/obj/item/analyzer/genetic/on_scan(var/mob/caller,var/atom/target,location,control,params)

	caller.to_chat(span("notice bold underline","[target.name]'s Traits:"))

	var/list/list_to_print = list()
	var/mob/living/L = target
	for(var/k in L.traits)
		var/trait/T = TRAIT(k)
		list_to_print += T.name

	caller.to_chat(span("notice",english_list(list_to_print)))

	return TRUE