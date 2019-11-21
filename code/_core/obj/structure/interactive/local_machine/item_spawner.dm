/obj/structure/interactive/localmachine/item
	name = "Item Spawner"
	desc = "Spawns the below item."
	var/obj/item/stored_item

	var/obj/item/cached_item

/obj/structure/interactive/localmachine/item/New()
	if(stored_item)
		cached_item = new stored_item(src.contents)
		cached_item.on_spawn()
		cached_item.update_icon()
		appearance = cached_item.appearance
		name = cached_item.name
		desc = cached_item.desc
		desc_extended = cached_item.desc_extended
	..()

/obj/structure/interactive/localmachine/item/clicked_on_by_object(caller,object,location,control,params)
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/obj/item/local_item_clone = new stored_item(loc)
		local_item_clone.on_spawn()
		local_item_clone.update_icon()
		if(A.client)
			A.client.MouseDown(local_item_clone,location,control,list2params(params))

	return ..()

//Clothing


/obj/structure/interactive/localmachine/item/clothing/neck/tie_white
	stored_item = /obj/item/clothing/neck/tie

/obj/structure/interactive/localmachine/item/clothing/neck/tie_red
	stored_item = /obj/item/clothing/neck/tie/red

/obj/structure/interactive/localmachine/item/clothing/neck/tie_black
	stored_item = /obj/item/clothing/neck/tie/black

/obj/structure/interactive/localmachine/item/clothing/coat
	stored_item = /obj/item/clothing/overwear/coat/

/obj/structure/interactive/localmachine/item/clothing/overwear/chaplain
	stored_item = /obj/item/clothing/overwear/coat/chaplain/

/obj/structure/interactive/localmachine/item/clothing/uniform/priest
	stored_item = /obj/item/clothing/uniform/priest

/obj/structure/interactive/localmachine/item/clothing/coat/wizard
	stored_item = /obj/item/clothing/overwear/coat/wizard/blue

/obj/structure/interactive/localmachine/item/clothing/hat/wizard
	stored_item = /obj/item/clothing/head/hat/wizard/blue

/obj/structure/interactive/localmachine/item/clothing/shoe_right
	stored_item = /obj/item/clothing/feet/shoes/brown

/obj/structure/interactive/localmachine/item/clothing/shoe_left
	stored_item = /obj/item/clothing/feet/shoes/brown/left

/obj/structure/interactive/localmachine/item/clothing/pants
	stored_item = /obj/item/clothing/pants/brown

/obj/structure/interactive/localmachine/item/clothing/armor
	stored_item = /obj/item/clothing/overwear/armor

/obj/structure/interactive/localmachine/item/clothing/armor/knight/red
	stored_item = /obj/item/clothing/overwear/armor/knight/red

/obj/structure/interactive/localmachine/item/clothing/armor/knight/blue
	stored_item = /obj/item/clothing/overwear/armor/knight/blue

/obj/structure/interactive/localmachine/item/clothing/armor/knight/green
	stored_item = /obj/item/clothing/overwear/armor/knight/green

/obj/structure/interactive/localmachine/item/clothing/armor/knight/yellow
	stored_item = /obj/item/clothing/overwear/armor/knight/yellow

/obj/structure/interactive/localmachine/item/clothing/armor/knight/templar
	stored_item = /obj/item/clothing/overwear/armor/knight/templar

/obj/structure/interactive/localmachine/item/clothing/armor/knight/battlemage
	stored_item = /obj/item/clothing/overwear/armor/knight/battlemage

/obj/structure/interactive/localmachine/item/clothing/armor/knight/syndie1
	stored_item = /obj/item/clothing/overwear/armor/hardsuit/syndie1

/obj/structure/interactive/localmachine/item/clothing/armor/knight/syndie2
	stored_item = /obj/item/clothing/overwear/armor/hardsuit/syndie2

/obj/structure/interactive/localmachine/item/clothing/helmet/knight/syndie1
	stored_item = /obj/item/clothing/head/helmet/hardsuit/syndie1

/obj/structure/interactive/localmachine/item/clothing/helmet/knight/syndie2
	stored_item = /obj/item/clothing/head/helmet/hardsuit/syndie2


/obj/structure/interactive/localmachine/item/clothing/helmet/knight/red
	stored_item = /obj/item/clothing/head/helmet/knight/red

/obj/structure/interactive/localmachine/item/clothing/helmet/knight/green
	stored_item = /obj/item/clothing/head/helmet/knight/green

/obj/structure/interactive/localmachine/item/clothing/helmet/knight/yellow
	stored_item = /obj/item/clothing/head/helmet/knight/yellow

/obj/structure/interactive/localmachine/item/clothing/helmet/knight/blue
	stored_item = /obj/item/clothing/head/helmet/knight/blue

