#define FLAG_REAGENT_RAW 0x1
#define FLAG_REAGENT_COOKED 0x2
#define FLAG_REAGENT_FAT 0x4

#define METABOLISM_BLOOD 1
#define METABOLISM_STOMACH METABOLISM_BLOOD * 0.5
#define METABOLISM_SKIN METABOLISM_BLOOD * 4

/reagent/
	var/name = "Reagent"
	var/desc = "The basic description of the reagent."
	var/desc_extended = "The extended description of the reagent, usually a detailed note of its effects."
	var/value = 0 //Value per unit.

	var/color = "#FFFFFF" //Reagent's color.
	var/alpha = 255 //Reagent's alpha

	var/temperature_mod = 0.3 //Lower is more reactive. Higher is less reactive.

	var/metabolism_stomach = METABOLISM_STOMACH //How many units of the reagent to metabolize per second.
	var/metabolism_blood = METABOLISM_BLOOD //How many units of the reagent to metabolize per second.
	var/metabolism_skin = METABOLISM_SKIN //How many units of the reagent to metabolize per second.
	var/overdose_threshold = 0 //More than this is considered an overdose. Set to 0 to ignore overdose.

	var/flags_metabolism = REAGENT_METABOLISM_INGEST | REAGENT_METABOLISM_BLOOD | REAGENT_METABOLISM_SKIN

	var/liquid = 0 //What percentage of this reagent is a liquid? Accepts values -1 to 1, where -1 is dry as fuck and 1 is wet as fuck.

	var/flavor = "nothing"
	var/flavor_strength = 1
	var/flags_flavor = FLAG_FLAVOR_NONE

	var/processed_reagent

	var/heated_reagent //What this heats into.
	var/heated_reagent_temp //Temperature required to heat
	var/heated_reagent_amount //Amount (units) to add per reagent tick.
	var/heated_reagent_mul //Percentage (0-1) of the total volume to add in reagents per tick.
	var/cooled_reagent //What this cools inot.
	var/cooled_reagent_temp //Temperature required to cool.
	var/cooled_reagent_amount //Amount (units) to add per reagent tick.
	var/cooled_reagent_mul //Percentage (0-1) of the total volume to add in reagents per tick.

	var/lethal = FALSE //Used by loyalty tags, checks if this reagent is lethal or not. TODO: WIP

	var/flags_reagent

	var/addiction/addiction
	var/addiction_strength = 1 //Percent chance to become addicted per unit.
	var/addiction_threshold = 30 //The percent chance needs to be greater than this value to be considered addicted.

/reagent/proc/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0,var/mob/living/caller)
	return amount_added

/reagent/proc/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0,var/mob/living/caller)

	if(addiction && is_advanced(L))
		var/mob/living/advanced/A = L
		var/addiction_value = (amount_added+current_volume)*addiction_strength
		if(addiction_value >= addiction_threshold && A.labeled_organs[BODY_BRAIN])
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

/reagent/proc/metabolize(var/atom/originial_owner,var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	var/container_flags_metabolism = container.flags_metabolism

	var/total_metabolized = 0

	if(starting_volume >= 0 && container_flags_metabolism & REAGENT_METABOLISM_BLOOD)
		total_metabolized += on_metabolize_blood(owner,container,starting_volume,multiplier)

	if(starting_volume >= 0 && container_flags_metabolism & REAGENT_METABOLISM_INGEST)
		total_metabolized += on_metabolize_stomach(owner,container,starting_volume,multiplier)

	if(starting_volume >= 0 && container_flags_metabolism & REAGENT_METABOLISM_SKIN)
		total_metabolized += on_metabolize_skin(owner,container,starting_volume,multiplier)

	if(overdose_threshold && starting_volume >= overdose_threshold)
		total_metabolized += on_overdose(originial_owner,owner,container,starting_volume,multiplier,total_metabolized)

	return total_metabolized

/reagent/proc/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	return metabolism_stomach * DECISECONDS_TO_SECONDS(LIFE_TICK_SLOW)

/reagent/proc/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	return metabolism_blood * DECISECONDS_TO_SECONDS(LIFE_TICK_SLOW)

/reagent/proc/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)
	return metabolism_skin * DECISECONDS_TO_SECONDS(LIFE_TICK_SLOW)

/reagent/proc/on_overdose(var/atom/original_owner,var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1,var/metabolism_amount=0)
	return metabolism_amount * DECISECONDS_TO_SECONDS(LIFE_TICK_SLOW)

/reagent/proc/on_splash(var/reagent_container/container,var/mob/caller,var/atom/target,var/volume_to_splash,var/strength_mod=1)
	return TRUE