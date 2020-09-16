/obj/structure/interactive/vending/ammo
	name = "ammo vendor"
	icon_state = "liberationstation"

/obj/structure/interactive/vending/ammo/pistol
	name = "pistol ammo vendor"
	stored_types = list(
		/obj/item/magazine/gyrojet,
		/obj/item/magazine/smp_9mm,
		/obj/item/magazine/pistol_12mm/nt,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_9mm,
	)

/obj/structure/interactive/vending/ammo/auto
	name = "smg, rifle ammo vendor"
	stored_types = list(
		/obj/item/magazine/sniper_762,
		/obj/item/magazine/lmg_762,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/smg_46
	)

/obj/structure/interactive/vending/ammo/shotgun
	name = "shotgun ammo vendor"
	stored_types = list(
		/obj/item/bullet_cartridge/shotgun_12/buckshot,
		/obj/item/bullet_cartridge/shotgun_12/slug,
		/obj/item/storage/ammo/buckshot,
		/obj/item/storage/ammo/slug
	)

/obj/structure/interactive/vending/clothes
	name = "clothes vendor"
	icon_state = "clothes"

/obj/structure/interactive/vending/clothes/dye
	name = "dye vendor"
	icon_state = "dye"
	stored_types = list(
		/obj/item/slime_core/red,
		/obj/item/slime_core/green,
		/obj/item/slime_core/blue,
		/obj/item/slime_core/black/weak,
		/obj/item/slime_core/white/weak,
		/obj/item/slime_core/white/strong
	)

/obj/structure/interactive/vending/clothes/shirt
	name = "shirt vendor"
	icon_state = "shirt"
	stored_types = list(
		/obj/item/clothing/shirt/normal,
		/obj/item/clothing/shirt/normal/striped,
		/obj/item/clothing/shirt/normal/uniform,
		/obj/item/clothing/shirt/blouse,
		/obj/item/clothing/shirt/blouse/frill,
		/obj/item/clothing/shirt/blouse/uniform,
		/obj/item/clothing/undertop/underwear/shirt
	)


/obj/structure/interactive/vending/clothes/overshirt
	name = "overwear vendor"
	icon_state = "overshirt"
	stored_types = list(
		/obj/item/clothing/overwear/coat/hoodie,
		/obj/item/clothing/overwear/coat/labcoat,
		/obj/item/clothing/overwear/coat/polymorphic
	)


/obj/structure/interactive/vending/clothes/underwear
	name = "underwear vendor"
	icon_state = "underwear"
	stored_types = list(
		/obj/item/clothing/feet/socks/ankle,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/feet/socks/knee/striped,
		/obj/item/clothing/feet/socks/thigh,
		/obj/item/clothing/feet/socks/thigh/striped,
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/underbottom/underwear/panty,
		/obj/item/clothing/underbottom/underwear/thong,
		/obj/item/clothing/undertop/underwear/bra,
		/obj/item/clothing/undertop/underwear/bra/sport
	)


/obj/structure/interactive/vending/clothes/pants
	name = "pants vendor"
	icon_state = "pants"
	stored_types = list(
		/obj/item/clothing/pants/normal,
		/obj/item/clothing/pants/normal/chaps,
		/obj/item/clothing/pants/normal/striped,
		/obj/item/clothing/pants/skirt,
		/obj/item/clothing/pants/skirt/striped,
		/obj/item/clothing/pants/kilt,

	)

/obj/structure/interactive/vending/clothes/shoes
	name = "shoes vendor"
	icon_state = "shoe"
	stored_types = list(
		/obj/item/storage/shoebox/black,
		/obj/item/storage/shoebox/colored,
		/obj/item/storage/shoebox/jackboot
	)

/obj/structure/interactive/vending/clothes/accessories
	name = "accessories vendor"
	icon_state = "accessories"
	stored_types = list(
		/obj/item/clothing/back/storage/backpack/,
		/obj/item/clothing/back/storage/dufflebag/,
		/obj/item/clothing/belt/storage/colored,
		/obj/item/clothing/head/hood/bandana,
		/obj/item/clothing/head/hood/skimask,
		/obj/item/clothing/neck/cape,
		/obj/item/clothing/neck/cloak,
		/obj/item/clothing/neck/tie,
		/obj/item/clothing/glasses/sun,
		/obj/item/storage/glovebox/white,
		/obj/item/clothing/glasses/eyepatch,
		/obj/item/clothing/head/hat/headband
	)

