/obj/item/weapon/ranged/unique/
	//Use /_unique/ for anything thats similar to a "hybrid" weapon, fitting neither in A or B, but exists as a mix.
	//Example: A flame thrower, needs ammo, but doesnt have bullets. Sprays a reagent, but that reagent doesnt actually get spread about.

	var/obj/item/stored_ammolike //Literally used for anything the weapon "needs" to shoot a payload, mag, battery,whatever.

/obj/item/weapon/ranged/unique/PreDestroy()
	QDEL_NULL(stored_ammolike)
	. = ..()

/obj/item/weapon/ranged/unique/save_item_data(mob/living/advanced/player/P, save_inventory, died, loadout)
	RUN_PARENT_SAFE
	SAVEATOM("stored_ammolike")

/obj/item/weapon/ranged/unique/load_item_data_pre(mob/living/advanced/player/P, list/object_data, loadout)
	RUN_PARENT_SAFE
	LOADATOM("stored_ammolike")



