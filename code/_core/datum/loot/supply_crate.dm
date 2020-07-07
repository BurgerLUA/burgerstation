/loot/supply_crate
	loot_table = list(
		/loot/medicine/pack = 50
	)


/loot/supply_crate/russian
	loot_table = list(
		/loot/medicine/pack = 50,
		/loot/weapon/abakan = 10,
		/loot/weapon/groza = 10,
		/loot/weapon/ak13 = 10,
		/loot/weapon/svt = 10,
		/loot/weapon/val = 10,
		/loot/weapon/vintorez = 10,
		/loot/weapon/svd = 10,
		/loot/weapon/nagant_revolver = 10,
		/loot/weapon/russian_shotgun = 10,
		/loot/weapon/gauss_rifle = 10
	)

/loot/supply_crate/russian/pre_spawn(var/atom/movable/M)
	if(istype(M,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = M
		R.firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

	return ..()

/loot/supply_crate/nanotrasen
	loot_table = list(
		/loot/medicine/pack = 50,
		/loot/weapon/big_game_revolver = 10,
		/loot/weapon/assault_rifle = 10,
		/loot/weapon/grenade = 10,
		/loot/weapon/civil_defense_pistol = 10,
		/loot/weapon/civilian_carbine = 10,
		/loot/weapon/tungsten = 10,
		/loot/weapon/commander_revolver = 10,
		/loot/weapon/tribarrel_shotgun = 10
	)

/loot/supply_crate/american
	loot_table = list(
		/loot/medicine/pack = 50,
		/loot/weapon/deagle = 10,
		/loot/weapon/pistol_45 = 10,
		/loot/weapon/comp_revolver = 10,
		/loot/weapon/horse_revolver = 10,
		/loot/weapon/solarian_rifle = 10
	)

/loot/supply_crate/syndicate
	loot_table = list(
		/loot/medicine/pack = 50,
		/loot/weapon/high_cal = 10,
		/loot/weapon/stealth_pistol = 10,
		/loot/weapon/syndicate_carbine = 10,
		/loot/weapon/stealth_pistol = 10,
		/loot/weapon/marksman_mod = 10,
		/loot/weapon/sniper_cal_50 = 10,
		/loot/weapon/syringe_gun = 10,
		/loot/weapon/traitor_revolver = 10
	)

/loot/supply_crate/syndicate/pre_spawn(var/atom/movable/M)
	if(istype(M,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = M
		R.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

	return ..()