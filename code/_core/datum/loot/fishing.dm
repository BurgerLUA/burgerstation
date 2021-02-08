//These are special loot tables that don't actually call internal loot functions
//Instead, the loot_table value is copied to a new instance and new values are calculated based on how fast you caught a fish.after it snags as well as the snag time.

#define CHANCE_JUNK 10
#define CHANCE_FAIR 40
#define CHANCE_GOOD 30
#define CHANCE_CRATE 20
#define CHANCE_MEME 5
#define CHANCE_GOD 0


/loot/fishing/sea
	loot_table = list(
		null = 500,
		/obj/item/trash/candy = CHANCE_JUNK,
		/obj/item/trash/cheese_chips = CHANCE_JUNK,
		/obj/item/trash/chips = CHANCE_JUNK,
		/obj/item/trash/jerky = CHANCE_JUNK,
		/obj/item/trash/raisins = CHANCE_JUNK,
		/obj/item/trash/syndicate = CHANCE_JUNK,
		/obj/item/clothing/feet/shoes/sandal = CHANCE_JUNK,
		/obj/item/clothing/feet/shoes/sandal/left = CHANCE_JUNK,
		/obj/item/clothing/head/hat/sombrero = CHANCE_JUNK,
		/obj/item/clothing/head/hat/sombrero/green = CHANCE_JUNK,
		/obj/item/clothing/head/hat/sombrero/pink = CHANCE_JUNK,
		/obj/item/container/food/fishing/babycarp = CHANCE_FAIR,
		/obj/item/container/food/fishing/clownfish = CHANCE_GOOD,
		/obj/item/container/food/fishing/eel = CHANCE_GOOD,
		/obj/item/container/food/fishing/glofish = CHANCE_GOOD,
		/obj/item/container/food/fishing/shark = CHANCE_GOOD,
		/mob/living/simple/crab = CHANCE_MEME,
		/mob/living/simple/megacarp = CHANCE_MEME,
		/mob/living/simple/spacecarp = CHANCE_MEME,
		/mob/living/simple/bullshark = CHANCE_MEME,
		/obj/item/supply_crate/american = CHANCE_CRATE,
		/obj/item/supply_crate/magic = CHANCE_CRATE,
		/obj/item/supply_crate/nanotrasen = CHANCE_CRATE,
		/obj/item/supply_crate/russian = CHANCE_CRATE,
		/obj/item/supply_crate/syndicate = CHANCE_CRATE,
		/obj/item/tempering/quality/clothing = CHANCE_GOD,
		/obj/item/tempering/quality/energy = CHANCE_GOD,
		/obj/item/fishing/lure/t3 = CHANCE_GOOD,
		/obj/item/fishing/lure/t3_clown = CHANCE_GOOD,
		/obj/item/fishing/bait/sea/infinite = CHANCE_GOD,
	)

/loot/fishing/river
	loot_table = list(
		null = 500,
		/obj/item/trash/candy = CHANCE_JUNK,
		/obj/item/trash/cheese_chips = CHANCE_JUNK,
		/obj/item/trash/chips = CHANCE_JUNK,
		/obj/item/trash/jerky = CHANCE_JUNK,
		/obj/item/trash/raisins = CHANCE_JUNK,
		/obj/item/trash/syndicate = CHANCE_JUNK,
		/obj/item/clothing/feet/shoes/workboot = CHANCE_JUNK,
		/obj/item/clothing/feet/shoes/workboot/left = CHANCE_JUNK,
		/obj/item/clothing/head/hat/beaver = CHANCE_JUNK,
		/obj/item/clothing/head/helmet/security/old = CHANCE_JUNK,
		/obj/item/clothing/head/light/hardhat = CHANCE_JUNK,
		/obj/item/container/food/fishing/catfish = CHANCE_FAIR,
		/obj/item/container/food/fishing/generic = CHANCE_GOOD,
		/obj/item/container/food/fishing/goldfish = CHANCE_FAIR,
		/obj/item/container/food/fishing/salmon = CHANCE_FAIR,
		/mob/living/simple/bull = CHANCE_MEME,
		/mob/living/simple/bear = CHANCE_MEME,
		/obj/item/supply_crate/american = CHANCE_CRATE,
		/obj/item/supply_crate/magic = CHANCE_CRATE,
		/obj/item/supply_crate/nanotrasen = CHANCE_CRATE,
		/obj/item/supply_crate/russian = CHANCE_CRATE,
		/obj/item/supply_crate/syndicate = CHANCE_CRATE	,	,
		/obj/item/tempering/luck = CHANCE_GOD,
		/obj/item/tempering/quality/melee = CHANCE_GOD,
		/obj/item/fishing/line/t3 = CHANCE_GOOD,
		/obj/item/fishing/line/t4 = CHANCE_GOOD,
		/obj/item/fishing/line/t5 = CHANCE_GOOD,
		/obj/item/fishing/bait/river/infinite = CHANCE_GOD




	)

/loot/fishing/lava
	loot_table = list(
		null = 500,
		/obj/item/clothing/feet/shoes/miner = CHANCE_JUNK,
		/obj/item/clothing/feet/shoes/miner/left = CHANCE_JUNK,
		/obj/item/clothing/head/helmet/full/miner = CHANCE_JUNK,
		/obj/item/clothing/mask/gas/mining = CHANCE_JUNK,
		/obj/item/clothing/mask/gas/syndicate = CHANCE_JUNK,
		/mob/living/simple/goliath = CHANCE_MEME,
		/mob/living/simple/goliath/ancient = CHANCE_MEME,
		/obj/item/supply_crate/american = CHANCE_CRATE,
		/obj/item/supply_crate/magic = CHANCE_CRATE,
		/obj/item/supply_crate/nanotrasen = CHANCE_CRATE,
		/obj/item/supply_crate/russian = CHANCE_CRATE,
		/obj/item/supply_crate/syndicate = CHANCE_CRATE,
		/obj/item/dice/d20/cursed = CHANCE_GOD,
		/obj/item/tempering/quality/magic = CHANCE_GOD,
		/obj/item/tempering/quality/ranged = CHANCE_GOD,
		/obj/item/storage/ammo/fire = CHANCE_GOD,
		/obj/item/powercell/bluespace = CHANCE_GOD

	)