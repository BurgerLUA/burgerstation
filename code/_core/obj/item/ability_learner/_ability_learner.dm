/obj/item/ability_learner

	name = "ability scroll"
	desc = "I've finally found it."
	desc_extended = "Error."

	icon = 'icons/obj/item/books.dmi'
	icon_state = "scroll"

	rarity = RARITY_UNCOMMON

	var/ability/stored_ability

	value = 0

/obj/item/ability_learner/Finalize()
	. = ..()
	if(!stored_ability)
		log_error("Warning: Tried creating an empty [src.get_debug_name()]!")
		qdel(src)
	update_sprite()

/obj/item/ability_learner/get_base_value()
	if(!stored_ability)
		return 0
	. = ..()

/obj/item/ability_learner/update_sprite()
	. = ..()
	if(name == "ability scroll")
		name = "ability scroll: [initial(stored_ability.name)]"

/obj/item/ability_learner/update_overlays()
	. = ..()
	if(icon_state == "scroll" && stored_ability)
		var/image/I = new/image(initial(stored_ability.icon),initial(stored_ability.icon_state))
		add_overlay(I)

/obj/item/ability_learner/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	PROGRESS_BAR(caller,src,30,src::learn(),caller)
	PROGRESS_BAR_CONDITIONS(caller,src,src::can_learn(),caller)

	caller.to_chat(span("notice","You look into \the [src.name] and begin learning about [initial(stored_ability.name)]..."))

	return TRUE


/obj/item/ability_learner/proc/can_learn(var/mob/living/advanced/A)

	if(!A.loc || !is_inventory(src.loc))
		return FALSE

	var/obj/hud/inventory/I = src.loc
	if(I.owner != A)
		return FALSE

	if(!I.click_flags)
		return FALSE

	return TRUE


/obj/item/ability_learner/proc/learn(var/mob/living/advanced/A)

	if(!stored_ability || !A.ckey) //Something went wrong.
		return FALSE

	var/savedata/client/globals/GD = GLOBALDATA(A.ckey)

	if(!GD.loaded_data["unlocked_abilities"])
		GD.loaded_data["unlocked_abilities"] = list()
	else if("[stored_ability]" in GD.loaded_data["unlocked_abilities"]) //stored_ability is a path.
		A.to_chat(span("warning","You've already know [initial(stored_ability.name)]!"))
		return FALSE

	GD.loaded_data["unlocked_abilities"] += "[stored_ability]" //stored_ability is a path.
	A.to_chat(span("notice","You learn everything you can about [initial(stored_ability.name)] from \the [src.name] before it fades to dust.."))
	stored_ability = null
	qdel(src)

	return TRUE