/obj/item/weapon/melee/tool
	name = "tool"
	drop_sound = 'sound/items/drop/scrap.ogg'

/obj/item/weapon/melee/tool/wirecutters
	name = "wirecutters"
	desc = "I said cut the INDIGO wire!"
	desc_extended = "A cutter which is mainly used for wires."
	icon = 'icons/obj/item/weapons/melee/tools/wirecutters.dmi'

	flags_tool = FLAG_TOOL_WIRECUTTER

	size = SIZE_2
	weight = 2

	value = 3

/obj/item/weapon/melee/tool/wrench
	name = "wrench"
	desc = "An adjustable, sizable, thermo-regulable wrench!"
	desc_extended = "A wrench that can fit any bolt in the known universe. What a time to be alive."
	icon = 'icons/obj/item/weapons/melee/tools/wrench.dmi'

	flags_tool = FLAG_TOOL_WRENCH

	size = SIZE_2
	weight = 4

	value = 5

/obj/item/weapon/melee/tool/welder
	name = "welding tool"
	desc = "Your common, typical everyday wielding tool! Wear eye protection!"
	desc_extended = "A wielding tool powered by special hydrogen fuel. Good for most wielding jobs."
	icon = 'icons/obj/item/weapons/melee/tools/welder.dmi'

	flags_tool = FLAG_TOOL_WELDER

	value = 5

	var/fuel_current = 0
	var/fuel_max = 50

	size = SIZE_2
	weight = 5

	var/active = FALSE

/obj/item/weapon/melee/tool/welder/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("fuel_current")
	return .

/obj/item/weapon/melee/tool/welder/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("fuel_current")
	return .

/obj/item/weapon/melee/tool/welder/Generate()
	fuel_current = fuel_max
	return ..()

/obj/item/weapon/melee/tool/welder/Finalize()
	fuel_current = min(fuel_current,fuel_max)
	return ..()

/obj/item/weapon/melee/tool/welder/think()

	. = ..()

	add_fuel(-0.001)

	if(fuel_current <= 0)
		return FALSE

	if(!active)
		return FALSE

	return .

/obj/item/weapon/melee/tool/welder/proc/add_fuel(var/fuel_amount = 0)

	if(!fuel_amount)
		return 0

	. = clamp(fuel_amount,-fuel_amount,fuel_max - fuel_current)

	fuel_current += .

	return .


/obj/item/weapon/melee/tool/welder/click_self(var/mob/caller)

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

/obj/item/weapon/melee/tool/welder/update_overlays()

	. = ..()

	if(active)
		var/image/I = new/image(icon,"welder_on")
		add_overlay(I)

	var/ratio = CEILING((fuel_current/fuel_max)*7,1)
	var/image/I = new/image(icon,"charge_[ratio]")
	add_overlay(I)

	return ..()

/obj/item/weapon/melee/tool/crowbar
	name = "crowbar"
	desc = "hl2_crowbar_ogg"
	desc_extended = "A curved piece of metal still used as a tool today. If it ain't broke, don't fix it."
	icon = 'icons/obj/item/weapons/melee/tools/crowbar.dmi'

	flags_tool = FLAG_TOOL_CROWBAR

	size = SIZE_2
	weight = 4

	value = 5

/obj/item/weapon/melee/tool/crowbar/red
	name = "red crowbar"
	icon = 'icons/obj/item/weapons/melee/tools/crowbar_red.dmi'

/obj/item/weapon/melee/tool/multitool
	name = "multitool"
	desc = "It just works."
	desc_extended = "A multitool that can be used to pulse the wires of airlocks and other machinery."
	icon = 'icons/obj/item/weapons/melee/tools/multitool.dmi'

	flags_tool = FLAG_TOOL_MULTITOOL

	size = SIZE_2
	weight = 3

	value = 10

/obj/item/weapon/melee/tool/multitool/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

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

/obj/item/weapon/melee/tool/screwdriver
	name = "screwdriver"
	desc = "It drives screws."
	desc_extended = "A screwdriver. Can be used to replace firing pins in weapons, as well as a variety of other screw-related functions."
	icon = 'icons/obj/item/weapons/melee/tools/screwdriver.dmi'

	value = 5

	size = SIZE_1
	weight = 2

	flags_tool = FLAG_TOOL_SCREWDRIVER

/obj/item/weapon/melee/tool/pickaxe
	name = "steel pickaxe"
	desc = "MINIIIIIING DIAAAAAMOOOOOOONDS."
	desc_extended = "An extremely outdated tool for digging through hard rock. Extremely effective, however, and always dose a guaranteed x4 critical hit multiplier when attacking turfs."
	icon = 'icons/obj/item/weapons/melee/clubs/pickaxe_steel.dmi'

	damage_type = /damagetype/melee/club/pickaxe/

	flags_tool = FLAG_TOOL_PICKAXE

	tool_time = SECONDS_TO_DECISECONDS(2)

	value = 10

	size = SIZE_3
	weight = 10


/obj/item/weapon/melee/tool/shovel
	name = "shovel"
	desc = "Useful for digging."
	desc_extended = "Shooting a rocket at your feet doesn't make this deal more damage, contrary to popular belief."
	icon = 'icons/obj/item/weapons/melee/clubs/shovel.dmi'

	damage_type = /damagetype/melee/club/shovel

	flags_tool = FLAG_TOOL_SHOVEL

	tool_time = SECONDS_TO_DECISECONDS(2)

	value = 10

	size = SIZE_3
	weight = 8