/loot/random/bullet/
	base_type = /obj/item/bullet_cartridge/

/loot/random/bullet/pre_spawn(var/atom/movable/M)

	. = ..()

	if(istype(M,/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = M
		B.amount = B.amount_max

/loot/random/magazine
	base_type = /obj/item/magazine/