/obj/structure/interactive/vending/clothes/hat
	name = "hat vendor"
	icon_state = "hat"
	stored_types = list(
		/obj/item/clothing/head/hat/beret,
		/obj/item/clothing/head/hat/cat,
		/obj/item/clothing/head/hat/top,
		/obj/item/clothing/head/hat/wizard
	)

/obj/structure/interactive/vending/medical/
	name = "medicine vendor"
	icon_state = "med"


/obj/structure/interactive/vending/medical/medicine
	name = "medicine vendor"
	icon_state = "med"
	stored_types = list(
		/obj/item/container/medicine/bandage,
		/obj/item/container/medicine/ointment,
		/obj/item/container/medicine/trauma_kit,
		/obj/item/container/medicine/burn_kit,
		/obj/item/container/spray/silver_sulfadiazine,
		/obj/item/container/spray/styptic_powder,
		/obj/item/container/syringe/epinephrine,
		/obj/item/storage/pillbottle/bicaridine_small,
		/obj/item/storage/pillbottle/kelotane_small,
		/obj/item/storage/pillbottle/dylovene_small,
		/obj/item/storage/pillbottle/iron_small,
		/obj/item/storage/pillbottle/antihol_small
	)

/obj/structure/interactive/vending/medical/chemistry
	name = "chemistry vendor"
	icon_state = "chem"
	stored_types = list(
		/obj/item/storage/bags/chemistry,
		/obj/item/storage/pillbottle,
		/obj/item/container/syringe,
		/obj/item/container/beaker/vial,
		/obj/item/container/beaker/bottle/large,
		/obj/item/container/beaker/bottle,
		/obj/item/container/beaker,
		/obj/item/container/beaker/large,
		/obj/item/crafting/alchemy,
		/obj/item/crafting/pill_press
	)

/obj/structure/interactive/vending/medical/wardrobe
	name = "medical wardrobe vendor"
	icon_state = "medidrobe"
	stored_types = list(
		/obj/item/clothing/underbottom/underwear/boxers/medical,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/normal/medical,
		/obj/item/clothing/pants/normal/medical,
		/obj/item/clothing/overwear/coat/labcoat/medical,
		/obj/item/storage/glovebox/white
	)



/obj/structure/interactive/vending/engineering
	name = "engineering vendor"
	icon_state = "engivend"

/obj/structure/interactive/vending/engineering/tool
	name = "tool vendor"
	icon_state = "tool"
	stored_types = list(
		/obj/item/weapon/melee/toolbox/blue,
		/obj/item/weapon/melee/toolbox/red,
		/obj/item/weapon/melee/toolbox/green,
		/obj/item/weapon/melee/toolbox/yellow,
		/obj/item/weapon/melee/tool/crowbar,
		/obj/item/weapon/melee/tool/multitool,
		/obj/item/weapon/melee/tool/screwdriver,
		/obj/item/weapon/melee/tool/wirecutters,
		/obj/item/weapon/melee/tool/wrench,
		/obj/item/weapon/melee/torch/flashlight
	)


/obj/structure/interactive/vending/engineering/material
	name = "material vendor"
	icon_state = "engivend"
	stored_types = list(
		/obj/item/material/sheet/steel/spawn_50,
		/obj/item/material/sheet/glass/spawn_50

	)

/obj/structure/interactive/vending/engineering/engidrobe
	name = "engineering clothing vendor"
	icon_state = "engidrobe"
	stored_types = list(
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/underbottom/underwear/boxers/engineering,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/normal/engineering,
		/obj/item/clothing/shirt/normal/engineering
	)

/obj/structure/interactive/vending/robotics
	name = "robotics vendor"
	icon_state = "robotics"

