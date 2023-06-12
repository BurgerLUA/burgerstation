var/global/list/shield_price_mul = list(
	ATTACK_TYPE_UNARMED = 0.75,
	ATTACK_TYPE_MELEE = 0.5,
	ATTACK_TYPE_RANGED = 2,
	ATTACK_TYPE_MAGIC = 3
)

/obj/item/weapon/melee/shield
	name = "basic wooden shield"
	desc = "For the basic."
	desc_extended = "Good for blocking melee attacks."
	icon = 'icons/obj/item/shields/wooden.dmi'
	damage_type = /damagetype/melee/club/shield

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.5,
		ATTACK_TYPE_MELEE = 0.9,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0.25
	)

	weight = 6
	size = SIZE_4

	value = 100

	block_sound = 'sound/effects/impacts/shield_wood.ogg'

	rarity = RARITY_COMMON

/obj/item/weapon/melee/shield/get_base_value()

	. = ..()

	var/total_block = 0
	for(var/k in block_defense)
		var/v = block_defense[k]*100
		. += (v**1.2) * shield_price_mul[k]
		total_block += v

	. += total_block**1.1

	. = CEILING(.,1)

/obj/item/weapon/melee/shield/get_examine_list(var/mob/examiner)
	. = ..()
	for(var/k in block_defense)
		var/v = block_defense[k]
		. += div("notice","[capitalize(k)] block: [v*100]%.")

/obj/item/weapon/melee/shield/ballistic
	name = "ballistic shield"
	icon = 'icons/obj/item/shields/ballistic.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.75,
		ATTACK_TYPE_MELEE = 0.75,
		ATTACK_TYPE_RANGED = 1,
		ATTACK_TYPE_MAGIC = 0
	)
	weight = 25
	size = SIZE_7

	value = 500

	block_sound = 'sound/effects/impacts/shield_metal.ogg'

	rarity = RARITY_UNCOMMON

/obj/item/weapon/melee/shield/glass
	name = "magic glass shield"
	icon = 'icons/obj/item/shields/glass.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.5,
		ATTACK_TYPE_MELEE = 0.85,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0.9
	)

	block_sound = 'sound/effects/impacts/shield_metal.ogg'

	value = 800

	rarity = RARITY_RARE

/obj/item/weapon/melee/shield/buckler
	name = "hardened steel buckler"
	icon = 'icons/obj/item/shields/buckler.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.9,
		ATTACK_TYPE_MELEE = 0.9,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0.25
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(6,0,-6,0)
	dan_offset_pixel_y = list(-2,-2,-2,-2)

	value = 200

	rarity = RARITY_COMMON

/obj/item/weapon/melee/shield/great
	name = "iron great shield"
	icon = 'icons/obj/item/shields/great.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 1,
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0.5,
		ATTACK_TYPE_MAGIC = 0
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(4,0,-4,0)
	dan_offset_pixel_y = list(-2,-2,-2,-2)

	block_sound = 'sound/effects/impacts/shield_metal.ogg'

	value = 900

	rarity = RARITY_RARE

/obj/item/weapon/melee/shield/heartstone
	name = "heartstone shield"
	icon = 'icons/obj/item/shields/heartstone.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.5,
		ATTACK_TYPE_MELEE = 0.75,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0.9
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(5,0,-5,0)
	dan_offset_pixel_y = list(-2,-2,-2,-2)

	block_sound = 'sound/effects/impacts/shield_polymer.ogg'

	value = 600

	rarity = RARITY_RARE


/obj/item/weapon/melee/shield/holy_forest
	name = "holy forest shield"
	icon = 'icons/obj/item/shields/holy_forest.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.5,
		ATTACK_TYPE_MELEE = 0.9,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0.75
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(6,0,-6,0)
	dan_offset_pixel_y = list(-1,-1,-1,-1)

	dan_mode = TRUE

	block_sound = 'sound/effects/impacts/shield_wood.ogg'

	value = 600

	rarity = RARITY_RARE

/obj/item/weapon/melee/shield/leather
	name = "leather-steel shield"
	icon = 'icons/obj/item/shields/leather.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.5,
		ATTACK_TYPE_MELEE = 0.9,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(5,0,-5,0)
	dan_offset_pixel_y = list(-1,-1,-1,-1)

	block_sound = 'sound/effects/impacts/shield_wood.ogg'

	value = 200

	rarity = RARITY_COMMON

/obj/item/weapon/melee/shield/mirror
	name = "great mirror shield"
	icon = 'icons/obj/item/shields/mirror.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.5,
		ATTACK_TYPE_MELEE = 0.9,
		ATTACK_TYPE_RANGED = 0.9,
		ATTACK_TYPE_MAGIC = 0.9
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(6,0,-6,0)
	dan_offset_pixel_y = list(-2,-2,-2,-2)

	block_sound = 'sound/effects/impacts/shield_polymer.ogg'

	value = 1200

	rarity = RARITY_RARE

/obj/item/weapon/melee/shield/redstar
	name = "slavic redstar shield"
	icon = 'icons/obj/item/shields/redstar.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.85,
		ATTACK_TYPE_MELEE = 0.85,
		ATTACK_TYPE_RANGED = 0.5,
		ATTACK_TYPE_MAGIC = 0.25
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(5,0,-5,0)
	dan_offset_pixel_y = list(-2,-2,-2,-2)

	block_sound = 'sound/effects/impacts/shield_wood.ogg'

	value = 300

	rarity = RARITY_UNCOMMON

/obj/item/weapon/melee/shield/spider
	name = "red spider shield"
	icon = 'icons/obj/item/shields/spider.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.8,
		ATTACK_TYPE_MELEE = 0.9,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(6,0,-6,0)
	dan_offset_pixel_y = list(-2,-2,-2,-2)

	block_sound = 'sound/effects/impacts/shield_wood.ogg'

	value = 300

	rarity = RARITY_UNCOMMON

/obj/item/weapon/melee/shield/sun
	name = "sun shield"
	icon = 'icons/obj/item/shields/sun.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.5,
		ATTACK_TYPE_MELEE = 0.9,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0.75
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(6,0,-6,0)
	dan_offset_pixel_y = list(-1,-1,-1,-1)

	block_sound = 'sound/effects/impacts/shield_wood.ogg'

	value = 400

	rarity = RARITY_UNCOMMON

/obj/item/weapon/melee/shield/target
	name = "iron target shield"
	icon = 'icons/obj/item/shields/target.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.9,
		ATTACK_TYPE_MELEE = 0.9,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(6,0,-6,0)
	dan_offset_pixel_y = list(-2,-2,-2,-2)

	block_sound = 'sound/effects/impacts/shield_metal.ogg'

	value = 300

	rarity = RARITY_COMMON

/obj/item/weapon/melee/shield/whitewood
	name = "whitewood magic shield"
	icon = 'icons/obj/item/shields/whitewood.dmi'

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.75,
		ATTACK_TYPE_MELEE = 0.75,
		ATTACK_TYPE_RANGED = 0.25,
		ATTACK_TYPE_MAGIC = 0.75
	)

	dan_mode = TRUE
	dan_offset_pixel_x = list(6,0,-6,0)
	dan_offset_pixel_y = list(-2,-2,-2,-2)

	block_sound = 'sound/effects/impacts/shield_wood.ogg'

	value = 400

	rarity = RARITY_UNCOMMON