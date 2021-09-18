/obj/item/weapon/melee/tool/brass
	name = "tool"
	drop_sound = 'sound/items/drop/scrap.ogg'

	has_quick_function = TRUE


/obj/item/weapon/melee/tool/brass/wirecutters
	name = "brass wirecutters"
	desc = "For cutting brass! And wires I guess."
	desc_extended = "A cutter which is mainly used for wires. This one is made of brass!"
	icon = 'icons/obj/item/tools.dmi'
	icon_state = "cutters_clock"

	flags_tool = FLAG_TOOL_WIRECUTTER

	size = SIZE_2
	weight = 2

	value = 3

/obj/item/weapon/melee/tool/brass/wrench
	name = "clockwork wrench"
	desc = "Percussive Maintinence!"
	desc_extended = "A wrench that can fit any bolt in the known universe. What a time to be alive. This one is made of brass and cogs!"
	icon = 'icons/obj/item/tools.dmi'
	icon_state = "wrench_clock"

	flags_tool = FLAG_TOOL_WRENCH

	size = SIZE_2
	weight = 4

	value = 5

obj/item/weapon/melee/tool/brass/welder
	name = "clockwork welding tool"
	desc = "A strange welding tool that is made of brass and gears. How does this even work?"
	desc_extended = "A wielding tool powered by special hydrogen fuel. Good for most wielding jobs."
	icon = 'icons/obj/item/tools.dmi'
	icon_state = "brasswelder"

	flags_tool = FLAG_TOOL_WELDER

	value = 5

	var/fuel_current = 0
	var/fuel_max = 100

	size = SIZE_2
	weight = 5

	var/active = FALSE

/obj/item/weapon/melee/tool/brass/welder/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("fuel_current")

/obj/item/weapon/melee/tool/brass/welder/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("fuel_current")

/obj/item/weapon/melee/tool/brass/welder/Generate()
	fuel_current = fuel_max
	return ..()

/obj/item/weapon/melee/tool/brass/welder/Finalize()
	fuel_current = min(fuel_current,fuel_max)
	return ..()

/obj/item/weapon/melee/tool/brass/welder/think()

	. = ..()

	add_fuel(-0.001)

	if(fuel_current <= 0)
		return FALSE

	if(!active)
		return FALSE


/obj/item/weapon/melee/tool/brass/welder/proc/add_fuel(var/fuel_amount = 0)

	if(!fuel_amount)
		return 0

	. = clamp(fuel_amount,-fuel_amount,fuel_max - fuel_current)

	fuel_current += .



/obj/item/weapon/melee/tool/brass/welder/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(active)
		active = FALSE
		update_sprite()
		caller.to_chat(span("notice","You turn \the [src.name] off."))
		stop_thinking(src)
	else
		if(fuel_current > 0)
			active = TRUE
			update_sprite()
			caller.to_chat(span("notice","\The [src.name] turns on."))
			start_thinking(src)
		else
			caller.to_chat(span("warning","\The [src.name] doesn't seem to want to turn on..."))

	return TRUE

/obj/item/weapon/melee/tool/brass/welder/update_overlays()

	. = ..()

	if(active)
		var/image/I = new/image(icon,"brasswelder_on")
		add_overlay(I)

	var/ratio = CEILING((fuel_current/fuel_max)*7,1)
	var/image/I = new/image(icon,"charge_[ratio]")
	add_overlay(I)

	return ..()

/obj/item/weapon/melee/tool/brass/crowbar
	name = "brass crowbar"
	desc = "Why?"
	desc_extended = "A curved piece of metal still used as a tool today. This one is made of brass!"
	icon = 'icons/obj/item/tools.dmi'
	icon_state = "crowbar_clock"

	flags_tool = FLAG_TOOL_CROWBAR

	size = SIZE_2
	weight = 4

	value = 5

/obj/item/weapon/melee/tool/brass/screwdriver
	name = "brass screwdriver"
	desc = "It drives brass screws."
	desc_extended = "A screwdriver. Can be used to replace firing pins in weapons, as well as a variety of other screw-related functions. This one is made of brass!"
	icon = 'icons/obj/item/tools.dmi'
	icon_state = "screwdriver_clock"

	value = 5

	size = SIZE_1
	weight = 2

	flags_tool = FLAG_TOOL_SCREWDRIVER

/obj/item/weapon/melee/tool/brass/multitool
	name = "brass multitool"
	desc = "Ratvar's finest."
	desc_extended = "A multitool that can be used to pulse the wires of airlocks and other machinery. This one is made of brass."
	icon = 'icons/obj/item/tools.dmi'
	icon_state = "brassmultitool"

	flags_tool = FLAG_TOOL_MULTITOOL

	size = SIZE_2
	weight = 3

	value = 10

/obj/item/weapon/melee/tool/brass/multitool/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,/obj/structure/interactive/)) //TODO: MOVE THIS TO STRUCTURE CODE
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/structure/interactive/I = object
		var/obj/item/I2 = I.check_interactables(caller,src,location,control,params)
		if(I2)
			I2.drop_item(get_turf(caller))
			caller.to_chat(span("notice","You successfully remove \the [I2.name] from \the [I.name] with \the [src.name]."))
		return TRUE

	return ..()