/obj/item/weapon/melee/tool
	name = "tool"
	value = 10

/obj/item/weapon/melee/tool/wirecutters
	name = "wirecutters"
	desc = "I said cut the INDIGO wire!"
	desc_extended = "A cutter which is mainly used for wires."
	icon = 'icons/obj/item/weapons/melee/tools/wirecutters.dmi'

	flags_tool = FLAG_TOOL_WIRECUTTER

	value = 3

/obj/item/weapon/melee/tool/wrench
	name = "wrench"
	desc = "An adjustable, sizable, thermo-regulable wrench!"
	desc_extended = "A wrench that can fit any bolt in the known universe. What a time to be alive."
	icon = 'icons/obj/item/weapons/melee/tools/wrench.dmi'

	flags_tool = FLAG_TOOL_WRENCH

	value = 5

/obj/item/weapon/melee/tool/crowbar
	name = "crowbar"
	desc = "hl2_crowbar_ogg"
	desc_extended = "A curved piece of metal still used as a tool today. If it ain't broke, don't fix it."
	icon = 'icons/obj/item/weapons/melee/tools/crowbar.dmi'

	flags_tool = FLAG_TOOL_CROWBAR

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

	value = 10

/obj/item/weapon/melee/tool/multitool/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,/obj/structure/interactive/))
		var/obj/structure/interactive/I = object
		var/atom/movable/A = I.check_interactables(caller,src,location,control,params)
		if(A)
			A.force_move(get_turf(caller))
			caller.to_chat("You successfully remove \the [A.name] from \the [I.name] with \the [src.name].")
		return TRUE

	return ..()

/obj/item/weapon/melee/tool/screwdriver
	name = "screwdriver"
	desc = "It drives screws."
	desc_extended = "A screwdriver. Can be used to replace firing pins in weapons, as well as a variety of other screw-related functions."
	icon = 'icons/obj/item/weapons/melee/tools/screwdriver.dmi'

	value = 5

	flags_tool = FLAG_TOOL_SCREWDRIVER

/obj/item/weapon/melee/tool/pickaxe
	name = "steel pickaxe"
	desc = "MINIIIIIING DIAAAAAMOOOOOOONDS."
	desc_extended = "An extremely outdated tool for digging through hard rock."
	icon = 'icons/obj/item/weapons/melee/clubs/pickaxe_steel.dmi'

	damage_type = /damagetype/melee/club/pickaxe/

	flags_tool = FLAG_TOOL_PICKAXE

	tool_time = SECONDS_TO_DECISECONDS(2)

	attack_delay = 10
	attack_delay_max = 15

	value = 10


/obj/item/weapon/melee/tool/shovel
	name = "shovel"
	desc = "Useful for digging."
	desc_extended = "Shooting a rocket at your feet doesn't make this deal more damage, contrary to popular belief."
	icon = 'icons/obj/item/weapons/melee/clubs/shovel.dmi'

	damage_type = /damagetype/melee/club/pickaxe/

	flags_tool = FLAG_TOOL_SHOVEL

	tool_time = SECONDS_TO_DECISECONDS(2)

	attack_delay = 10
	attack_delay_max = 15

	value = 10