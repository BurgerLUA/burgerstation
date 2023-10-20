/obj/item/dice
	name = "dice"
	desc = "For people who like to game."
	desc_extended = "A perfectly crafted, absolutely even dice that cannot be influenced by external factors."
	icon = 'icons/obj/item/dice.dmi'
	icon_state = null

	var/max_states = 6

/obj/item/dice/update_underlays()
	var/image/I = new(icon,initial(icon_state))
	add_underlay(I)
	. = ..()

/obj/item/dice/update_icon()
	icon_state = "[initial(icon_state)]-[max_states]"
	. = ..()

/obj/item/dice/Finalize()
	. = ..()
	update_sprite()

/obj/item/dice/on_thrown(var/atom/owner,var/atom/hit_atom) //What happens after the person is thrown and it hits an object.
	roll_dice(owner)
	return ..()

/obj/item/dice/proc/on_result(var/mob/caller,var/chosen_number,var/silent=FALSE)

	if(!silent)
		if(caller)
			caller.visible_message(span("notice","\The [caller.name] rolls \the [src.name]. It lands on [chosen_number]."))
		else
			src.visible_message(span("notice","\The [src.name] rolls. It lands on [chosen_number]."))

	return TRUE

/obj/item/dice/proc/roll_dice(var/mob/caller,var/silent=FALSE)

	var/chosen_number = rand(1,max_states)

	on_result(caller,chosen_number,silent)

	icon_state = "[initial(icon_state)]-[chosen_number]"

	return TRUE

/obj/item/dice/click_self(var/mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	roll_dice(caller)

	return TRUE


/obj/item/dice/d6
	name = "d6"
	icon_state = "d6"
	max_states = 6

	value = 20

/obj/item/dice/d6/black
	icon_state = "de6"

	value = 20

/obj/item/dice/d20
	name = "d20"
	icon_state = "d20"
	max_states = 20

	value = 40

/obj/item/dice/d20/cursed
	name = "d20 of chance"
	icon_state = "d20_cursed"
	max_states = 20
	var/used = 0

	value = 2000

	value_burgerbux = 1

	rarity = RARITY_LEGENDARY

/obj/item/dice/d20/cursed/update_icon()
	. = ..()
	if(!used) icon_state = "blank"

/obj/item/dice/d20/cursed/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("used")

/obj/item/dice/d20/cursed/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("used")

/obj/item/dice/d20/cursed/roll_dice(var/mob/caller,var/silent=FALSE)

	if(used)
		icon_state = "[initial(icon_state)]-[used]"
		return TRUE

	return ..()

/obj/item/dice/d20/cursed/on_result(var/mob/caller,var/chosen_number,var/silent=FALSE)

	if(!caller || silent || !is_living(caller) || !caller.client)
		return ..()

	var/mob/living/L = caller

	. = ..()

	if(qdeleting) return

	used = TRUE

	// https://www.desmos.com/calculator/vivxdlctyz
	var/luck_to_add = ((chosen_number - 10)/10)*50

	if(luck_to_add)
		if(luck_to_add < 0)
			L.to_chat(span("warning","Uh oh."))
		else
			L.to_chat(span("notice","Yipee!"))
		L.add_attribute_xp(ATTRIBUTE_LUCK,luck_to_add)
	else
		L.to_chat(span("notice","Huh."))

	visible_message(span(luck_to_add >= 0 ? "notice" : "warning","\The [src.name] glows faintly..."))

/obj/item/dice/d2
	name = "d2"
	icon_state = "d2"
	max_states = 2

	value = 40

/obj/item/dice/d4
	name = "d4"
	icon_state = "d4"
	max_states = 4

	value = 40

/obj/item/dice/d8
	name = "d8"
	icon_state = "d8"
	max_states = 8

	value = 40

/obj/item/dice/d10
	name = "d10"
	icon_state = "d10"
	max_states = 10

	value = 40

/obj/item/dice/d00
	name = "d00"
	icon_state = "d00"
	max_states = 10

	value = 40

/obj/item/dice/d12
	name = "d12"
	icon_state = "d12"
	max_states = 12

	value = 40