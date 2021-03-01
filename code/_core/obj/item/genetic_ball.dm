#define GENETIC_INERT "purging"
#define GENETIC_UPGRADE "upgrading"
#define GENETIC_ADD "exalting"
#define GENETIC_SUBTRACT "splicing"
#define GENETIC_RANDOM "scrambling"

var/global/list/rarity_table = list(
	RARITY_COMMON = 12000,
	RARITY_UNCOMMON = 2400,
	RARITY_RARE = 1200,
	RARITY_MYTHICAL = 600,
	RARITY_LEGENDARY = 300
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

	icon = 'icons/obj/item/genetic_ball.dmi'
	icon_state = "ball"

	rarity = RARITY_BROKEN //Rarity is randomly generated.

	var/action_type = GENETIC_INERT

	var/should_generate = TRUE

	value = 0
	value_burgerbux = 1 //Not in normal loot rotation.

/obj/item/genetic_ball/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("action_type")
	SAVEVAR("rarity")

/obj/item/genetic_ball/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("action_type")
	LOADVAR("rarity")

var/global/list/rarity_to_number = list(
	RARITY_BROKEN = 0,
	RARITY_COMMON = 1,
	RARITY_UNCOMMON = 2,
	RARITY_RARE = 3,
	RARITY_MYTHICAL = 4,
	RARITY_LEGENDARY = 5
)

/obj/item/genetic_ball/click_self(var/mob/caller)

	if(is_living(caller))
		var/mob/living/L = caller
		do_upgrade(L)

	return TRUE

/obj/item/genetic_ball/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(caller == object)
		click_self(caller)
		return TRUE


	. = ..()

/obj/item/genetic_ball/proc/do_upgrade(var/mob/living/caller)

	if(action_type == GENETIC_INERT)
		if(length(caller.traits))
			caller.remove_all_traits()
		else
			caller.rarity = RARITY_COMMON
		return TRUE

	if(rarity_to_number[caller.rarity] > rarity_to_number[src.rarity])
		caller.to_chat(span("warning","Failed to use the [src.name]: Your genetic rarity is high than the rarity of the [src.name]."))
		return FALSE

	caller.to_chat(span("notice","You try to apply \the [src.name] to yourself..."))

	switch(action_type)
		if(GENETIC_UPGRADE)
			if(caller.rarity == src.rarity)
				caller.to_chat(span("warning","Failed to use the [src.name]: Your genetic rarity is already [src.rarity]!"))
				return FALSE
			caller.rarity = src.rarity
			caller.to_chat(span("notice","Your genetic rarity was upgraded to [caller.rarity]."))
		if(GENETIC_ADD)
			if(!caller.can_add_trait())
				caller.to_chat(span("warning","Failed to use the [src.name]: You have too many traits! Upgrade your genetic rarity or remove more positive traits to add more."))
				return FALSE
			if(!caller.add_random_trait())
				caller.to_chat(span("warning","Failed to use the [src.name]: Code error. Report this bug on github."))
				return FALSE
		if(GENETIC_RANDOM)
			caller.remove_all_traits()
			//We don't use add_random_trait() here because there is a chance it may add duplicate or same-category traits and cause spam messages.
			var/list/traits_to_add = list()
			var/list/existing_trait_categories = list()
			for(var/i=1,i<=get_trait_limit(caller.rarity),i++)
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
		if(GENETIC_SUBTRACT)
			if(!length(caller.traits))
				caller.to_chat(span("warning","Failed to [src.name]: You don't have any traits to remove!"))
				return FALSE
			if(!caller.remove_random_trait())
				caller.to_chat(span("warning","Failed to [src.name]: Code error. Report this bug on github."))
				return FALSE

	qdel(src)

	return TRUE


/obj/item/genetic_ball/Finalize()

	. = ..()

	if(rarity == RARITY_BROKEN || action_type == GENETIC_INERT)
		name = "genetic orb of scouring"
		desc_extended = "[initial(desc_extended)] This one removes all genetic modifiers from your person. If you have no genetic modifiers, it downgrades your genetic rarity to common."
		rarity = RARITY_BROKEN
		action_type = GENETIC_INERT
		return .

	if(action_type == GENETIC_UPGRADE && rarity == RARITY_COMMON)
		rarity = RARITY_UNCOMMON

	name = "[rarity] genetic orb of [action_type]"
	switch(action_type)
		if(GENETIC_ADD)
			desc_extended = "[initial(desc_extended)] This one adds a random trait to your genetic code, if possible. Must have a genetic rarity of [rarity] or lower to use, as well as space to add it."
		if(GENETIC_RANDOM)
			desc_extended = "[initial(desc_extended)] This one randomizes the traits of your genetic code, removing your existing ones and giving you new ones with the maximium amount based on your maximum allowed genetic traits. Must have a genetic rarity of [rarity] or lower to use."
		if(GENETIC_SUBTRACT)
			desc_extended = "[initial(desc_extended)] This one removes a random trait from your genetic code. Must have a genetic rarity of [rarity] or lower to use."
		if(GENETIC_UPGRADE)
			desc_extended = "[initial(desc_extended)] This one upgrades your genetic rarity to [rarity] to allow for more modifiers. Must have a genetic rarity lower than [rarity] to use. Note that after upgrading your genetic rarity, you can only use [rarity] genetic balls or higher on your person."

	value = 0
	switch(rarity_table)
		if(RARITY_BROKEN)
			value += 100
		if(RARITY_COMMON)
			value += 100
		if(RARITY_UNCOMMON)
			value += 400
		if(RARITY_RARE)
			value += 1600
		if(RARITY_MYTHICAL)
			value += 6400
		if(RARITY_LEGENDARY)
			value += 25600

	switch(action_type)
		if(GENETIC_ADD)
			value *= 1
		if(GENETIC_SUBTRACT)
			value *= 0.75
		if(GENETIC_RANDOM)
			value *= 0.5
		if(GENETIC_UPGRADE)
			value *= 2
		if(GENETIC_INERT)
			value *= 0.25

	value = CEILING(value,100)

	update_sprite()

/obj/item/genetic_ball/update_sprite()
	. = ..()
	color = "#FFFFFF"

/obj/item/genetic_ball/update_icon()
	. = ..()
	icon_state = "none"

/obj/item/genetic_ball/update_overlays()
	. = ..()
	if(action_type != GENETIC_INERT)
		var/image/I = new(initial(icon),"ball_detail")
		switch(action_type)
			if(GENETIC_ADD)
				I.color = COLOR_GREEN
			if(GENETIC_SUBTRACT)
				I.color = COLOR_RED
			if(GENETIC_RANDOM)
				I.color = COLOR_PURPLE
			if(GENETIC_UPGRADE)
				I.color = COLOR_GOLD
		add_overlay(I)

/obj/item/genetic_ball/update_underlays()
	. = ..()
	var/image/I = new(initial(icon),"ball")
	switch(rarity)
		if(RARITY_BROKEN)
			I.color = COLOR_BROKEN
		if(RARITY_COMMON)
			I.color = COLOR_COMMON
		if(RARITY_UNCOMMON)
			I.color = COLOR_UNCOMMON
		if(RARITY_RARE)
			I.color = COLOR_RARE
		if(RARITY_MYTHICAL)
			I.color = COLOR_MYTHICAL
		if(RARITY_LEGENDARY)
			I.color = RARITY_LEGENDARY
	add_underlay(I)





/obj/item/genetic_ball/Generate()

	if(should_generate)
		rarity = pickweight(rarity_table)
		action_type = pickweight(genetic_upgrade_table)

	. = ..()