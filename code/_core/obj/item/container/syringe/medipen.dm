/obj/item/container/syringe/medipen
	name = "butterfly pen"
	desc = "For when you want to poke holes in people faster."
	desc_extended = "A single use hypodermic needle pen designed to quickly and safely administer reagents to the user's bloodstream."
	crafting_id = "medipen"
	icon = 'icons/obj/item/container/medipen.dmi'
	icon_state = "medipen"

	reagents = /reagent_container/syringe/medipen

	inject_amount_desired = INFINITY
	injection_sound = 'sound/effects/epi.ogg'

	can_draw = FALSE
	adjustable = FALSE

	injection_time = SECONDS_TO_DECISECONDS(0.5)
	quality_reduction_on_use = 100

	value = 1

/obj/item/container/syringe/medipen/update_sprite()
	. = ..()
	name = initial(name)
	desc_extended = initial(desc_extended)
	if(quality <= 0)
		name = "used [name]"
		desc_extended = "[desc_extended] This one is used and should be discarded."
	else
		var/list/names = list()
		for(var/r_id in reagents.stored_reagents)
			var/reagent/R = REAGENT(r_id)
			names |= R.name
		desc_extended = "[desc_extended] This one contains [english_list(names)]."

/obj/item/container/syringe/medipen/update_icon()
	. = ..()
	icon = initial(icon)
	if(!reagents || reagents.volume_current <= 0)
		icon_state = "opened"
		flick("open",src)
	else
		icon_state = "closed"

/obj/item/container/syringe/medipen/update_underlays()
	. = ..()
	if(reagents && reagents.volume_current)
		var/image/I = new/image(icon,"liquid")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = reagents.color
		add_underlay(I)

/obj/item/container/syringe/medipen/mouse_wheel_on_object(var/mob/caller,delta_x,delta_y,location,control,params)
	return

/obj/item/container/syringe/medipen/click_self(var/mob/caller,location,control,params)
	return

/obj/item/container/syringe/medipen/adminomnizine
	name = "god's butterfly pen"
	value_burgerbux = 1

/obj/item/container/syringe/medipen/adminomnizine/Generate()
	reagents.add_reagent(/reagent/medicine/adminomnizine,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/bicaridine
	name = "anti-brute butterfly pen"

/obj/item/container/syringe/medipen/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine_plus,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/kelotane
	name = "anti-burn butterfly pen"

/obj/item/container/syringe/medipen/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/dylovene
	name = "anti-toxin butterfly pen"

/obj/item/container/syringe/medipen/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/dexaline
	name = "anti-suffocation butterfly pen"

/obj/item/container/syringe/medipen/dexaline/Generate()
	reagents.add_reagent(/reagent/medicine/dexalin,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/epinephrine
	name = "epinephrine butterfly pen"

/obj/item/container/syringe/medipen/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/iron
	name = "anti-bloodloss butterfly pen"

/obj/item/container/syringe/medipen/iron/Generate()
	reagents.add_reagent(/reagent/iron,reagents.volume_max)
	return ..()

/obj/item/container/syringe/medipen/mining
	name = "mining butterfly pen"
	desc = "The only thing that keeps you alive during ash storms. Besides mining capsules."
	desc_extended = "An incredibly beneficial and expensive butterfly pen with a potent mix of chemicals that should keep you standing even in the harshest of environments. It is recommended not to use more than two in a quick succession."
	value = 1000

	reagents = /reagent_container/syringe/medipen/hypospray

/obj/item/container/syringe/medipen/mining/Generate()
	reagents.add_reagent(/reagent/medicine/inaprovaline,20)
	reagents.add_reagent(/reagent/medicine/omnizine,10)
	reagents.add_reagent(/reagent/medicine/tricordrazine,10)
	reagents.add_reagent(/reagent/medicine/adrenaline,10)
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,10)
	return ..()
