/obj/item/mech_delivery
	name = "mech chassis delivery utility"
	desc = "Also works as a beacon."
	desc_extended = "A tablet to manage your collection of mechs and summon them anywhere. NOTICE: NT is not responsible for any injuries caused by state-of-the-art precision launched mech storage pods."
	icon = 'icons/obj/item/supply_remote_mech.dmi'
	icon_state = "inventory"
	value = 1000

	weight = 4


/obj/item/mech_delivery/click_self(var/mob/caller)

	if(!is_player(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/mob/living/advanced/player/P = caller

	if(!P.allow_save)
		P.to_chat(span("warning","You don't seem to know how this works..."))
		return FALSE

	var/menu_choice = input("What would you like to do?","Mech Delivery Unit","Cancel") as null|anything in list("Create New Mech (1000 credits)","Loading Existing Mech (500 credits)","Cancel")

	INTERACT_CHECK_OTHER(src) //Hacky

	switch(menu_choice)
		if("Cancel")
			return TRUE
		if("Create New Mech (1000 credits)")
			var/savedata/client/mob/M = MOBDATA(P.ckey)
			var/existing_mechs = M.loaded_data["stored_mechs"]
			if(length(existing_mechs) >= 5)
				caller.to_chat(span("warning","Error: You reached your limit of 5 mechs! Load an existing one instead!"))
				return TRUE
			var/confirmation = input("Are you sure you wish to create a new mech chasis? This will cost 1000 credits and take up 1 out of [5-length(existing_mechs)] remaining mech slots.","Mech Creation","Cancel") as null|anything in list("Yes","No","Cancel")
			if(confirmation != "Yes")
				return TRUE

			if(P.currency < 1000)
				P.to_chat(span("warning","You don't have enough credits to purchase a mech!"))
				return TRUE

			P.to_chat(span("notice","A mech is being deployed to your location! Clear the area!"))

			var/turf/caller_turf = get_turf(src)

			var/mob/living/vehicle/mech/modular/V = new(caller_turf)
			V.owner_ckey = P.ckey
			V.generate_id()
			V.generate_name()
			INITIALIZE(V)
			GENERATE(V)
			FINALIZE(V)
			if(!M.loaded_data["stored_mechs"])
				M.loaded_data["stored_mechs"] = list()
			M.loaded_data["stored_mechs"][V.mech_id] = V.save_mech_data()

			var/obj/structure/interactive/crate/closet/supply_pod/centcomm/SP = new(caller_turf)
			SP.add_to_crate(V)
			INITIALIZE(SP)
			FINALIZE(SP)

			P.adjust_currency(-1000)

		if("Loading Existing Mech (500 credits)")
			var/savedata/client/mob/M = MOBDATA(P.ckey)
			var/existing_mechs = M.loaded_data["stored_mechs"]

			if(length(existing_mechs) <= 0)
				P.to_chat(span("notice","You don't have a mech to load! Create a new one through the main menu!"))
				return TRUE

			var/list/mech_choices = list()

			var/i=1
			for(var/md5_id in existing_mechs)
				var/mech_data = existing_mechs[md5_id]
				var/mech_name = mech_data["name"]
				mech_choices["[i]: [mech_name]"] = md5_id
				i++

			mech_choices["Cancel"] = "Cancel"

			var/mech_choice = input("What mech would you like to load?","Mech Selection","Cancel") as null|anything in mech_choices
			if(!mech_choice || mech_choice == "Cancel")
				return TRUE

			var/md5_id = mech_choices[mech_choice]

			if(stored_mechs_by_ckey[P.ckey] && length(stored_mechs_by_ckey[P.ckey]))
				for(var/mob/living/vehicle/mech/modular/V in stored_mechs_by_ckey[P.ckey])
					if(V.mech_id == md5_id)
						P.to_chat(span("warning","ERROR: That mech has already been delivered!"))
						return TRUE

			var/turf/caller_turf = get_turf(src)

			var/mob/living/vehicle/mech/modular/V = new(caller_turf)
			V.owner_ckey = P.ckey
			INITIALIZE(V)
			FINALIZE(V)


			var/mech_data = existing_mechs[md5_id]
			V.load_mech_data(P,mech_data)

			var/obj/structure/interactive/crate/closet/supply_pod/centcomm/SP = new(caller_turf)
			SP.add_to_crate(V)
			INITIALIZE(SP)
			FINALIZE(SP)

			P.adjust_currency(-500)

			return TRUE