/obj/item/weapon/melee/toolbox
	name = "toolbox"
	desc = "WARNING: Very Robust"
	desc_extended = "A Toolbox mainly used by the most brutish and stupid mercs to hit people with. Can also be used to store tools."
	icon = 'icons/obj/item/weapons/melee/toolbox/red.dmi'
	damage_type = /damagetype/item/heavy

	value = 10

	size = SIZE_3
	weight = 10

	is_container = TRUE
	container_max_size = SIZE_2

	dynamic_inventory_count = 6

/obj/item/weapon/melee/toolbox/red
	color = "#FF0000"

/obj/item/weapon/melee/toolbox/green
	color = "#00FF00"

/obj/item/weapon/melee/toolbox/blue
	color = "#0000FF"

/obj/item/weapon/melee/toolbox/yellow
	color = "#FFFF00"


/obj/item/weapon/melee/toolbox/syndicate
	name = "fully loaded black toolbox"
	color = COLOR_GREY_DARK

/obj/item/weapon/melee/toolbox/syndicate/Generate()
	new /obj/item/weapon/melee/tool/crowbar(src)
	new /obj/item/weapon/melee/tool/multitool(src)
	new /obj/item/weapon/melee/tool/screwdriver(src)
	new /obj/item/weapon/melee/tool/wirecutters(src)
	new /obj/item/weapon/melee/tool/wrench(src)
	new /obj/item/weapon/melee/torch/flashlight(src)
	return ..()