/obj/structure/interactive/localmachine/item/clothing/helmet/knight/templar
	stored_item = /obj/item/clothing/head/helmet/knight/templar

/obj/structure/interactive/localmachine/item/clothing/helmet/knight/battlemage
	stored_item = /obj/item/clothing/head/helmet/knight/battlemage

/obj/structure/interactive/localmachine/item/clothing/cloak
	stored_item = /obj/item/clothing/neck/cloak

/obj/structure/interactive/localmachine/item/clothing/cloak/green
	stored_item = /obj/item/clothing/neck/cloak/green
	//color = "#008800"

/obj/structure/interactive/localmachine/item/clothing/sunglasses
	stored_item = /obj/item/clothing/glasses/sun

/obj/structure/interactive/localmachine/item/clothing/clownmask
	stored_item = /obj/item/clothing/mask/gas/clown

/obj/structure/interactive/localmachine/item/clothing/gasmask
	stored_item =/obj/item/clothing/mask/gas

/obj/structure/interactive/localmachine/item/clothing/ABOMB_uniform
	stored_item = /obj/item/clothing/uniform/ABOMB

/obj/structure/interactive/localmachine/item/clothing/jumpsuit_blue
	stored_item = /obj/item/clothing/uniform/jumpsuit/blue

/obj/structure/interactive/localmachine/item/clothing/tacticool_uniform
	stored_item = /obj/item/clothing/uniform/tacticool

/obj/structure/interactive/localmachine/item/clothing/tacticool_vest
	stored_item = /obj/item/clothing/overwear/armor/vest/

/obj/structure/interactive/localmachine/item/clothing/ABOMB_shades
	stored_item = /obj/item/clothing/glasses/sun/ABOMB

/obj/structure/interactive/localmachine/item/clothing/skimask
	stored_item = /obj/item/clothing/mask/skimask

/obj/structure/interactive/localmachine/item/clothing/military_helmet
	stored_item = /obj/item/clothing/head/helmet/security/tactical_helmet

/obj/structure/interactive/localmachine/item/clothing/military_helmet2
	stored_item = /obj/item/clothing/head/helmet/security/tactical_helmet2

/obj/structure/interactive/localmachine/item/clothing/boot_left
	stored_item = /obj/item/clothing/feet/shoes/black_boots/left

/obj/structure/interactive/localmachine/item/clothing/boot_right
	stored_item = /obj/item/clothing/feet/shoes/black_boots


/obj/structure/interactive/localmachine/item/clothing/sandal_right
	stored_item = /obj/item/clothing/feet/shoes/sandal

/obj/structure/interactive/localmachine/item/clothing/sandal_left
	stored_item = /obj/item/clothing/feet/shoes/sandal/left


/obj/structure/interactive/localmachine/item/clothing/black_shoe_left
	stored_item = /obj/item/clothing/feet/shoes/colored/black/left

/obj/structure/interactive/localmachine/item/clothing/black_shoe_right
	stored_item = /obj/item/clothing/feet/shoes/colored/black

/obj/structure/interactive/localmachine/item/clothing/gloves
	stored_item = /obj/item/clothing/hands/gloves/colored

/obj/structure/interactive/localmachine/item/clothing/gloves/left
	stored_item = /obj/item/clothing/hands/gloves/colored/left

/obj/structure/interactive/localmachine/item/clothing/gloves/black
	stored_item = /obj/item/clothing/hands/gloves/colored/black
	color = "#444444"

/obj/structure/interactive/localmachine/item/clothing/gloves/black/left
	stored_item = /obj/item/clothing/hands/gloves/colored/black/left
	color = "#444444"

/obj/structure/interactive/localmachine/item/clothing/beaverhat
	stored_item = /obj/item/clothing/head/hat/beaver

/obj/structure/interactive/localmachine/item/clothing/jumpsuit
	stored_item = /obj/item/clothing/uniform/jumpsuit

//Melee
/obj/structure/interactive/localmachine/item/weapon/melee/sword
	stored_item = /obj/item/weapon/melee/sword

/obj/structure/interactive/localmachine/item/weapon/melee/energy_sword
	stored_item = /obj/item/weapon/melee/energy/sword/
	icon = 'icons/obj/items/weapons/melee/laser/sword.dmi'
	icon_state = "inventory_on"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_sword/blue
	stored_item = /obj/item/weapon/melee/energy/sword/blue
	//color = "#0000FF"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_sword/red
	stored_item = /obj/item/weapon/melee/energy/sword/red
	//color = "#FF0000"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_sword/green
	stored_item = /obj/item/weapon/melee/energy/sword/green
	//color = "#00FF00"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_sword/yellow
	stored_item = /obj/item/weapon/melee/energy/sword/yellow
	//color = "#FFFF00"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_shield
	stored_item = /obj/item/weapon/melee/energy/shield/
	icon = 'icons/obj/items/weapons/melee/laser/shield.dmi'
	icon_state = "inventory_on"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_shield/blue
	stored_item = /obj/item/weapon/melee/energy/shield/blue
	//color = "#0000FF"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_shield/red
	stored_item = /obj/item/weapon/melee/energy/shield/red
	//color = "#FF0000"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_shield/green
	stored_item = /obj/item/weapon/melee/energy/shield/green
	//color = "#00FF00"

