/obj/structure/interactive/alchemy_plant
	//These "plants" dont consume reagents, and have no seed. Run much less code on think. No reagent containers allowed! Use a plant!
	name = "alchemy_plant"
	icon = 'icons/obj/structure/flora/alchemy_plant.dmi'
	icon_state = "error"
	desc = "Something something bootleg plant"
	desc_extended = "Some sort of wild plant."
	var/grown = TRUE
	var/harvest_item //What do we get for harvesting the plant?
	var/obj/item/collect_item //What do we need to COLLECT FROM the plant?
/obj/structure/interactive/alchemy_plant/proc/harvest(var/mob/living/advanced/caller)

	if(!grown)
		caller.to_chat(span("warning","\The [src.name] doesnt look ready to be harvested yet...."))
		return TRUE
	var/skill_power = caller.get_skill_power(SKILL_BOTANY,0,1,2)
	var/chance = prob(clamp(skill_power*0.80,10,100))
	if(!chance)
		caller.to_chat(span("warning","You fumble and ruin the harvest!"))
		caller.add_skill_xp(SKILL_BOTANY,3)
		grown = FALSE
		update_sprite()
		return TRUE
	if(harvest_item)
		var/obj/item/NH = new harvest_item(caller.loc)
		INITIALIZE(NH)
		GENERATE(NH)
		FINALIZE(NH)
		if(prob(clamp(skill_power*0.50,1,25)))
			caller.to_chat(span("notice","You carefully gather the [NH.name], but theres still more!"))
			caller.add_skill_xp(SKILL_BOTANY,10)
			return TRUE
		caller.to_chat(span("notice","You carefully gather the [NH.name],depleting it."))
		caller.add_skill_xp(SKILL_BOTANY,5)
		grown = FALSE
		update_sprite()
	return TRUE
/obj/structure/interactive/plant/on_destruction(var/mob/caller,var/damage = FALSE)
	SSbotany_alchemy.all_alchemy_plants -= src
	qdel(src)

/obj/structure/interactive/plant/New(var/desired_loc)
	SSbotany_alchemy.all_alchemy_plants += src
	. = ..()

/obj/structure/interactive/alchemy_plant/proc/on_life(var/tick_rate = 1)
	if(!grown)
		if(prob(1))
			grown = TRUE
			update_sprite()

/obj/structure/interactive/alchemy_plant/update_sprite()

	if(grown)
		icon_state = "[initial(icon_state)]"
	else
		icon_state = "[initial(icon_state)]_h"


/obj/structure/interactive/alchemy_plant/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()
	if(collect_item && !istype(object,collect_item))
		caller.to_chat(span("warning","You don't have the proper tool to collect from the [src.name] without damaging it! You need \a [initial(collect_item.name)]!"))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	harvest(caller)

	return TRUE

/obj/structure/interactive/alchemy_plant/forest_berry
	name = "forest berry bush"
	icon_state = "forest_berry"
	desc = "Magical!"
	desc_extended = "A large red berry bush, its fruit have healing energy. Could be useful in alchemy."
	harvest_item = /obj/item/crafting/ingredient/part/alchemy_plant/forest_berry
	collect_item = /obj/item/weapon/melee/tool/botany

/obj/structure/interactive/alchemy_plant/forest_nut
	name = "forest nut pile"
	icon_state = "forest_nut"
	desc = "Magical!"
	desc_extended = "A large pile of nuts, they have a defensive aura. Could be useful in alchemy."
	harvest_item = /obj/item/crafting/ingredient/part/alchemy_plant/forest_nut
	collect_item = /obj/item/weapon/melee/tool/botany

/obj/structure/interactive/alchemy_plant/snow_daisy
	name = "snow daisy patch"
	icon_state = "snow_daisy"
	desc = "Livingwood maker."
	desc_extended = "A patch of pure white flowers, bursting with mana. Could be useful in alchemy."
	harvest_item = /obj/item/crafting/ingredient/part/alchemy_plant/snow_daisy
	collect_item = /obj/item/weapon/melee/tool/botany

/obj/structure/interactive/alchemy_plant/space_cotton
	name = "space cotton"
	icon_state = "space_cotton"
	desc = "Something something racism"
	desc_extended = "A cotton like plant growing synthcloth. Probably a lateblooming seed, as most that dont grow instantly are defective."
	harvest_item = /obj/item/crafting/ingredient/thread/synthcloth

/obj/structure/interactive/alchemy_plant/devil_shroom
	name = "devils mushroom"
	icon_state = "devil_shroom"
	desc = "From a distant Rimworld"
	desc_extended = "A strange mushroom that grows a fiber-like cloth that is incredibly strong and fireproof."
	harvest_item = /obj/item/crafting/ingredient/thread/devilstrand
