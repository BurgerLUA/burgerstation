obj/item/clothing/back/storage/backpack/medical
	name = "medical backpack"
	icon = 'icons/obj/items/clothing/back/backpack/medical.dmi'

/obj/item/clothing/back/storage/backpack/medical/loadout/

/obj/item/clothing/back/storage/backpack/medical/loadout/medical
	name = "medical doctor dufflebag"
	color = "#FFFFFF"

/obj/item/clothing/back/storage/backpack/medical/loadout/medical/fill_inventory()
	new /obj/item/radio(src)
	new /obj/item/pinpointer/custom(src)
	new /obj/item/pinpointer/landmark(src)
	new /obj/item/pinpointer/crew(src)
	new /obj/item/clothing/uniform/jumpsuit/medical_doctor(src)
	new /obj/item/clothing/hands/gloves/colored(src)
	new /obj/item/clothing/hands/gloves/colored/left(src)
	new /obj/item/clothing/overwear/coat/labcoat/medical(src)
	new /obj/item/clothing/belt/storage/medical/filled(src)
	new /obj/item/storage/bags/chemistry(src)
	new /obj/item/clothing/glasses/medical_hud(src)
	new /obj/item/storage/pouch/double/lifesaver/filled(src)
	new /obj/item/storage/pouch/double/lifesaver/filled(src)
	new /obj/item/weapon/ranged/bullet/magazine/syringe_rifle(src)
	new /obj/item/storage/pouch/triple/syringe/filled(src)
	return ..()
