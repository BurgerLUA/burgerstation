/obj/item/soapstone/ //Rare drops from bosses.
	name = "soapstone"
	desc = "Writes a message."
	icon = 'icons/obj/items/soapstone.dmi'
	icon_state = "inventory"
	dir = NORTH
	var/cooldown = 0
	var/stone_color = "#FFFFFF"

/obj/item/soapstone/New(var/desired_loc)
	update_icon()

/obj/item/soapstone/orange
	stone_color = "#FF6A00"

/obj/item/soapstone/red
	stone_color = "#880000"

/obj/item/soapstone/blue
	stone_color = "#0094FF"

/obj/item/soapstone/update_icon()
	icon_state = initial(icon_state)
	icon = initial(icon)

	var/icon/I = new(icon,"stone")
	I.Blend(stone_color,ICON_MULTIPLY)
	var/icon/I2 = new(icon,"rope")
	I.Blend(I2,ICON_OVERLAY)

	icon = I

/obj/item/soapstone/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(get_dist(caller,object) > 1)
		return FALSE

	if(!is_floor(object))
		caller.to_chat(span("notice","You can only write your message on floors."))
		return TRUE

	var/turf/T = object

	var/obj/structure/interactive/soapstone_message/existing_message = locate() in T //Copied from /tg/
	if(existing_message)
		caller.to_chat(span("notice","There is already a message here."))
		return TRUE

	var/input_text = sanitize(input("What would you like the message to say?"))

	if(!input_text)
		return TRUE

	var/date = get_date()
	var/time = get_time()

	SS_Soapstone.create_new_soapstone(T,get_dir(caller,object),stone_color,caller.name,caller.ckey,input_text,date,time)


	caller.visible_message(\
		span("notice","\The [caller] writes a message with the soapstone."),\
		span("notice","The soapstone fades in your hand after you write down the last word on \the [T].")\
	)

	drop_item()
	qdel(src)
