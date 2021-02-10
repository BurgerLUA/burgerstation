/obj/item/soapstone/ //Rare drops from bosses.
	name = "soapstone"
	desc = "Leave a message behind, for other to find."
	desc_extended = "Allows you to write a single message on the floor that will persist between rounds. DISCLAIMER: Cannot be used as actual soap."
	icon = 'icons/obj/item/soapstone.dmi'
	icon_state = "inventory"
	dir = NORTH
	var/cooldown = 0
	var/stone_color = "#FFFFFF"

	value = 1000
	value_burgerbux = 10

	weight = 0.5

/obj/item/soapstone/New(var/desired_loc)
	update_sprite()
	filters += filter(type="drop_shadow", x=0, y=0, size=6, offset=0, color=stone_color)

/obj/item/soapstone/orange
	stone_color = "#FF6A00"

/obj/item/soapstone/red
	stone_color = "#880000"

/obj/item/soapstone/yellow
	stone_color = "#888800"

/obj/item/soapstone/blue
	stone_color = "#0094FF"

/obj/item/soapstone/update_icon()
	icon_state = initial(icon_state)
	icon = initial(icon)

	var/icon/I = new(icon,"stone")
	I.Blend(stone_color,ICON_MULTIPLY)
	var/icon/I2 = new(icon,"rope")
	I.Blend(I2,ICON_OVERLAY)
	var/icon/I3 = new(icon,"fade")
	I.Blend(I3,ICON_OVERLAY)

	icon = I

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

	SSsoapstone.create_new_soapstone(T,get_dir(caller,object),stone_color,caller.name,caller.ckey,input_text,date,time)

	caller.visible_message(\
		span("notice","\The [caller] writes a message with the soapstone."),\
		span("notice","The soapstone fades in your hand after you write down the last word on \the [T].")\
	)

	qdel(src)

	return TRUE
