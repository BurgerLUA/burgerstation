/loot/syndicate/vault
	loot_table = list(
		/obj/item/supply_crate/syndicate = 1,
		/loot/currency/telecrystals = 1,
		/obj/item/storage/kit/syndicate/filled = 1,
		/obj/item/attachment/barrel/charger/advanced = 1,
		/obj/item/attachment/barrel/laser_charger/advanced = 1,
		/obj/item/clothing/glasses/sun/gar = 1,
		/obj/item/clothing/glasses/sun/gar/giga = 1,
		/loot/currency/gold_bar = 1
	)
	loot_count = 1
	use_value = TRUE

/loot/syndicate/vault/secure
	loot_table = list(
		/obj/item/clothing/back/storage/backpack/bluespace = 1,
		/obj/item/clothing/back/storage/satchel/bluespace = 1,
		/obj/item/powercell/bluespace = 1,
		/obj/item/clothing/head/hat/pete = 1,
		/obj/item/clothing/overwear/armor/seva/syndie = 1,
		/obj/item/weapon/ranged/bow/hardlight = 1,
		/obj/item/storage/bagofhoarding = 1
	)
	loot_count = 1

/loot/syndicate/lunch
	loot_table = list(
		/loot/misc/food = 1,
		/loot/misc/drink = 1,
		/obj/item/container/edible/package/junkfood/syndicate = 1,
		/obj/item/container/edible/package/junkfood/halloween/malf_way = 1,
		/obj/item/container/simple/can/dr_gibb = 1
	)
	loot_count = 2
	chance_none = 20
	allow_duplicates = FALSE

/loot/syndicate/medicine
	loot_table = list(
		/obj/item/container/simple/beaker/bottle/medium/brute_mix = 1,
		/obj/item/container/simple/beaker/bottle/medium/burn_mix = 1,
		/obj/item/container/simple/beaker/bottle/medium/toxin_mix = 1,
		/obj/item/container/simple/beaker/bottle/medium/death_mix = 1,
		/obj/item/container/simple/beaker/bottle/medium/rad_mix = 1,
		/obj/item/container/simple/beaker/bottle/medium/combat_mix = 1
	)
	loot_table_guaranteed = list(
		/obj/item/analyzer/health/syndicate,
		/loot/medicine/misc_medicine
	)
	loot_count = 3
	chance_none = 20
	allow_duplicates = FALSE

/loot/syndicate/bag
	loot_table = list(
		/obj/item/clothing/head/helmet/full/paperbag/syndicate{loot_to_generate=/loot/syndicate/lunch} = 1,
		/obj/item/clothing/mask/gas/poly/syndicate = 1,
		/obj/item/storage/cigarettes/syndicate = 1,
		/obj/item/storage/kit/syndicate{loot_to_generate=/loot/syndicate/medicine} = 1,
		/obj/item/supply_crate/syndicate = 1,
		/obj/item/attachment/barrel/suppressor = 1,
		/obj/item/cassette_tape = 1,
		/obj/item/cassette_player = 1,
		/loot/currency/telecrystals/small = 1,
		/obj/item/data_laptop = 1,
		/obj/item/deployable/barricade = 1,
		/obj/item/deployable/bodybag = 1,
		/obj/item/deployable/barricade = 1,
		/obj/item/dice/d6/black = 1,
		/obj/item/doctor_bag = 1,
		/obj/item/handcuffs = 1,
		/obj/item/tempering/luck = 1,
		/obj/item/tempering/quality/general = 1,
		/obj/item/container/simple/beaker/flask/engraved = 1
	)
	loot_table_guaranteed = list(
		/loot/currency/dosh/survivor,
		/obj/item/lighter
	)
	loot_count = 6
	chance_none = 20
	allow_duplicates = FALSE