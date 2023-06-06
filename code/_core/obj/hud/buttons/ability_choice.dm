/proc/show_ability_choices(var/mob/living/advanced/A,var/obj/structure/interactive/ability_machine/machine)

	var/list/categorized_abilities = list()

	for(var/j in machine.ability_types)
		for(var/k in typesof(j))
			var/ability/AB = k
			var/category = initial(AB.category)
			if(!category)
				continue
			if(!categorized_abilities[category])
				categorized_abilities[category] = list()
			categorized_abilities[category] += AB

	var/obj/hud/button/close_ability_choice/C = new
	C.linked_machine = machine

	var/list/abilitiy_buttons = list()
	var/max_x = 0
	var/y=0
	for(var/category in categorized_abilities)
		var/list/list_of_abilities = categorized_abilities[category]
		var/x=0
		var/obj/hud/button/CB = new
		CB.icon_state = "none"
		CB.maptext = "[category]"
		CB.maptext_width = TILE_SIZE*2
		CB.update_owner(A)
		CB.screen_loc = "LEFT+1.5:8,TOP-1.75-[y]"
		y += 0.75
		abilitiy_buttons += CB
		for(var/ability in list_of_abilities)
			var/ability/AB = ability
			var/obj/hud/button/ability_choice/B = new
			B.name = initial(AB.name)
			B.desc_extended = initial(AB.desc)
			B.stored_ability = AB
			B.screen_loc = "LEFT+2+[x],TOP-2-[y]"
			B.linked_close = C
			B.update_owner(A)
			abilitiy_buttons += B
			x += 1.25
		max_x = max(max_x,x)
		y += 0.75

	C.screen_loc = "LEFT+1,TOP-2.75"
	C.linked_buttons = abilitiy_buttons
	C.alpha = 0
	C.invisibility = 101
	C.update_owner(A)

	return TRUE


/obj/hud/button/ability_choice
	name = "ability choice"

	var/unlocked = TRUE
	var/selected = FALSE

	var/ability/stored_ability

	icon_state = "square_round"

	var/obj/hud/button/close_ability_choice/linked_close


/obj/hud/button/ability_choice/Destroy()
	. = ..()
	linked_close = null


/obj/hud/button/ability_choice/update_overlays()

	. = ..()

	if(stored_ability)
		var/image/I = new/image(initial(stored_ability.icon),initial(stored_ability.icon_state))
		add_overlay(I)
		name = initial(stored_ability.name)
		desc_extended = initial(stored_ability.desc)
	else
		name = initial(src.name)
		desc_extended = initial(src.desc_extended)

	if(selected)
		var/image/I = new/image(initial(icon),"square_round_selected")
		add_overlay(I)

/obj/hud/button/ability_choice/update_sprite()

	selected = FALSE
	unlocked = FALSE

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		for(var/k in A.ability_buttons)
			var/obj/hud/button/ability/B = A.ability_buttons[k]
			if(!B.ability)
				continue
			if(B.ability.type != stored_ability)
				continue
			selected = TRUE
			break
		if(A.ckey)
			var/savedata/client/globals/GD = GLOBALDATA(A.ckey)
			if("[src.stored_ability]" in GD.loaded_data["unlocked_abilities"])
				unlocked = TRUE

	. = ..()

	if(!unlocked)
		color = greyscale
	else if(!is_advanced(owner))
		color = redscale
	else
		color = initial(color)


/obj/hud/button/ability_choice/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	caller.to_chat(span("notice","Click and drag to an ability slot at the top left to slot this ability."))
	return TRUE



/obj/hud/button/ability_choice/proc/can_slot_ability(var/mob/caller,var/ability/ability_to_replace)

	if(!is_advanced(owner))
		return FALSE

	var/mob/living/advanced/A = owner

	if(get_dist(linked_close.linked_machine,A) >= 2)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	if(!unlocked)
		caller.to_chat(span("warning","You have not unlocked this ability yet. Abilities can be unlocked by purchasing them in Science or by finding them in the mission area."))
		return FALSE

	var/src_ability_category = initial(stored_ability.category)

	if(ability_to_replace && ability_to_replace.category == src_ability_category)
		return TRUE

	for(var/k in A.ability_buttons)
		var/obj/hud/button/ability/B = A.ability_buttons[k]
		if(B.ability && B.ability.category == src_ability_category)
			caller.to_chat(span("warning","You cannot have more than one ability of the same category in your genetics."))
			return FALSE

	return TRUE


/obj/hud/button/ability_choice/drop_on_object(var/mob/caller,var/atom/object,location,control,params) //Src is dragged to object

	if(istype(object,/obj/hud/button/ability))
		var/obj/hud/button/ability/B = object

		if(!can_slot_ability(caller,B.ability))
			return TRUE

		var/old_ability_name
		if(B.ability)
			old_ability_name = B.ability.name
			qdel(B.ability)
			B.ability = null
		B.ability = new stored_ability
		B.update_sprite()
		if(old_ability_name)
			caller.to_chat(span("notice","You replace [old_ability_name] with [B.ability.name]."))
		else
			caller.to_chat(span("notice","You add [B.ability.name] to genetics."))
		var/obj/hud/button/close_ability_choice/C = src.linked_close
		for(var/k in C.linked_buttons)
			var/obj/hud/button/OB = k
			OB.update_sprite()

	return ..()


/obj/hud/button/close_ability_choice
	name = "close ability choice"
	icon_state = "square_round"
	var/list/linked_buttons
	var/obj/structure/interactive/ability_machine/linked_machine

	icon_state = "close"


/obj/hud/button/close_ability_choice/update_owner(var/mob/desired_owner)

	if(owner)
		HOOK_REMOVE("post_move","\ref[src]_check_distance",owner)

	. = ..()

	if(owner)
		HOOK_ADD("post_move","\ref[src]_check_distance",owner,src,src::check_distance())


/obj/hud/button/close_ability_choice/proc/check_distance()
	if(get_dist(owner,linked_machine) > 1)
		update_owner(null)



/obj/hud/button/close_ability_choice/Destroy()
	. = ..()
	linked_buttons.Cut()

/obj/hud/button/close_ability_choice/update_owner(var/mob/desired_owner)
	for(var/k in linked_buttons)
		var/obj/hud/button/B = k
		B.update_owner(desired_owner)
	. = ..()

/obj/hud/button/close_ability_choice/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	. = ..()
	update_owner(null)