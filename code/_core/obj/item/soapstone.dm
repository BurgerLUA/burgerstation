/obj/item/soapstone/ //Rare drops from bosses.
	name = "soapstone"
	desc = "Leave a message behind, for other to find."
	desc_extended = "Allows you to write a single message on the floor that will persist between rounds. DISCLAIMER: Cannot be used as actual soap."
	icon = 'icons/obj/item/soapstone.dmi'
	icon_state = "inventory"
	dir = NORTH
	var/cooldown = 0
	color = "#FFFFFF"

	value = 1000
	value_burgerbux = 10

	weight = 0.5

/obj/item/soapstone/Finalize()
	. = ..()
	update_sprite()

/obj/item/soapstone/orange
	color = "#FF6A00"

/obj/item/soapstone/red
	color = "#880000"

/obj/item/soapstone/yellow
	color = "#888800"

/obj/item/soapstone/blue
	color = "#0094FF"

/obj/item/soapstone/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = "stone"

/obj/item/soapstone/update_overlays()
	. = ..()
	var/image/I2 = new/image(icon,"rope")
	I2.appearance_flags = src.appearance_flags
	add_overlay(I2)
	var/image/I3 = new/image(icon,"fade")
	I3.appearance_flags = src.appearance_flags
	add_overlay(I3)

/obj/item/soapstone/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(10)

	if(!is_floor(object))
		caller.to_chat(span("warning","You can't write here, it's not a floor!"))
		return TRUE

	var/turf/T = object

	var/obj/structure/interactive/soapstone_message/existing_message = locate() in T //Copied from /tg/
	if(existing_message)
		caller.to_chat(span("warning","You can't write here, there is already a message!"))
		return TRUE

	var/input_text = sanitize(input("What would you like the message to say?") as text|null)

	if(!input_text)
		return TRUE

	if(caller.client)
		input_text = police_input(caller.client,input_text)

	if(!input_text)
		return TRUE

	var/date = get_date()
	var/time = get_time()

	SSsoapstone.create_new_soapstone(T,get_dir(caller,object),color,caller.name,caller.ckey,input_text,date,time)

	caller.visible_message(\
		span("notice","\The [caller.name] writes a message with the soapstone on \the [T.name]."),\
		span("notice","The soapstone fades in your hand after you write down the last word on \the [T.name].")\
	)

	qdel(src)

	return TRUE
