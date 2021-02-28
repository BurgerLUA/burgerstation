#define GENETIC_INERT "inert"
#define GENETIC_UPGRADE "upgrade"
#define GENETIC_ADD "add"
#define GENETIC_SUBTRACT "subtract"
#define GENETIC_RANDOM "random"

//Common: 1 postive, 1 negative
//Uncommon 2 positive, 1 negative
//Rare: 3 positive, 2 negative
//Mythical: 4 positive, 2 negative
//Legendary: 5 positive, 2 negative

var/global/list/rarity_table = list(
	RARITY_COMMON = 12000,
	RARITY_UNCOMMON = 2400,
	RARITY_RARE = 1200,
	RARITY_MYTHICAL = 600,
	RARITY_LEGENDATY = 300
)

var/global/list/genetic_upgrade_table = list(
	GENETIC_ADD = 10000,
	GENETIC_RANDOM = 5000,
	GENETIC_SUBTRACT = 2500,
	GENETIC_UPGRADE = 1250
)

/obj/item/genetic_ball
	name = "genetic codeball"
	desc = "What could possibly go wrong?"
	desc_extended = "A spaceage artifact that modifies your genetic traits."

	rarity = RARITY_BROKEN //Rarity is randomly generated.

	var/action_type = GENETIC_INERT

	var/should_generate = TRUE

	value = 0

var/list/rarity_to_number = list(
	RARITY_BROKEN = 0,
	RARITY_COMMON = 1,
	RARITY_UNCOMMON = 2,
	RARITY_RARE = 3,
	RARITY_MYTHICAL = 4,
	RARITY_LEGENDARY = 5
)

/obj/item/genetic_ball/proc/do_upgrade(var/mob/living/caller)

	if(action_type == GENETIC_INERT)
		if(length(caller.traits))
			caller.remove_all_traits()
		else
			caller.rarity = RARITY_COMMON
		return TRUE

	switch(action_type)
		if(GENETIC_ADD)
			if(!caller.can_add_trait())
				caller.to_chat(span("warning","Failed to [src.name]: You have too many traits! Upgrade your genetic rarity or remove more positive traits to add more."))
				return FALSE
			if(caller.add_random_trait())
				caller.to_chat(span("warning","Failed to [src.name]: Code error. Report this bug on github."))
				return FALSE
			return TRUE
		if(GENETIC_RANDOM)
			caller.remove_all_traits()
			//We don't use add_random_trait() here because there is a chance it may add duplicate or same-category traits and cause spam messages.
			var/list/traits_to_add = list()
			var/list/existing_trait_categories = list()
			for(var/i=1,i<=get_trait_limit(rarity),i++)
				var/random_trait = pick(SStraits.all_traits)
				var/trait/T = SStraits.all_traits[random_trait]
				if(traits_to_add[random_trait])
					continue
				if(T.category)
					if(existing_trait_categories[T.category])
						continue
					existing_trait_categories[T.category] = TRUE
				traits_to_add[random_trait] = TRUE
				caller.add_trait(random_trait)
			return TRUE
		if(GENETIC_SUBTRACT)
			if(!length(caller.traits))
				caller.to_chat(span("warning","Failed to [src.name]: You don't have any traits to remove!"))
				return FALSE
			if(!caller.remove_random_trait())
				caller.to_chat(span("warning","Failed to [src.name]: Code error. Report this bug on github."))
				return FALSE

	return TRUE


/obj/item/genetic_ball/Finalize()

	. = ..()

	if(rarity == RARITY_BROKEN || action_type == GENETIC_INERT)
		name = "genetic ball of scouring"
		desc_extended = "[initial(desc_extended)] This one removes all genetic modifiers from your person. If you have no genetic modifiers, it downgrades your genetic rarity to common."
		rarity = RARITY_BROKEN
		action_type = GENETIC_INERT
		return .

	name = "[rarity] genetic ball of [action_type]"
	switch(action_type)
		if(GENETIC_ADD)
			desc_extended = "[initial(desc_extended)] This one adds a random trait to your genetic code, if possible. Must have a genetic rarity of [rarity] or lower to use, as well as space to add it."
		if(GENETIC_RANDOM)
			desc_extended = "[initial(desc_extended)] This one randomizes the traits of your genetic code, replacing your existing ones. Must have a genetic rarity of [rarity] or lower to use."
		if(GENETIC_SUBTRACT)
			desc_extended = "[initial(desc_extended)] This one removes a random trait from your genetic code. Must have a genetic rarity of [rarity] or lower to use."
		if(GENETIC_UPGRADE)
			desc_extended = "[initial(desc_extended)] This one upgrades your genetic rarity to [rarity] to allow for more modifiers. Must have a genetic rarity lower than [rarity] to use. Note that after upgrading your genetic rarity, you can only use [rarity] genetic balls or higher on your person."


/obj/item/genetic_ball/update_sprite()
	. = ..()
	color = "#FFFFFF"

	if(rarity == RARITY_BROKEN || action_type == GENETIC_INERT)
		name = "genetic ball of scouring"
		desc_extended = "[initial(desc_extended)] This one removes all genetic modifiers from your character. If you have no genetic modifiers, it downgrades your genetic rarity, if possible."
		rarity = RARITY_BROKEN
		action_type = GENETIC_INERT
		return .






/obj/item/genetic_ball/update_icon()
	. = ..()
	icon_state = "none"

/obj/item/genetic_ball/update_overlays()
	. = ..()
	var/image/I






/obj/item/genetic_ball/Generate()

	if(should_generate)
		rarity = pickweight(rarity_table)
		action_type = pickweight(genetic_upgrade_table)

	. = ..()

/obj/item/genetic_ball/get_value()

	. = ..()

	switch(rarity_table)
		if(RARITY_BROKEN)
			. += 100
		if(RARITY_COMMON)
			. += 100
		if(RARITY_UNCOMMON)
			. += 400
		if(RARITY_RARE)
			. += 1600
		if(RARITY_MYTHICAL)
			. += 6400
		if(RARITY_LEGENDARY)
			. += 25600

	switch(action_type)
		if(GENETIC_ADD)
			. *= 1
		if(GENETIC_SUBTRACT)
			. *= 0.75
		if(GENETIC_RANDOM)
			. *= 0.5
		if(GENETIC_UPGRADE)
			. *= 2





