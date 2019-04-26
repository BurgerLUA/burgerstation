/obj/structure/interactive/lootable/
	name = "Loot"
	desc = "Get your loot here!"
	var/loot_id = "basic"
	var/loot_chance = 100

/obj/structure/interactive/lootable/clicked_by_object(caller,object,location,control,params)

	INTERACT_CHECK

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	if(!A.client)
		return FALSE

	var/click_flags = A.client.get_click_flags(params,TRUE)

	var/list/callback_list = list()
	callback_list["object"] = src
	callback_list["start_turf"] = get_turf(caller)
	callback_list["left"] = click_flags & RIGHT_HAND
	add_progress_bar(caller,"loot_object",10,callback_list)

	return TRUE

/obj/structure/interactive/lootable/proc/give_items(var/mob/living/advanced/A,var/left_hand = FALSE)

	if(prob(loot_chance))
		var/loot/L = all_loot[loot_id]
		var/obj/item/I = L.spawn_loot_advanced(A,left_hand)
		A.to_chat(span("notice","You found \a [I] in \the [src]!"))
	else
		A.to_chat(span("notice","You failed to find anything in \the [src]."))

	return TRUE

/obj/structure/interactive/lootable/starting/
	name = "your belongings"
	desc = "Your stuff!"

/obj/structure/interactive/lootable/starting/give_items(var/mob/living/advanced/A)
	return TRUE


/obj/structure/interactive/lootable/bush/
	name = "village bush"
	icon = 'icons/obj/structure/flora/ausflora.dmi'
	icon_state = "grassybush_1"
	desc = "Maybe something is in here?"
	desc_extended = "Bushes, next to sewer drains, are common areas where people may lose their items. Doesn't hurt to scavange when you need to."

	loot_id = "village_bush"
	loot_chance = 50

/obj/structure/interactive/lootable/bush/New(var/desired_loc)
	..()
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(255,255,0))