/obj/structure/interactive/localmachine/item/weapon/melee/energy_shield/yellow
	stored_item = /obj/item/weapon/melee/energy/shield/yellow
	//color = "#FFFF00"

/obj/structure/interactive/localmachine/item/weapon/melee/shield
	stored_item = /obj/item/weapon/melee/shield

/obj/structure/interactive/localmachine/item/weapon/melee/claymore
	stored_item = /obj/item/weapon/melee/sword/claymore

//Guns
/obj/structure/interactive/localmachine/item/weapon/ranged/detective
	stored_item = /obj/item/weapon/ranged/bullet/revolver/detective/
	icon = 'icons/obj/items/weapons/ranged/revolver.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/ranged/crossbow
	stored_item = /obj/item/weapon/ranged/bullet/crossbow/
	icon = 'icons/obj/items/weapons/ranged/crossbow.dmi'
	icon_state = "inventory_open"

/obj/structure/interactive/localmachine/item/weapon/ranged/mateba
	stored_item = /obj/item/weapon/ranged/bullet/revolver/mateba/
	icon = 'icons/obj/items/weapons/ranged/mateba.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/ranged/assault_rifle
	stored_item = /obj/item/weapon/ranged/bullet/magazine/assault_rifle
	icon = 'icons/obj/items/weapons/ranged/machine.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/ranged/smg
	stored_item = /obj/item/weapon/ranged/bullet/magazine/smg
	icon = 'icons/obj/items/weapons/ranged/smg.dmi'
	icon_state = "inventory_open"

/obj/structure/interactive/localmachine/item/weapon/ranged/dbarrel
	stored_item = /obj/item/weapon/ranged/bullet/revolver/dbarrel
	icon = 'icons/obj/items/weapons/ranged/dbarrel.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/ranged/combat_shotgun
	stored_item = /obj/item/weapon/ranged/bullet/pump/combat_shotgun
	icon = 'icons/obj/items/weapons/ranged/combat_shotgun.dmi'
	icon_state = "inventory_open"

/obj/structure/interactive/localmachine/item/weapon/ranged/heavy_snip
	stored_item = /obj/item/weapon/ranged/bullet/magazine/heavy_sniper

//Magic
/obj/structure/interactive/localmachine/item/weapon/ranged/magic/staff/fireball
	stored_item = /obj/item/weapon/ranged/magic/staff/fire
	icon = 'icons/obj/items/weapons/ranged/magic/fire.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/ranged/magic/staff/chaos
	stored_item = /obj/item/weapon/ranged/magic/staff/chaos
	icon = 'icons/obj/items/weapons/ranged/magic/chaos.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/ranged/magic/staff/basic
	stored_item = /obj/item/weapon/ranged/magic/staff/basic
	icon = 'icons/obj/items/weapons/ranged/magic/basic.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/ranged/magic/staff/focus
	stored_item = /obj/item/weapon/ranged/magic/staff/focus
	icon = 'icons/obj/items/weapons/ranged/magic/focus.dmi'
	icon_state = "inventory"

/obj/structure/interactive/localmachine/item/weapon/ranged/magic/scroll/fireball
	stored_item = /obj/item/weapon/ranged/magic/scroll/fireball/amount_3
	icon = 'icons/obj/items/weapons/ranged/magic/scroll.dmi'
	icon_state = "scroll_open"

/obj/structure/interactive/localmachine/item/weapon/ranged/magic/tome/lightning
	stored_item = /obj/item/weapon/ranged/magic/tome/lightning

/obj/structure/interactive/localmachine/item/weapon/ranged/magic/tome/heal
	stored_item = /obj/item/weapon/ranged/magic/tome/heal


/obj/structure/interactive/localmachine/item/weapon/ranged/magic/tome/holy_warrior
	stored_item = /obj/item/weapon/ranged/magic/tome/holy_warrior

//Ammo
/obj/structure/interactive/localmachine/item/ammo/soulgem
	stored_item = /obj/item/soulgem

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
	stored_item = /obj/item/magazine/sniper_50

/obj/structure/interactive/localmachine/item/ammo/bolt
	stored_item = /obj/item/bullet/bolt/


/obj/structure/interactive/localmachine/item/currency
	stored_item = /obj/item/currency/{value=100000}

