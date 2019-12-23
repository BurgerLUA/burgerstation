/obj/item/weapon/melee/toolbox
	name = "toolbox"
	desc = "Ultra robust."
	icon = 'icons/obj/items/weapons/melee/toolbox/red.dmi'
	damage_type = "toolbox"

	attack_delay = 5
	attack_delay_max = 10

/obj/item/weapon/melee/toolbox/on_spawn()
	inventories[1].add_held_object(new /obj/item/weapon/melee/tool/wrench(src.loc),bypass_checks = TRUE)
	inventories[2].add_held_object(new /obj/item/weapon/melee/tool/screwdriver(src.loc),bypass_checks = TRUE)
	inventories[3].add_held_object(new /obj/item/weapon/melee/tool/crowbar(src.loc),bypass_checks = TRUE)
	inventories[4].add_held_object(new /obj/item/weapon/melee/tool/wirecutters(src.loc),bypass_checks = TRUE)
	inventories[5].add_held_object(new /obj/item/weapon/melee/tool/multitool(src.loc),bypass_checks = TRUE)

/obj/item/weapon/melee/toolbox/red
	color = "#FF0000"

/obj/item/weapon/melee/toolbox/green
	color = "#00FF00"

/obj/item/weapon/melee/toolbox/blue
	color = "#0000FF"