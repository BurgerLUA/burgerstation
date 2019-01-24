/obj/structure/interactive/localmachine/item
	name = "Item Spawner"
	desc = "Spawns the below item."
	var/obj/item/stored_item
	density = 0

/obj/structure/interactive/localmachine/item/New()
	if(stored_item)
		stored_item = new stored_item(src.contents)
		stored_item.on_spawn()
		stored_item.update_icon()
		name = stored_item.name
		icon = stored_item.icon
		icon_state = stored_item.icon_state
		desc = stored_item.desc
	..()

/obj/structure/interactive/localmachine/item/clicked_by_object(caller,object,location,control,params)
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/obj/item/local_item_clone = new stored_item.type(loc)
		local_item_clone.on_spawn()
		local_item_clone.update_icon()
		if(A.client)
			A.client.MouseDown(local_item_clone,location,control,list2params(params))

	return ..()

//Clothing
/obj/structure/interactive/localmachine/item/clothing/coat
	stored_item = /obj/item/clothing/overwear/coat/

/obj/structure/interactive/localmachine/item/clothing/shoe_right
	stored_item = /obj/item/clothing/feet/shoes/brown

/obj/structure/interactive/localmachine/item/clothing/shoe_left
	stored_item = /obj/item/clothing/feet/shoes/brown/left

/obj/structure/interactive/localmachine/item/clothing/pants
	stored_item = /obj/item/clothing/pants/brown

/obj/structure/interactive/localmachine/item/clothing/armor
	stored_item = /obj/item/clothing/overwear/armor

/obj/structure/interactive/localmachine/item/clothing/sunglasses
	stored_item = /obj/item/clothing/glasses/sun

/obj/structure/interactive/localmachine/item/clothing/clownmask
	stored_item = /obj/item/clothing/mask/gas/clown

/obj/structure/interactive/localmachine/item/clothing/gasmask
	stored_item =/obj/item/clothing/mask/gas

/obj/structure/interactive/localmachine/item/clothing/boot_left
	stored_item = /obj/item/clothing/feet/shoes/black_boots/left

/obj/structure/interactive/localmachine/item/clothing/boot_right
	stored_item = /obj/item/clothing/feet/shoes/black_boots

/obj/structure/interactive/localmachine/item/clothing/black_shoe_left
	stored_item = /obj/item/clothing/feet/shoes/black/left

/obj/structure/interactive/localmachine/item/clothing/black_shoe_right
	stored_item = /obj/item/clothing/feet/shoes/black

/obj/structure/interactive/localmachine/item/clothing/gloves_yellow
	stored_item = /obj/item/clothing/hands/gloves/yellow

/obj/structure/interactive/localmachine/item/clothing/gloves_yellow/left
	stored_item = /obj/item/clothing/hands/gloves/yellow/left

/obj/structure/interactive/localmachine/item/clothing/beaverhat
	stored_item = /obj/item/clothing/head/beaver

/obj/structure/interactive/localmachine/item/clothing/jumpsuit
	stored_item = /obj/item/clothing/uniform/jumpsuit

//Melee
/obj/structure/interactive/localmachine/item/weapon/sword
	stored_item = /obj/item/weapon/melee/sword

/obj/structure/interactive/localmachine/item/weapon/energy_sword
	stored_item = /obj/item/weapon/melee/energy/sword/
	icon = 'icons/obj/items/weapons/melee/laser/sword.dmi'
	icon_state = "inventory_on"

/obj/structure/interactive/localmachine/item/weapon/energy_sword/blue
	stored_item = /obj/item/weapon/melee/energy/sword/blue
	color = "#0000FF"

/obj/structure/interactive/localmachine/item/weapon/energy_sword/red
	stored_item = /obj/item/weapon/melee/energy/sword/red
	color = "#FF0000"

/obj/structure/interactive/localmachine/item/weapon/energy_sword/green
	stored_item = /obj/item/weapon/melee/energy/sword/green
	color = "#00FF00"

/obj/structure/interactive/localmachine/item/weapon/energy_sword/yellow
	stored_item = /obj/item/weapon/melee/energy/sword/yellow
	color = "#FFFF00"

/obj/structure/interactive/localmachine/item/weapon/energy_shield
	stored_item = /obj/item/weapon/melee/energy/shield/
	icon = 'icons/obj/items/weapons/melee/laser/shield.dmi'
	icon_state = "inventory_on"

/obj/structure/interactive/localmachine/item/weapon/energy_shield/blue
	stored_item = /obj/item/weapon/melee/energy/shield/blue
	color = "#0000FF"

/obj/structure/interactive/localmachine/item/weapon/energy_shield/red
	stored_item = /obj/item/weapon/melee/energy/shield/red
	color = "#FF0000"

/obj/structure/interactive/localmachine/item/weapon/energy_shield/green
	stored_item = /obj/item/weapon/melee/energy/shield/green
	color = "#00FF00"

/obj/structure/interactive/localmachine/item/weapon/energy_shield/yellow
	stored_item = /obj/item/weapon/melee/energy/shield/yellow
	color = "#FFFF00"


//Guns
/obj/structure/interactive/localmachine/item/weapon/detective
	stored_item = /obj/item/weapon/ranged/bullet/revolver/detective/
	icon = 'icons/obj/items/weapons/ranged/revolver.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/mateba
	stored_item = /obj/item/weapon/ranged/bullet/revolver/mateba/
	icon = 'icons/obj/items/weapons/ranged/mateba.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/assault_rifle
	stored_item = /obj/item/weapon/ranged/bullet/magazine/assault_rifle
	icon = 'icons/obj/items/weapons/ranged/machine.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/smg
	stored_item = /obj/item/weapon/ranged/bullet/magazine/smg
	icon = 'icons/obj/items/weapons/ranged/smg.dmi'
	icon_state = "inventory_open"

/obj/structure/interactive/localmachine/item/weapon/dbarrel
	stored_item = /obj/item/weapon/ranged/bullet/revolver/dbarrel
	icon = 'icons/obj/items/weapons/ranged/dbarrel.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/combat_shotgun
	stored_item = /obj/item/weapon/ranged/bullet/pump/combat_shotgun
	icon = 'icons/obj/items/weapons/ranged/combat_shotgun.dmi'
	icon_state = "inventory_open"

/obj/structure/interactive/localmachine/item/weapon/heavy_snip
	stored_item = /obj/item/weapon/ranged/bullet/magazine/heavy_sniper


//Ammo
/obj/structure/interactive/localmachine/item/ammo/revolver_38
	stored_item = /obj/item/magazine/clip/revolver/bullet_38/

/obj/structure/interactive/localmachine/item/ammo/revolver_44
	stored_item = /obj/item/magazine/clip/revolver/bullet_44/

/obj/structure/interactive/localmachine/item/ammo/assault_rifle
	stored_item = /obj/item/magazine/rifle_762/

/obj/structure/interactive/localmachine/item/ammo/smg
	stored_item = /obj/item/magazine/smg_45/

/obj/structure/interactive/localmachine/item/ammo/shotgun
	stored_item = /obj/item/bullet/shotgun/buckshot

/obj/structure/interactive/localmachine/item/ammo/sniper50
	stored_item = /obj/item/magazine/sniper50



