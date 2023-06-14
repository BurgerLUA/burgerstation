/reagent/
	var/name = "Reagent"
	var/desc = "The basic description of the reagent."
	var/desc_extended = "The extended description of the reagent, usually a detailed note of its effects."
	var/value = 0 //Value per unit.

	var/color = "#FFFFFF" //Reagent's color.
	var/color_multiplier = 1
	var/alpha = 255 //Reagent's alpha

	var/temperature_mod = 0.3 //Lower is more reactive. Higher is less reactive. Set to higher values if you want it to cool down and heat up slower.

	var/metabolism_stomach = 1 //How many units of the reagent to metabolize per second.
	var/metabolism_blood = 1 //How many units of the reagent to metabolize per second.
	var/metabolism_skin = 1 //How many units of the reagent to metabolize per second.
	var/metabolism_plant = 1 //How many units of the reagent to metabolize per second.
	var/overdose_threshold = 0 //More than this is considered an overdose. Set to 0 to ignore overdose.

	var/liquid = 0 //What percentage of this reagent is a liquid? Accepts values -1 to 1, where -1 is dry as fuck and 1 is wet as fuck.

	var/flags_reagent = FLAG_REAGENT_NONE

	var/flags_metabolism = REAGENT_METABOLISM_NONE

	var/flags_flavor = FLAG_FLAVOR_NONE
	var/flavor = "nothing"
	var/flavor_strength = 1


	var/processed_reagent

	var/obj/item/poured_container //The container to make when this object is poured/splashed. This is all handled in reagent_container.

	var/particle_size = 0.5 //0 to 1

	var/heated_reagent //What this heats into.
	var/heated_reagent_temp //Temperature required to heat
	var/heated_reagent_amount //Amount (units) to add per reagent tick.
	var/heated_reagent_mul //Percentage (0-1) of the total volume to add in reagents per tick.
	var/cooled_reagent //What this cools into.
	var/cooled_reagent_temp //Temperature required to cool.
	var/cooled_reagent_amount //Amount (units) to add per reagent tick.
	var/cooled_reagent_mul //Percentage (0-1) of the total volume to add in reagents per tick.

	var/lethal = FALSE //Used by loyalty and charcoal checks if this reagent is lethal or not.

	var/addiction/addiction
	var/addiction_strength = 1 //Percent chance to become addicted per maximium amount taken.
	var/addiction_threshold = 30 //The percent chance needs to be greater than this value to be considered addicted.

	var/blood_toxicity_multiplier = 0 //How much blood toxicity to add per unit metabolized.

	var/list/involved_in_recipes
	var/has_temperature_recipe = FALSE

	var/abstract = FALSE //Set to true so its not calculated in reagent additions. Note that abstract reagents can only be removed directly.

	var/bypass_small_limit = FALSE //Set to true if this reagent ignores the metabolism cap of 1u minimum.

/reagent/proc/get_flammability()
	return 0


/reagent/New(var/desired_loc)

	if(metabolism_stomach > 0 && metabolism_stomach < REAGENT_ROUNDING)
		log_error("Warning: [src.type] had too low of a metabolism_stomach value ([metabolism_stomach]) and was adjusted to [REAGENT_ROUNDING].")
		metabolism_stomach = max(metabolism_stomach,REAGENT_ROUNDING)

	if(metabolism_blood > 0 && metabolism_blood < REAGENT_ROUNDING)
		log_error("Warning: [src.type] had too low of a metabolism_blood value ([metabolism_blood]) and was adjusted to [REAGENT_ROUNDING].")
		metabolism_blood = max(metabolism_blood,REAGENT_ROUNDING)

	if(metabolism_skin > 0 && metabolism_skin < REAGENT_ROUNDING)
		log_error("Warning: [src.type] had too low of a metabolism_skin value ([metabolism_skin]) and was adjusted to [REAGENT_ROUNDING].")
		metabolism_stomach = max(metabolism_skin,REAGENT_ROUNDING)

	. = ..()

/reagent/proc/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0,var/mob/living/caller)
	return amount_added

/reagent/proc/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0,var/mob/living/caller)

	if(addiction && is_advanced(L))
		var/mob/living/advanced/A = L
		var/addiction_value = (amount_added+current_volume)
		if(addiction_value >= addiction_threshold && A.labeled_organs[BODY_BRAIN])
			addiction_value *= addiction_strength
			var/obj/item/organ/internal/brain/B = A.labeled_organs[BODY_BRAIN]
			var/addiction/D = SSliving.stored_addictions[addiction]
			if(isnull(B.addictions[addiction]))
				B.addictions[addiction] = addiction_value
				B.withdrawal[addiction] = 0
				D.on_add_initial(A,B,B.addictions[addiction],B.withdrawal[addiction])
			else
				B.addictions[addiction] = max(B.addictions[addiction],addiction_value)
				B.withdrawal[addiction] = max(0,B.withdrawal[addiction]-amount_added)
				D.on_add(A,B,B.addictions[addiction],B.withdrawal[addiction])

	return amount_added

/reagent/proc/on_remove(var/reagent_container/container)
	return TRUE

/reagent/proc/on_remove_living(var/mob/living/L,var/reagent_container/container)
	return TRUE

/reagent/proc/on_metabolize_stomach(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	return amount_to_metabolize

/reagent/proc/on_metabolize_plant(var/obj/structure/interactive/plant/plant,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	world.log << "amount_to_metabolize: [amount_to_metabolize]"
	return amount_to_metabolize

/reagent/proc/on_metabolize_blood(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	return amount_to_metabolize

/reagent/proc/on_metabolize_skin(var/mob/living/owner,var/reagent_container/container,var/amount_to_metabolize=0,var/starting_volume=0,var/multiplier=1)
	return amount_to_metabolize

/reagent/proc/on_overdose(var/mob/living/owner,var/reagent_container/container,var/metabolism_amount=0,var/starting_volume=0,var/multiplier=1)
	return 0 //This is the amount to actually remove.

/reagent/proc/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)
	return TRUE

/reagent/proc/act_explode(var/reagent_container/container,var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag) //What happens when this reagent is hit by an explosive.
	return TRUE

/reagent/proc/on_temperature_change(var/reagent_container/container,var/atom/owner)
	return TRUE