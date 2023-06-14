/obj/item/fertilizer
	name = "plant-b-grown fertilizer"
	desc = "The best space-age fertilizer in the galaxy."
	desc_extended = "A large bag of fertilizer that's enough to cover one square meter of tile with extra-powerful fast-growing fertilizer."
	icon = 'icons/obj/item/fertilizer.dmi'
	icon_state = "inventory"

	var/uses_left = 1
	var/turf/simulated/turf_type = /turf/simulated/floor/colored/dirt/soil/rich

	value = 200

	rarity = RARITY_UNCOMMON

/obj/item/fertilizer/get_base_value()
	return 20 + initial(value) * uses_left

/obj/item/fertilizer/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("uses_left")

/obj/item/fertilizer/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("uses_left")

/obj/item/fertilizer/Finalize()
	. = ..()
	update_sprite()

/obj/item/fertilizer/update_icon()
	. = ..()
	icon_state = initial(icon_state)
	if(uses_left <= 0)
		icon_state = "[icon_state]_empty"


/obj/item/fertilizer/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/structure/interactive/plant))
		object = object.loc

	if(!istype(object,/turf/simulated/floor/))
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(uses_left <= 0)
		caller.to_chat(span("warning","There is no more fertilizer left!"))
		return TRUE

	if(ispath(object.type,turf_type))
		caller.to_chat(span("notice","This turf already has soil!"))
		return TRUE

	var/turf/simulated/floor/T = object
	var/old_type = T.type

	caller.visible_message(span("notice","\The [caller.name] pours \the [src.name] on \the [T.name], adding soil."))

	T.change_turf(turf_type)
	T.destruction_turf = old_type

	uses_left--

	update_sprite()

	return TRUE

