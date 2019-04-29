/obj/item/soapstone/
	name = "soapstone"
	desc = "Writes a message."
	icon = 'icons/obj/items/soapstone.dmi'
	icon_state = "inventory"

/obj/item/soapstone/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)
	if(!is_turf(object))
		caller.to_chat(span("notice","You can only write with the soapstone on turfs."))
		return TRUE


	var/turf/T = object

	var/input_text = sanitize(input("What would you like the message to say?"))

	if(!input_text)
		return TRUE

	var/date = get_date()
	var/time = get_time()

	SS_Soapstone.create_soapstone(T,caller.name,caller.ckey,input_text,date,time)
