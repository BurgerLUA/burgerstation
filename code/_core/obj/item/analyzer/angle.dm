var/global/list/gps_list = list()

/obj/item/analyzer/gps
	name = "gps"
	desc = "Where are you?"
	desc_extended = "A highly advanced gps and rangefinder that can get the location of the turf that you scan."

	icon = 'icons/obj/item/analyzers/gps.dmi'
	icon_state = "inventory"
	value = 300
	var/assigned_name
	var/assigned_passkey
	var/secure = FALSE
	var/advanced = FALSE
	var/loadedFromFile = FALSE

	rarity = RARITY_UNCOMMON

/obj/item/analyzer/gps/get_base_value()
	. = ..()
	if(secure)
		. += 100
	if(advanced)
		. += 200

/obj/item/analyzer/gps/Finalize()
	. = ..()
	gps_list += src
	if(!assigned_name)
		assigned_name = "\ref[src]"
	if(advanced && !assigned_passkey)
		assigned_passkey = "[lowertext(pick(SStext.first_names_male))]2"
	update_sprite()

/obj/item/analyzer/gps/update_sprite()
	. = ..()
	name = "[initial(name)] ([assigned_name])"

/obj/item/analyzer/gps/get_examine_list(mob/examiner)
	. = ..()
	if(assigned_passkey)
		. += div("notice", "The assigned_passkey is: [assigned_passkey]")

/obj/item/analyzer/gps/PreDestroy()
	gps_list -= src
	. = ..()

/obj/item/analyzer/gps/can_be_scanned(var/mob/caller,var/atom/target)
	return is_turf(target) || (target.loc && is_turf(target.loc))

/obj/item/analyzer/gps/on_scan(var/mob/caller,var/atom/target,location,control,params)

	if(!target)
		caller.to_chat(span("warning","Invalid target!"))
		return FALSE
	caller.to_chat(span("notice","Distance: [get_dist_advanced(caller,target)] tiles."))
	caller.to_chat(span("notice","Position: ([target.x],[target.y],[target.z])."))
	next_scan = world.time + SECONDS_TO_DECISECONDS(2)

	return TRUE

/obj/item/analyzer/gps/click_self(mob/caller, location, control, params)
	var/choose_function = !advanced ? "Rename" : input("Select the function you wish to run.","Function Selection") as null|anything in list("Rename", "Change Passkey", "Cancel")
	switch(choose_function)
		if("Change Passkey")
			if(!advanced)
				caller.to_chat(span("notice","DENIED: Advanced GPS feature only."))
				return TRUE
			var/chosen_passkey = input("Input a new passkey.", "Passkey Select") as null|password
			chosen_passkey = police_text(caller.client,chosen_passkey,check_name=TRUE,check_characters=TRUE,min_length=2,max_length=40)
			if(chosen_passkey)
				assigned_passkey = chosen_passkey
				caller.to_chat(span("notice","You set the passkey to [assigned_passkey]."))
				play_sound('sound/machines/click.ogg',get_turf(src),range_max=VIEW_RANGE)
			else
				caller.to_chat(span("notice","Invalid passkey."))
		if("Rename")
			var/chosen_name = input("Input a new name.", "Name Select") as null|text
			chosen_name = police_text(caller.client,chosen_name,check_name=TRUE,check_characters=TRUE,min_length=2,max_length=40)
			if(chosen_name)
				assigned_name = chosen_name
				caller.to_chat(span("notice","You set the gps name to [chosen_name]"))
				play_sound('sound/machines/click.ogg',get_turf(src),range_max=VIEW_RANGE)
				update_sprite()
			else
				caller.to_chat(span("notice","Invalid name."))
	return TRUE

/obj/item/analyzer/gps/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("assigned_name")
	SAVEVAR("assigned_passkey")

/obj/item/analyzer/gps/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("assigned_name")
	LOADVAR("assigned_passkey")

/obj/item/analyzer/gps/advanced
	name = "advanced gps"
	desc_extended = "A highly advanced gps and rangefinder that can get the location of where you aim it. This one is secure and can be passkey protected."
	advanced = TRUE
	secure = TRUE
	rarity = RARITY_RARE
