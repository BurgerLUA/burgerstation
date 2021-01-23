/obj/structure/interactive/fountain
	name = "fountain"
	desc = "Stay awhile, and listen."
	desc_extended = "A magical fountain that can restore the energies of any being that activates it."

	icon = 'icons/obj/structure/fountain.dmi'
	icon_state = "fountain"

	var/fountain_type = 0
	//1 = health
	//2 = mana
	//3 = stamina

	var/filled = TRUE

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/fountain/Generate()

	if(!fountain_type)
		fountain_type = rand(1,3)

	return ..()

/obj/structure/interactive/fountain/get_examine_list(var/mob/examiner)

	. = ..()

	if(!filled)
		. += div("notice","It is empty.")

	return .

/obj/structure/interactive/fountain/Finalize()
	update_sprite()
	return ..()

/obj/structure/interactive/fountain/update_sprite()

	desc_extended = initial(desc_extended)

	switch(fountain_type)
		if(1)
			desc_extended = "[desc_extended] This one restores your health."
		if(2)
			desc_extended = "[desc_extended] This one restores your mana."
		if(3)
			desc_extended = "[desc_extended] This one restores your stamina."



	return ..()

/obj/structure/interactive/fountain/update_icon()

	icon_state = initial(icon_state)

	if(filled)
		switch(fountain_type)
			if(1)
				icon_state = "[icon_state]_health"
			if(2)
				icon_state = "[icon_state]_mana"
			if(3)
				icon_state = "[icon_state]_stamina"
			else
				set_light(FALSE)

	return ..()


/obj/structure/interactive/fountain/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	var/mob/living/L = caller

	if(filled)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		switch(fountain_type)
			if(1)
				L.brute_regen_buffer = max(L.brute_regen_buffer,200)
				L.burn_regen_buffer = max(L.burn_regen_buffer,200)
				L.tox_regen_buffer = max(L.tox_regen_buffer,200)
			if(2)
				L.mana_regen_buffer = max(L.mana_regen_buffer,600)
			if(3)
				L.stamina_regen_buffer = max(L.stamina_regen_buffer,600)
		visible_message(span("notice","\The [caller.name] activates \the [src.name]'s energies, replenishing themself."),span("notice","You activate \the [src.name]'s energies, replenishing yourself."))
		filled = FALSE
		update_sprite()
		return TRUE

	return ..()