/obj/structure/interactive/vending/robotics/mech_gun_fabricator
	name = "mech fabricator"
	icon_state = "mech"
	stored_types = list(
		/obj/item/mech_part/equipment/weapon/smg,
		/obj/item/mech_part/equipment/weapon/rifle,
		/obj/item/mech_part/equipment/weapon/laser,
		/obj/item/mech_part/equipment/weapon/ion,
		/obj/item/mech_part/equipment/weapon/missile_pod,

		/obj/item/mech_part/legs/loader,
		/obj/item/mech_part/legs/light,
		/obj/item/mech_part/legs/combat,
		/obj/item/mech_part/legs/heavy,
		/obj/item/mech_part/legs/spiderlegs,
		/obj/item/mech_part/legs/tracks,

		/obj/item/mech_part/body/loader,
		/obj/item/mech_part/body/light,
		/obj/item/mech_part/body/combat,
		/obj/item/mech_part/body/heavy,
		/obj/item/mech_part/body/pod,

		/obj/item/mech_part/head/light,
		/obj/item/mech_part/head/combat,
		/obj/item/mech_part/head/heavy,

		/obj/item/mech_part/arms/loader,
		/obj/item/mech_part/arms/light,
		/obj/item/mech_part/arms/combat,
		/obj/item/mech_part/arms/heavy,

		/obj/item/weapon/melee/tool/wrench,
		/obj/item/weapon/melee/tool/screwdriver,
		/obj/item/weapon/melee/tool/multitool,
		/obj/item/powercell/vehicle
	)

/obj/structure/interactive/vending/chaplain/wardrobe
	name = "chaplain wardrobe vendor"
	icon_state = "chapdrobe"

/obj/structure/interactive/vending/chemistry/wardrobe
	name = "chemist wardrobe vendor"
	icon_state = "chemdrobe"

/*
/obj/structure/interactive/vending/clown/
	name = "clown vendor"
	icon_state = "games"
	stored_types = list(
		/obj/item/instrument/accordion,
		/obj/item/instrument/banjo,
		/obj/item/instrument/bikehorn,
		/obj/item/instrument/eguitar,
		/obj/item/instrument/glockenspiel,
		/obj/item/instrument/guitar,
		/obj/item/instrument/harmonica,
		/obj/item/instrument/recorder,
		/obj/item/instrument/saxophone,
		/obj/item/instrument/trombone,
		/obj/item/instrument/violin
	)
*/

/obj/structure/interactive/vending/clown/wardrobe
	name = "clown wardrobe vendor"
	icon_state = "theater"

	stored_types = list(
		/obj/item/clothing/mask/gas/clown,
		/obj/item/clothing/uniform/clown,
		/obj/item/storage/shoebox/clown,
		/obj/item/fluff/bikehorn,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube
	)

/obj/structure/interactive/vending/hydroponics/nutri
	name = "garden vendor"
	icon_state = "nutri"


/obj/structure/interactive/vending/soda
	name = "soda vendor"
	icon_state = "soda"

/obj/structure/interactive/vending/soda/New(var/desired_loc)
	icon_state = pick("soda","sodablue","sodablack","sodapurple","sodaorange")
	return ..()

/obj/structure/interactive/vending/soda/full
	stored_types = list(
		/obj/item/container/beaker/can/cola,
		/obj/item/container/beaker/can/dr_gibb,
		/obj/item/container/beaker/can/grape_soda,
		/obj/item/container/beaker/can/grey_bull,
		/obj/item/container/beaker/can/iced_tea,
		/obj/item/container/beaker/can/mountain_wind,
		/obj/item/container/beaker/can/orange_soda,
		/obj/item/container/beaker/can/space_up
	)

/*
/obj/structure/interactive/vending/autolocker
	name = "autolocker vendor"
	icon_state = "gear"

	stored_types = list(
		/obj/item/clothing/back/storage/backpack/medical/loadout/medical,
		/obj/item/clothing/back/storage/backpack/loadout/security,
		/obj/item/clothing/back/storage/backpack/explorer/loadout/miner,
		/obj/item/clothing/back/storage/dufflebag/loadout/pmc,
		/obj/item/clothing/back/storage/dufflebag/engineering/loadout,
		/obj/item/clothing/back/storage/satchel/bluespace/loadout/science,
		/obj/item/clothing/back/storage/satchel/loadout/stealth
	)

	is_free = TRUE
	free_text = "choose"

/obj/structure/interactive/vending/autolocker/can_purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)
	. = ..()
	if(. && P && (P in equipped_players))
		P.to_chat(span("notice","You already selected your equipment!"))
		return FALSE
	return .

/obj/structure/interactive/vending/autolocker/purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)
	. = ..()
	if(. && P && !(P in equipped_players))
		equipped_players += P
	return .
*/

/obj/structure/interactive/vending/junk
	name = "snack vendor"
	icon_state = "snack"

/obj/structure/interactive/vending/junk/New(var/desired_loc)
	icon_state = pick("snack","snackblue","snackorange","snackgreen","snackteal")
	return ..()

