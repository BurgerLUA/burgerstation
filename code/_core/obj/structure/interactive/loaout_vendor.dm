/obj/structure/interactive/loadout_vendor
	name = "loadout vendor"
	desc = "Being the one stop shop for post-death regret since 2522!"
	desc_extended = "A special piece of equipment that saves pre-made packages of kits saved by NanoTrasen mercenaries. Probably has some long designated name, but people call it a loadout vendor. You can use this to save your current outfit or load an existing one that you already saved before."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear"

	density = TRUE
	anchored = TRUE

	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 75

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#0000FF"

	pixel_y = 6


/obj/structure/interactive/loadout_vendor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(!caller.ckey || !is_player(caller))
		return FALSE

	if(length(ckey_to_loadout_cooldown) && ckey_to_loadout_cooldown[caller.ckey] > world.time)
		caller.to_chat(span("warning","\The [src.name] is busy! Please wait [CEILING(DECISECONDS_TO_SECONDS(ckey_to_loadout_cooldown[caller.ckey] - world.time),1)] more seconds before using this machine again!"))
		return TRUE

	var/list/LOADDATA = ckey_to_loadout_data[caller.ckey].loaded_data

	var/desired_setting = input("What would you like to do?", "Loadout Vendor", "Cancel") as null|anything in list("Save current loadout","Load existing loadout","Cancel")
	INTERACT_CHECK_NO_DELAY(caller)

	if(desired_setting == "Save current loadout")
		desired_setting = input("Are you sure you wish to save your current loadout? (Slots: [length(LOADDATA)]/[LOADOUT_LIMIT])","Save Loadout","Cancel") as null|anything in list("Yes","No","Cancel")
		INTERACT_CHECK_NO_DELAY(caller)
		if(desired_setting != "Yes")
			caller.to_chat(span("notice","You decide not to save anything."))
			return TRUE
		var/desired_name = input("Please enter a desired name for your loadout.","Loadout Name") as text
		INTERACT_CHECK_NO_DELAY(caller)
		if(!length(desired_setting))
			caller.to_chat(span("notice","You decide not to save anything."))
			return TRUE
		if(length(LOADDATA) && LOADDATA[desired_setting])
			desired_setting = input("There already exists a loadout with this name, with a stored value of [LOADDATA[desired_setting]["cost"]]. Would you like to override this loadout with your new one?","Override Loadout") as null|anything in list("Yes","No","Cancel")
			INTERACT_CHECK_NO_DELAY(caller)
			if(desired_setting != "Yes")
				caller.to_chat(span("notice","You decide not to save anything."))
				return TRUE
		save_loadout_of_mob(caller,desired_name)
		return TRUE
	else if(desired_setting == "Load existing loadout")
		if(!length(LOADDATA))
			caller.to_chat(span("notice","You have no loadouts to load! Create a new one!"))
			return TRUE
		var/list/found_loadouts = list()
		for(var/k in LOADDATA)
			var/list/v = LOADDATA[k]
			var/new_name = "[v["name"]] (Cost:[v["cost"]])"
			found_loadouts[new_name] = v["name"]
		found_loadouts += "Cancel"
		var/desired_loadout = input("What loadout do you wish to load?","Load Loadout","Cancel") as null|anything in found_loadouts
		INTERACT_CHECK_NO_DELAY(caller)
		if(!desired_loadout || desired_loadout == "Cancel")
			caller.to_chat(span("notice","You decide not to load anything."))
			return TRUE
		var/list/actual_loadout = found_loadouts[desired_loadout]
		apply_loadout_to_mob(caller,actual_loadout)
		return TRUE

	. = ..()