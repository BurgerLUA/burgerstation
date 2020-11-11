/obj/structure/interactive/vending/old_ammo
	name = "ancient ammo vendor"
	desc = "What a weird selection of ammo..."
	desc_extended = "An old, suprisingly intact ammo vendor."
	icon_state = "liberationstation"

	stored_types = list(
		/obj/item/magazine/pistol_45,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/clip/revolver/bullet_357,
		/obj/item/magazine/clip/revolver/bullet_38,
		/obj/item/magazine/clip/revolver/bullet_44,
		/obj/item/magazine/sniper_50,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_308,
		/obj/item/bullet_cartridge/shotgun_12/buckshot,
		/obj/item/bullet_cartridge/shotgun_12/slug
	)

/obj/structure/interactive/vending/old_ammo/Finalize()

	var/list/possible_ammo = (subtypesof(/obj/item/magazine/) - typesof(/obj/item/magazine/clip/)) - stored_types

	for(var/i=1,i<=5,i++)
		var/selection = pick(possible_ammo)
		possible_ammo -= selection
		CREATE(selection,src.loc)

	return ..()