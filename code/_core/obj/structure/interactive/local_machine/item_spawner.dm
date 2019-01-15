/obj/structure/interactive/localmachine/item
	name = "Item Spawner"
	desc = "Spawns the below item."
	var/obj/item/stored_item

/obj/structure/interactive/localmachine/item/New()
	if(stored_item)
		stored_item = new stored_item(src.contents)
		name = stored_item.name
		icon = stored_item.icon
		icon_state = stored_item.icon_state
		desc = stored_item.desc
	. = ..()

/obj/structure/interactive/localmachine/item/clicked_by_object(caller,object,location,control,params)
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/obj/item/local_item_clone = new stored_item.type(loc)
		if(A.client)
			A.client.MouseDown(local_item_clone,location,control,list2params(params))


	return ..()


/obj/structure/interactive/localmachine/item/coat
	stored_item = /obj/item/clothing/overwear/coat/

/obj/structure/interactive/localmachine/item/shoe_right
	stored_item = /obj/item/clothing/feet/shoes/brown

/obj/structure/interactive/localmachine/item/shoe_left
	stored_item = /obj/item/clothing/feet/shoes/brown/left

/obj/structure/interactive/localmachine/item/pants
	stored_item = /obj/item/clothing/pants/brown

/obj/structure/interactive/localmachine/item/armor
	stored_item = /obj/item/clothing/overwear/armor

/obj/structure/interactive/localmachine/item/weapon
	stored_item = /obj/item/weapon/ranged/bullet/revolver/detective

/obj/structure/interactive/localmachine/item/ammo
	stored_item = /obj/item/magazine/clip/revolver/bullet_38/full/


/obj/structure/interactive/localmachine/item/weapon/assault_rifle
	stored_item = /obj/item/weapon/ranged/bullet/magazine/assault_rifle

/obj/structure/interactive/localmachine/item/ammo/assault_rifle
	stored_item = /obj/item/magazine/rifle_762/full

/obj/structure/interactive/localmachine/item/weapon/smg
	stored_item = /obj/item/weapon/ranged/bullet/magazine/smg

/obj/structure/interactive/localmachine/item/ammo/smg
	stored_item = /obj/item/magazine/smg_45/full/
