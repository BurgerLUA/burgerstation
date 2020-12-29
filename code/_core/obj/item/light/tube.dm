/obj/item/light
	var/obj/structure/interactive/lighting/light_type
	color = COLOR_LIGHT

	size = SIZE_1

	weight = 0.25

/obj/item/light/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,light_type))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/structure/interactive/lighting/L = object
		if(L.desired_light_color)
			var/obj/item/light/LT = new src.type(object.loc)
			LT.desired_light_color = L.desired_light_color
			INITIALIZE(LT)
			GENERATE(LT)
			FINALIZE(LT)
		L.desired_light_color = color
		L.update_atom_light()
		L.update_sprite()
		caller.visible_message(span("notice","\The [caller.name] inserts \the [src.name] into \the [object.name]."),span("notice","You insert \the [src.name] into \the [object.name]."))
		qdel(src)
		return TRUE

	return ..()


/obj/item/light/tube
	name = "light tube"
	desc = "Tuuube."
	desc_extended = "A lighting tube for lights. Can be used to replace existing lights, or provide new ones."
	icon = 'icons/obj/item/light_tube.dmi'
	icon_state = "inventory"
	light_type = /obj/structure/interactive/lighting/fixture/tube

	value = 4


/obj/item/light/bulb
	name = "light bulb"
	desc = "Buuuulb."
	desc_extended = "A lighting bulb for lights. Can be used to replace existing lights, or provide new ones."
	icon = 'icons/obj/item/light_bulb.dmi'
	icon_state = "inventory"
	light_type = /obj/structure/interactive/lighting/fixture/bulb

	value = 2