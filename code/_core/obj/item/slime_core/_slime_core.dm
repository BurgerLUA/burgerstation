/obj/item/slime_core
	name = "dye core"
	desc = "What wonders does this contained goo have?"
	color = "#FFFFFF"
	icon = 'icons/mob/living/simple/slimes_new.dmi'
	icon_state = "slime_core"
	alpha = 128

	value = 3

	weight = 0.25

/obj/item/slime_core/New(var/desired_loc)
	generate_name()
	return ..()

/obj/item/slime_core/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)



	if(is_item(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/I = object
		I.dye_self(caller,src,src.color,alpha/255)
		return TRUE

	return ..()


/obj/item/slime_core/get_value()
	return ..() * (1 + (alpha/255)) ** 2

/obj/item/slime_core/proc/generate_name()

	var/prefix = ""
	if(alpha < 100)
		prefix = "weak "
	else if(alpha > 200)
		prefix = "strong "

	name = "[prefix][initial(name)] ([color ? color : "#FFFFFF"])"

	return TRUE

/obj/item/slime_core/custom
	name = "custom slime core"
	value = 1000
	alpha = 255

/obj/item/slime_core/custom/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(10)
	var/choice = input("What would you like the color to be?") as color|null
	if(choice)
		color = choice
		update_sprite()
	return TRUE

/obj/item/slime_core/get_value()
	return value

/obj/item/slime_core/red
	color = "#FF0000"
	alpha = 128

/obj/item/slime_core/red/strong
	alpha = 255

/obj/item/slime_core/red/weak
	alpha = 64

/obj/item/slime_core/green
	color = "#00FF00"
	alpha = 128

/obj/item/slime_core/green/strong
	alpha = 255

/obj/item/slime_core/green/weak
	alpha = 64

/obj/item/slime_core/blue
	color = "#0000FF"
	alpha = 128

/obj/item/slime_core/blue/strong
	alpha = 255

/obj/item/slime_core/blue/weak
	alpha = 64

/obj/item/slime_core/black
	color = "#000000"
	alpha = 128

/obj/item/slime_core/black/weak
	alpha = 64

/obj/item/slime_core/black/strong
	alpha = 255

/obj/item/slime_core/white
	color = "#FFFFFF"
	alpha = 128

/obj/item/slime_core/white/weak
	alpha = 64

/obj/item/slime_core/white/strong
	alpha = 255
