/obj/item/weapon/melee/tool
	name = "tool"

/obj/item/weapon/melee/tool/wirecutters
	name = "wirecutters"
	icon = 'icons/obj/items/weapons/melee/tools/wirecutters.dmi'

	flags_tool = FLAG_TOOL_WIRECUTTER

/obj/item/weapon/melee/tool/wrench
	name = "wrench"
	icon = 'icons/obj/items/weapons/melee/tools/wrench.dmi'

	flags_tool = FLAG_TOOL_WRENCH

/obj/item/weapon/melee/tool/crowbar
	name = "crowbar"
	icon = 'icons/obj/items/weapons/melee/tools/crowbar.dmi'

	flags_tool = FLAG_TOOL_CROWBAR

/obj/item/weapon/melee/tool/crowbar/red
	name = "red crowbar"
	icon = 'icons/obj/items/weapons/melee/tools/crowbar_red.dmi'

/obj/item/weapon/melee/tool/multitool
	name = "multitool"
	icon = 'icons/obj/items/weapons/melee/tools/multitool.dmi'

	flags_tool = FLAG_TOOL_MULTITOOL

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
	icon = 'icons/obj/items/weapons/melee/tools/screwdriver.dmi'

	flags_tool = FLAG_TOOL_SCREWDRIVER
