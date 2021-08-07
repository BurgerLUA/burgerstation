var/global/list/gps_list = list()

/obj/item/analyzer/gps
	name = "gps"
	desc = "Where are you?"
	desc_extended = "A highly advanced gps and rangefinder that can get the location of where you aim it."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/analyzers/gps.dmi'
	icon_state = "inventory"
	value = 700
	var/assigned_number
	var/need_password = FALSE
	var/advanced = FALSE
	var/ownerCkey
	var/loadedFromFile = FALSE

/obj/item/analyzer/gps/Finalize()
	. = ..()
	if (!loadedFromFile)
		assigned_number = "[rand(111111,999999)]"
		name = CHECK_NAME("[initial(name)]")
	gps_list += src

/obj/item/analyzer/gps/get_examine_list(mob/examiner)
	. = ..()
	if(assigned_number && examiner.ckey == ownerCkey)
		. += div("notice", "The password is: [assigned_number]")

/obj/item/analyzer/gps/Destroy()
	gps_list -= src
	return ..()

/obj/item/analyzer/gps/can_be_scanned(var/mob/caller,var/atom/target)
	return TRUE

/obj/item/analyzer/gps/on_scan(var/mob/caller,var/atom/target,location,control,params)

	if(!target || !caller)
		caller.to_chat(span("warning","Invalid target!"))
		return FALSE

	caller.to_chat(span("notice","Position: ([target.x],[target.y],[target.z])."))
	caller.to_chat(span("notice","Angle: [get_angle(caller,target)] degrees."))
	next_scan = world.time + SECONDS_TO_DECISECONDS(2)
	return TRUE

/obj/item/analyzer/gps/click_self(mob/caller, location, control, params)
	if(!ownerCkey && caller.ckey)
		ownerCkey = caller.ckey
		caller.to_chat(span("notice","You are set as the owner."))
	if(caller.ckey != ownerCkey)
		caller.to_chat(span("notice","You are not the owner."))
		return
	var/choose_function = input("Select the function you wish to run.","Function Selection") as null|anything in list("Rename", "Change Password", "Cancel")
	switch(choose_function)
		if("Cancel")
			return
		if("Change Password")
			if(!advanced)
				caller.to_chat(span("notice","DENIED: Advanced GPS feature only."))
				return
			var/choose_password = input("Input a new password.", "Password Select") as null|text
			if(!choose_password)
				caller.to_chat(span("notice","You failed to select a new password."))
				return
			assigned_number = sanitize(choose_password)
			caller.to_chat(span("notice","You set the password to [assigned_number]"))
			play_sound('sound/machines/click.ogg',get_turf(src),range_max=VIEW_RANGE)
			return
		if("Rename")
			var/choose_name = input("Input a new name.", "Name Select") as null|text
			if(!choose_name)
				caller.to_chat(span("notice","You failed to select a new name."))
				return
			name = "[initial(name)] ([sanitize(choose_name)])"
			caller.to_chat(span("notice","You set the name to [name]"))
			play_sound('sound/machines/click.ogg',get_turf(src),range_max=VIEW_RANGE)
			return
	return ..()

/obj/item/analyzer/gps/save_item_data(var/save_inventory = TRUE)
	. = ..()
	.["name"] = name
	.["assigned_number"] = assigned_number
	.["ownerCkey"] = ownerCkey

/obj/item/analyzer/gps/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	name = object_data["name"]
	assigned_number = object_data["assigned_number"]
	ownerCkey = object_data["ownerCkey"]
	loadedFromFile = TRUE

/obj/item/analyzer/gps/advanced
	name = "advanced gps"
	desc_extended = "A highly advanced gps and rangefinder that can get the location of where you aim it. This one can also change its password."
	value = 2100
	advanced = TRUE
	need_password = TRUE
