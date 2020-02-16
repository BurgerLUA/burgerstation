/obj/item/weapon/melee/toolbox
	name = "toolbox"
	desc = "Ultra robust."
	icon = 'icons/obj/items/weapons/melee/toolbox/red.dmi'
	damage_type = "toolbox"

	attack_delay = 5
	attack_delay_max = 10

	value = 10

/obj/item/weapon/melee/toolbox/fill_inventory()
	new /obj/item/weapon/melee/tool/wrench(src)
	new /obj/item/weapon/melee/tool/screwdriver(src)
	new /obj/item/weapon/melee/tool/crowbar(src)
	new /obj/item/weapon/melee/tool/wirecutters(src)
	new /obj/item/weapon/melee/tool/multitool(src)

/obj/item/weapon/melee/toolbox/red
	color = "#FF0000"

/obj/item/weapon/melee/toolbox/green
	color = "#00FF00"

/obj/item/weapon/melee/toolbox/blue
	color = "#0000FF"