/obj/item/clothing/back/storage/dufflebag/syndicate
	name = "syndicate dufflebag"
	icon = 'icons/obj/item/clothing/back/dufflebag/syndicate.dmi'
	desc = "EVIL!"
	desc_extended = "A sturdy, yet lightweight black dufflebag. Doesn't slow you down at all for some reason."
	rarity = RARITY_MYTHICAL

	dynamic_inventory_count = MAX_INVENTORY_X*3

	size = MAX_INVENTORY_X*3*SIZE_3
	container_max_size = SIZE_4

	value = 200

	weight = 0




/obj/item/clothing/back/storage/dufflebag/syndicate/medical
	icon = 'icons/obj/item/clothing/back/dufflebag/syndicate_medical.dmi'


/obj/item/clothing/back/storage/dufflebag/syndicate/medical/field_doctor
	name = "field doctor's dufflebag"
	desc = "Pain and gain."
	desc_extended = "A sturdy, yet lightweight black dufflebag. This one has a medical logo on it."

/obj/item/clothing/back/storage/dufflebag/syndicate/medical/field_doctor/fill_inventory()
	//8 Medical shit
	new /obj/item/storage/kit/syndicate/filled(src)
	new /obj/item/storage/kit/syndicate/filled(src)
	new /obj/item/storage/kit/syndicate/filled(src)
	new /obj/item/storage/kit/syndicate/filled(src)
	new /obj/item/container/beaker/bottle/large/health_potion(src)
	new /obj/item/container/beaker/bottle/large/health_potion(src)
	new /obj/item/clothing/glasses/medical_hud/advanced(src)
	new /obj/item/defib(src)
	//5 Weapon shit
	new /obj/item/storage/ammo/buckshot(src)
	new /obj/item/storage/ammo/buckshot(src)
	new /obj/item/storage/ammo/slug(src)
	new /obj/item/storage/ammo/fire(src)
	new /obj/item/paper/syndicate_note(src)
	//10 Empty mags
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	new /obj/item/magazine/shotgun_auto/empty(src)
	//1 weapon
	new /obj/item/weapon/ranged/bullet/magazine/shotgun/bulldog(src)
	return ..()

/obj/item/clothing/back/storage/dufflebag/syndicate/ammo
	icon = 'icons/obj/item/clothing/back/dufflebag/syndicate_ammo.dmi'


/obj/item/clothing/back/storage/dufflebag/syndicate/ammo/fuck_you
	name = "juggernaut's dufflebag"
	desc = "Bitch."
	desc_extended = "A sturdy, yet lightweight black dufflebag. This one has am ammo logo on it."

/obj/item/clothing/back/storage/dufflebag/syndicate/ammo/fuck_you/fill_inventory()
	//8 Weapon shit.
	new /obj/item/weapon/ranged/bullet/magazine/rifle/lmg(src)
	new /obj/item/weapon/ranged/bullet/magazine/rifle/lmg(src)
	new /obj/item/magazine/lmg_223(src)
	new /obj/item/magazine/lmg_223(src)
	new /obj/item/magazine/lmg_223(src)
	new /obj/item/magazine/lmg_223(src)
	new /obj/item/magazine/lmg_223(src)
	new /obj/item/magazine/lmg_223(src)
	//8 sabotage shit
	new /obj/item/grenade/timed/explosive(src)
	new /obj/item/grenade/timed/explosive(src)
	new /obj/item/grenade/timed/explosive(src)
	new /obj/item/grenade/timed/explosive(src)
	new /obj/item/rcd(src)
	new /obj/item/disk/rcd/metal_wall(src)
	new /obj/item/matter_cartridge(src)
	new /obj/item/matter_cartridge(src)
	//8 whatever dude shit
	new /obj/item/deployable/barricade(src)
	new /obj/item/deployable/barricade(src)
	new /obj/item/deployable/barricade(src)
	new /obj/item/deployable/barricade(src)
	new /obj/item/deployable/barricade(src)
	new /obj/item/deployable/barricade(src)
	new /obj/item/deployable/barricade(src)
	new /obj/item/deployable/barricade(src)
	return ..()

/obj/item/clothing/back/storage/dufflebag/syndicate/normie
	name = "operative's dufflebag"
	desc = "VANILLA."
	desc_extended = "A sturdy, yet lightweight black dufflebag. This one has no logo on it because you're basic like that. Contains everything you need to be an operative."

/obj/item/clothing/back/storage/dufflebag/syndicate/normie/fill_inventory()
	//8 normal shit
	new /obj/item/clothing/overwear/hardsuit/syndie/elite(src)
	new /obj/item/clothing/overwear/hardsuit/syndie/elite(src)
	new /obj/item/pinpointer/artifact(src)
	new /obj/item/pinpointer/artifact(src)
	new /obj/item/weapon/melee/energy/sword/katana/black(src)
	new /obj/item/weapon/melee/energy/sword/katana/black(src)
	new /obj/item/grenade/timed/explosive(src)
	new /obj/item/grenade/timed/explosive(src)
	//8 secondary weapon shit
	new /obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre/mod(src)
	new /obj/item/magazine/pistol_12mm(src)
	new /obj/item/magazine/pistol_12mm(src)
	new /obj/item/magazine/pistol_12mm(src)
	new /obj/item/magazine/pistol_12mm(src)
	new /obj/item/magazine/pistol_12mm(src)
	new /obj/item/magazine/pistol_12mm(src)
	new /obj/item/magazine/pistol_12mm(src)
	//8 primary weapon shit
	new /obj/item/weapon/ranged/bullet/magazine/rifle/marksman(src)
	new /obj/item/magazine/rifle_308(src)
	new /obj/item/magazine/rifle_308(src)
	new /obj/item/magazine/rifle_308(src)
	new /obj/item/magazine/rifle_308(src)
	new /obj/item/magazine/rifle_308(src)
	new /obj/item/magazine/rifle_308(src)
	new /obj/item/magazine/rifle_308(src)
	return ..()


/obj/item/clothing/back/storage/dufflebag/syndicate/ammo/anti_tank
	name = "anti-tank sniper dufflebag"
	desc = "Fuck mechs."
	desc_extended = "A sturdy, yet lightweight black dufflebag. This one has am ammo logo on it."
	icon = 'icons/obj/item/clothing/back/dufflebag/syndicate_ammo.dmi'

/obj/item/clothing/back/storage/dufflebag/syndicate/ammo/anti_tank/fill_inventory()
	//8 normal shit
	new /obj/item/weapon/melee/energy/shield/classic(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	//13 primary weapon shit
	new /obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper(src)
	new /obj/item/magazine/sniper_50(src)
	new /obj/item/magazine/sniper_50(src)
	new /obj/item/magazine/sniper_50(src)
	new /obj/item/magazine/sniper_50/explosive(src)
	new /obj/item/magazine/sniper_50/explosive(src)
	new /obj/item/magazine/sniper_50/ion(src)
	new /obj/item/magazine/sniper_50/ion(src)
	new /obj/item/magazine/sniper_50/ion(src)
	new /obj/item/magazine/sniper_50/incendiary(src)
	new /obj/item/magazine/sniper_50/incendiary(src)
	new /obj/item/magazine/sniper_50/ap(src)
	new /obj/item/magazine/sniper_50/ap(src)
	//3 secondary weapon shit
	new /obj/item/weapon/ranged/energy/iongun(src)
	new /obj/item/powercell/industrial(src)
	new /obj/item/powercell/industrial(src)
	return ..()