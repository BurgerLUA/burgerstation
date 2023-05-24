//These are special loot tables that don't actually call internal loot functions
//Instead, the loot_table value is copied to a new instance and new values are calculated based on how fast you caught a fish.after it snags as well as the snag time.

#define CHANCE_JUNK 30
#define CHANCE_FAIR 20
#define CHANCE_GOOD 15
#define CHANCE_CRATE 7.5
#define CHANCE_MEME 5
#define CHANCE_GOD 0.5


/loot/fishing/sea
	loot_table = list(
		null = 200,
		/obj/item/clothing/feet/shoes/sandal = CHANCE_JUNK,
		/obj/item/clothing/feet/shoes/sandal/left = CHANCE_JUNK,
		/obj/item/clothing/head/hat/sombrero = CHANCE_JUNK,
		/obj/item/clothing/head/hat/sombrero/green = CHANCE_JUNK,
		/obj/item/clothing/head/hat/sombrero/pink = CHANCE_JUNK,
		/obj/item/container/edible/fishing/babycarp = CHANCE_FAIR,
		/obj/item/container/edible/fishing/clownfish = CHANCE_GOOD,
		/obj/item/container/edible/fishing/eel = CHANCE_GOOD,
		/obj/item/container/edible/fishing/glofish = CHANCE_GOOD,
		/obj/item/container/edible/fishing/shark = CHANCE_GOOD,
		/mob/living/simple/crab = CHANCE_MEME,
		/mob/living/simple/megacarp = CHANCE_MEME,
		/mob/living/simple/spacecarp = CHANCE_MEME,
		/mob/living/simple/bullshark = CHANCE_MEME,
		/obj/item/supply_crate/solarian = CHANCE_CRATE,
		/obj/item/supply_crate/magic = CHANCE_CRATE,
		/obj/item/supply_crate/nanotrasen = CHANCE_CRATE,
		/obj/item/supply_crate/slavic = CHANCE_CRATE,
		/obj/item/supply_crate/syndicate = CHANCE_CRATE,
		/loot/random/tempering = CHANCE_GOD,
		/obj/item/fishing/lure/t3 = CHANCE_GOOD,
		/obj/item/fishing/lure/t3_clown = CHANCE_GOOD,
		/obj/item/fishing/bait/sea/infinite = CHANCE_GOD,
	)

/loot/fishing/river
	loot_table = list(
		null = 200,
		/obj/item/clothing/feet/shoes/workboot = CHANCE_JUNK,
		/obj/item/clothing/feet/shoes/workboot/left = CHANCE_JUNK,
		/obj/item/clothing/head/hat/beaver = CHANCE_JUNK,
		/obj/item/clothing/head/helmet/old = CHANCE_JUNK,
		/obj/item/clothing/head/light/hardhat = CHANCE_JUNK,
		/obj/item/container/edible/fishing/catfish = CHANCE_FAIR,
		/obj/item/container/edible/fishing/generic = CHANCE_GOOD,
		/obj/item/container/edible/fishing/goldfish = CHANCE_FAIR,
		/obj/item/container/edible/fishing/salmon = CHANCE_FAIR,
		/mob/living/simple/bull = CHANCE_MEME,
		/mob/living/simple/bear = CHANCE_MEME,
		/obj/item/supply_crate/solarian = CHANCE_CRATE,
		/obj/item/supply_crate/magic = CHANCE_CRATE,
		/obj/item/supply_crate/nanotrasen = CHANCE_CRATE,
		/obj/item/supply_crate/slavic = CHANCE_CRATE,
		/obj/item/supply_crate/syndicate = CHANCE_CRATE	,
		/obj/item/weapon/ranged/spellgem/buckshot = CHANCE_MEME,
		/obj/item/tempering/luck = CHANCE_GOD,
		/obj/item/tempering/quality/melee = CHANCE_GOD,
		/obj/item/fishing/line/t3 = CHANCE_GOOD,
		/obj/item/fishing/line/t4 = CHANCE_GOOD,
		/obj/item/fishing/line/t5 = CHANCE_GOOD,
		/obj/item/fishing/bait/river/infinite = CHANCE_GOD




	)

/loot/fishing/lava
	loot_table = list(
		null = 300,
		/obj/item/clothing/feet/shoes/miner = CHANCE_JUNK,
		/obj/item/clothing/feet/shoes/miner/left = CHANCE_JUNK,
		/obj/item/clothing/head/helmet/full/miner = CHANCE_JUNK,
		/obj/item/clothing/mask/gas/mining = CHANCE_JUNK,
		/obj/item/clothing/mask/gas/syndicate = CHANCE_JUNK,
		/mob/living/simple/goliath = CHANCE_MEME,
		/mob/living/simple/goliath/ancient = CHANCE_MEME,
		/obj/item/supply_crate/solarian = CHANCE_CRATE,
		/obj/item/supply_crate/magic = CHANCE_CRATE,
		/obj/item/supply_crate/nanotrasen = CHANCE_CRATE,
		/obj/item/supply_crate/slavic = CHANCE_CRATE,
		/obj/item/supply_crate/syndicate = CHANCE_CRATE,
		/obj/item/fishing/rod/telescopic = CHANCE_GOD,
		/obj/item/dice/d20/cursed = CHANCE_GOD,
		/obj/item/coin/cursed = CHANCE_GOD,
		/loot/random/tempering = CHANCE_GOD,
		/obj/item/powercell/bluespace = CHANCE_GOD

	)
