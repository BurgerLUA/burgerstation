/obj/structure/interactive/vending/ammo
	name = "ammo vendor"
	icon_state = "liberationstation"

/obj/structure/interactive/vending/ammo/pistol
	name = "pistol ammo vendor"
	stored_types = list(
		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_45,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/clip/revolver/bullet_38,
		/obj/item/magazine/clip/revolver/bullet_44
	)

/obj/structure/interactive/vending/ammo/auto
	name = "smg and rifle ammo vendor"

/obj/structure/interactive/vending/ammo/shotgun
	name = "shotgun ammo vendor"

/obj/structure/interactive/vending/clothes
	name = "clothes vendor"
	icon_state = "clothes"


/obj/structure/interactive/vending/medicine
	name = "medicine vendor"
	icon_state = "med"
	stored_types = list(
		/obj/item/container/medicine/bandage,
		/obj/item/container/medicine/ointment,
		/obj/item/container/medicine/trauma_kit,
		/obj/item/container/medicine/burn_kit,
		/obj/item/container/spray/silver_sulfadiazine,
		/obj/item/container/spray/styptic_powder,
		/obj/item/container/syringe/epinephrine
	)

/obj/structure/interactive/vending/engineering
	name = "engineering vendor"
	icon_state = "engivend"

/obj/structure/interactive/vending/engineering/tool
	name = "tool vendor"
	icon_state = "tool"
	stored_types = list(
		/obj/item/weapon/melee/tool/crowbar,
		/obj/item/weapon/melee/tool/multitool,
		/obj/item/weapon/melee/tool/screwdriver,
		/obj/item/weapon/melee/tool/wirecutters,
		/obj/item/weapon/melee/tool/wrench
	)


/obj/structure/interactive/vending/engineering/material
	name = "material vendor"
	stored_types = list(
		/obj/item/material/sheet/steel/spawn_50,
		/obj/item/material/sheet/glass/spawn_50

	)

/obj/structure/interactive/vending/robotics
	name = "robotics vendor"
	icon_state = "robotics"

/obj/structure/interactive/vending/chaplain/wardrobe
	name = "chaplain wardrobe vendor"
	icon_state = "chapdrobe"

/obj/structure/interactive/vending/security
	name = "security vendor"
	icon_state = "sec"

/obj/structure/interactive/vending/security/wardrobe
	name = "security wardrobe vendor"
	icon_state = "secdrobe"


/obj/structure/interactive/vending/chemistry/wardrobe
	name = "chemist wardrobe vendor"
	icon_state = "chemdrobe"


/obj/structure/interactive/vending/clown/
	name = "clown vendor"
	icon_state = "games"

/obj/structure/interactive/vending/clown/wardrobe
	name = "clown wardrobe vendor"
	icon_state = "theater"

/obj/structure/interactive/vending/syndicate
	name = "syndicate vendor"
	icon_state = "syndi"

/obj/structure/interactive/vending/hydroponics/nutri
	name = "garden vendor"
	icon_state = "nutri"

/obj/structure/interactive/vending/mining
	name = "mining vendor"
	icon_state = "mining"


/obj/structure/interactive/vending/soda
	name = "soda vendor"
	icon_state = "soda"

/obj/structure/interactive/vending/soda/full
	force_spawn_stored_types = TRUE
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

var/global/list/equipped_players = list()

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