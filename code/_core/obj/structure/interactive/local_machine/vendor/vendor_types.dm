/obj/structure/interactive/vendor/ammo
	name = "ammo vendor"
	icon_state = "liberationstation"

/obj/structure/interactive/vendor/clothes
	name = "clothes vendor"
	icon_state = "clothes"


/obj/structure/interactive/vendor/medicine
	name = "medicine vendor"
	icon_state = "med"

/obj/structure/interactive/vendor/engineering
	name = "engineering vendor"
	icon_state = "engivend"

/obj/structure/interactive/vendor/engineering/tool
	name = "tool vendor"
	icon_state = "tool"
	stored_types = list(
		/obj/item/weapon/melee/tool/crowbar,
		/obj/item/weapon/melee/tool/multitool,
		/obj/item/weapon/melee/tool/screwdriver,
		/obj/item/weapon/melee/tool/wirecutters,
		/obj/item/weapon/melee/tool/wrench
	)


/obj/structure/interactive/vendor/engineering/material
	name = "material vendor"
	stored_types = list(
		/obj/item/material/sheet/steel/spawn_50,
		/obj/item/material/glass/normal/spawn_50

	)

/obj/structure/interactive/vendor/robotics
	name = "robotics vendor"
	icon_state = "robotics"

/obj/structure/interactive/vendor/chaplain/wardrobe
	name = "chaplain wardrobe vendor"
	icon_state = "chapdrobe"

/obj/structure/interactive/vendor/security
	name = "security vendor"
	icon_state = "sec"

/obj/structure/interactive/vendor/security/wardrobe
	name = "security wardrobe vendor"
	icon_state = "secdrobe"


/obj/structure/interactive/vendor/chemistry/wardrobe
	name = "chemist wardrobe vendor"
	icon_state = "chemdrobe"


/obj/structure/interactive/vendor/clown/
	name = "clown vendor"
	icon_state = "games"

/obj/structure/interactive/vendor/clown/wardrobe
	name = "clown wardrobe vendor"
	icon_state = "theater"

/obj/structure/interactive/vendor/syndicate
	name = "syndicate vendor"
	icon_state = "syndi"

/obj/structure/interactive/vendor/hydroponics/nutri
	name = "garden vendor"
	icon_state = "nutri"

/obj/structure/interactive/vendor/mining
	name = "mining vendor"
	icon_state = "mining"


/obj/structure/interactive/vendor/soda
	name = "soda vendor"
	icon_state = "soda"

var/global/list/equipped_players = list()

/obj/structure/interactive/vendor/autolocker
	name = "autolocker vendor"
	icon_state = "gear"

	stored_types = list(
		/obj/item/clothing/back/storage/dufflebag/loadout/medical,
		/obj/item/clothing/back/storage/backpack/loadout/security,
		/obj/item/clothing/back/storage/backpack/explorer/loadout/miner,
		/obj/item/clothing/back/storage/dufflebag/loadout/pmc
	)

	is_free = TRUE
	free_text = "choose"

/obj/structure/interactive/vendor/autolocker/can_purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)
	. = ..()
	if(. && P && (P in equipped_players))
		P.to_chat(span("notice","You already selected your equipment!"))
		return FALSE
	return .

/obj/structure/interactive/vendor/autolocker/purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)
	. = ..()
	if(. && P && !(P in equipped_players))
		equipped_players += P
	return .