/obj/structure/interactive/vending/junk/full
	stored_types = list(
		/obj/item/container/food/package/junkfood/cake,
		/obj/item/container/food/package/junkfood/candy,
		/obj/item/container/food/package/junkfood/cheese_chips,
		/obj/item/container/food/package/junkfood/chips,
		/obj/item/container/food/package/junkfood/jerky,
		/obj/item/container/food/package/junkfood/raisins
	)

/obj/structure/interactive/vending/smart_fridge
	name = "smart fridge"
	icon_state = "smartfridge"
	plane = PLANE_WALL_ATTACHMENTS
	pixel_y = 0

/obj/structure/interactive/vending/smart_fridge/chemistry
	name = "chemistry smart fridge"
	stored_types = list(
		/obj/item/container/beaker/bottle/epinephrine,
		/obj/item/container/beaker/bottle/dylovene,
		/obj/item/container/beaker/bottle/kelotane,
		/obj/item/container/beaker/bottle/bicaridine
	)

/obj/structure/interactive/vending/smart_fridge/kitchen
	name = "kitchen smart fridge"
	stored_types = list(
		/obj/item/container/beaker/vial/enzymes,
		/obj/item/container/beaker/food/flour,
		/obj/item/container/beaker/food/sugar,
		/obj/item/container/beaker/food/milk,
		/obj/item/container/beaker/food/cream,
		/obj/item/container/beaker/food/corn_flour,
		/obj/item/storage/egg_carton,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/beaker/bottle/large/water
	)


/obj/structure/interactive/vending/smart_fridge/bar
	name = "bar smart fridge"
	icon_state = "boozeomat"
	stored_types = list(
		/obj/item/container/beaker/glass,
		/obj/item/container/beaker/shot,
		/obj/item/container/beaker/alcohol/absinthe,
		/obj/item/container/beaker/alcohol/ale,
		/obj/item/container/beaker/alcohol/beer,
		/obj/item/container/beaker/alcohol/brandy,
		/obj/item/container/beaker/alcohol/cider,
		/obj/item/container/beaker/alcohol/coffee_liqueur,
		/obj/item/container/beaker/alcohol/fernet,
		/obj/item/container/beaker/alcohol/gin,
		/obj/item/container/beaker/alcohol/grappa,
		/obj/item/container/beaker/alcohol/hearty_punch,
		/obj/item/container/beaker/alcohol/nothing,
		/obj/item/container/beaker/alcohol/rum,
		/obj/item/container/beaker/alcohol/tequila,
		/obj/item/container/beaker/alcohol/vodka,
		/obj/item/container/beaker/alcohol/whiskey,
		/obj/item/container/beaker/alcohol/wine,
		/obj/item/container/beaker/alcohol/wine/vermouth,
		/obj/item/container/beaker/can/cola,
		/obj/item/container/beaker/can/dr_gibb,
		/obj/item/container/beaker/can/grape_soda,
		/obj/item/container/beaker/can/grey_bull,
		/obj/item/container/beaker/can/iced_tea,
		/obj/item/container/beaker/can/mountain_wind,
		/obj/item/container/beaker/can/orange_soda,
		/obj/item/container/beaker/can/space_up
	)


/obj/structure/interactive/vending/dinnerware
	name = "dinnerware vendor"
	icon_state = "dinnerware"

	stored_types = list(
		/obj/item/weapon/melee/sword/sabre,
		/obj/item/container/cheese_mold/block,
		/obj/item/container/beaker/glass,
		/obj/item/container/beaker/bowl,
		/obj/item/container/beaker/large,
		/obj/item/clothing/head/hat/paperbag,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/water
	)


/obj/structure/interactive/vending/experimental
	name = "experimental vendor"
	icon_state = "experimental"
	desc = "For science! (And balance.)"
	desc_extended = "An experimental vendor that vends even more experimental weapons, armor, and clothing. Use at your own risk!"

	stored_types = list(
		/obj/item/clothing/uniform/stealth,
		/obj/item/clothing/head/helmet/nanotrasen/light,
		/obj/item/clothing/head/helmet/nanotrasen/medium,
		/obj/item/clothing/head/helmet/nanotrasen/heavy,
		/obj/item/clothing/overwear/armor/nanotrasen/light,
		/obj/item/clothing/overwear/armor/nanotrasen/medium,
		/obj/item/clothing/overwear/armor/nanotrasen/heavy
	)
