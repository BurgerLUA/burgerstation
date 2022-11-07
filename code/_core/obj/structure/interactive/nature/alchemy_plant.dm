/obj/structure/interactive/alchemy_plant
	//These "plants" dont consume reagents, and have no seed. Run much less code on think. No reagent containers allowed! Use a plant!
	name = "alchemy_plant"
	icon = 'icons/obj/structure/flora/alchemy_plant.dmi'
	icon_state = "error"
	desc = "Something something alchemy reagent"
	desc_extended = "Some useful magical flora. Can be harveted with the right tools and knowledge."
	var/grown = TRUE
	var/harvest_item 
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
		src.update_sprite()
	return TRUE
/obj/structure/interactive/plant/on_destruction(var/mob/caller,var/damage = FALSE)
	SSbotany_alchemy.all_alchemy_plants -= src 
	qdel(src)

/obj/structure/interactive/plant/New(var/desired_loc)
	SSbotany_alchemy.all_alchemy_plants += src
	. = ..()

/obj/structure/interactive/alchemy_plant/proc/on_life(var/tick_rate = 1)
	if(!grown)
		if(prob(0.50))
			grown = TRUE
			src.update_sprite()

/obj/structure/interactive/alchemy_plant/update_sprite()
	
	if(grown)
		icon_state = "[initial(icon_state)]"
	else
		icon_state = "[icon]_h"


/obj/structure/interactive/alchemy_plant/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()
	if(!istype(object,/obj/item/weapon/melee/tool/botany) || !is_advanced(caller))
		caller.to_chat(span("warning","You don't have the proper tool to collect from the [src.name] without damaging it!"))
		return ..()
	
	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	harvest(caller)

	return TRUE

/obj/structure/interactive/alchemy_plant/forest_berry
	name = "forest berry bush"
	icon_state = "forest_berry"
	harvest_item = /obj/item/crafting/ingredient/part/alchemy_plant/forest_berry

/obj/structure/interactive/alchemy_plant/forest_nut
	name = "forest nut pile"
	icon_state = "forest_nut"
	harvest_item = /obj/item/crafting/ingredient/part/alchemy_plant/forest_nut

/obj/structure/interactive/alchemy_plant/snow_daisy
	name = "snow daisy patch"
	icon_state = "snow_daisy"
	harvest_item = /obj/item/crafting/ingredient/part/alchemy_plant/snow_daisy