/obj/item/weapon/melee/sword/
	value = 10

/obj/item/weapon/melee/sword/sabre

	name = "sabre"
	desc = "A curved sword. Curved. Sword."
	desc_extended = "A cavalry sabre that was often used as a weapon by non-commissioned officers of the Sol Army before being replaced by energy swords, nowadays it's used as a dress decoration more than anything."

	icon = 'icons/obj/item/weapons/melee/swords/sabre.dmi'

	icon_state_worn = "worn"

	damage_type = /damagetype/melee/sword/sabre

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK

	slot_icons = TRUE

	attack_delay = 5
	attack_delay_max = 12

	size = SIZE_3

	value = 40

/obj/item/weapon/melee/sword/sabre/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/weapon/melee/sword/claymore
	name = "steel claymore sword"
	desc = "Looking at this really makes you want to go on a crusade."
	desc_extended = "A very basic claymore sword known for its use by knights in Medieval Europe. It is one of the most common weapons in The Realm, as it is a un-cursed version of the unholy cult blade."

	icon = 'icons/obj/item/weapons/melee/swords/claymore.dmi'
	icon_state_worn = "worn"

	item_slot = SLOT_GROIN_O | SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	damage_type = /damagetype/melee/sword/claymore

	attack_delay = 8

	size = SIZE_3

	value = 30

/obj/item/weapon/melee/sword/claymore/cult
	name = "cultist sword"
	icon = 'icons/obj/item/weapons/melee/swords/cult.dmi'
	desc = "Looking at this really makes you want to go on an EVIL crusade."
	desc_extended = "A very basic claymore sword known for its use by knights in Medieval Europe, now cursed with Nar'sie's magic."

	damage_type = /damagetype/melee/sword/claymore/cult

	size = SIZE_3

	value = 50


/obj/item/weapon/melee/sword/claymore/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/weapon/melee/spear
	name = "steel spear"
	desc = "Unga bunga."
	desc_extended = "Commonly used by the local Ashwalkers for hunting and settlement defense. Can be thrown for heavy damage."
	icon = 'icons/obj/item/weapons/melee/swords/spear.dmi'
	damage_type = /damagetype/melee/spear/spear/
	damage_type_thrown = /damagetype/melee/spear/spear/thrown

	attack_delay = 5
	attack_delay_max = 12

	size = SIZE_4

	value = 10

/obj/item/weapon/melee/zweihander
	name = "zweihander"
	rarity = RARITY_MYTHICAL
	desc = "THE LEGEND."
	desc_extended = "A steel sword that makes up for it's simplicity by being heavy and huge, the Zweihander is a fearsome sight only used by PMCs with no self-regard whatsoever."
	icon = 'icons/obj/item/weapons/melee/swords/zweihander.dmi'
	damage_type = /damagetype/melee/sword/zweihander

	attack_delay = 10
	attack_delay_max = 30

	size = SIZE_5

	value = 120

/obj/item/weapon/melee/sword/curvedsword
	name = "steel curved sword"
	desc = "A curved blade. Poor at trusting, excells at slashing quickly."
	desc_extended = "A standard curved sword. Capable of fast swings, and when maintained it can be exceptionally sharp."

	icon = 'icons/obj/item/weapons/melee/swords/curvedsword.dmi'

	dan_mode = TRUE

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	damage_type = /damagetype/melee/sword/curvedsword

	attack_delay = 7
	attack_delay_max = 14

	size = SIZE_3

	value = 900

/obj/item/weapon/melee/sword/skana
	name = "skana"
	desc = "A metal katana that's been space-ified."
	desc_extended = "A straight katana-like sword, with a curved starting near the end. Incredibly sharp."

	icon = 'icons/obj/item/weapons/melee/swords/skana.dmi'

	dan_mode = TRUE

	item_slot = SLOT_GROIN_O

	damage_type = /damagetype/melee/sword/skana

	attack_delay = 8

	size = SIZE_3

	value = 200

/obj/item/weapon/melee/sword/gladius
	name = "gladius"
	desc = "A steel bladed gladius."
	desc_extended = "A light gladius with a bronze hilt and steel blade."

	icon = 'icons/obj/item/weapons/melee/swords/gladius.dmi'

	dan_mode = TRUE

	item_slot = SLOT_GROIN_O

	damage_type = /damagetype/melee/sword/gladius

	attack_delay = 6

	size = SIZE_2

	value = 200

/obj/item/weapon/melee/sword/allium
	name = "allium"
	desc = "An allium made of copper."
	desc_extended = "A light copper allium, better for thrusting than a gladius."

	icon = 'icons/obj/item/weapons/melee/swords/allium.dmi'

	dan_mode = TRUE

	item_slot = SLOT_GROIN_O

	damage_type = /damagetype/melee/sword/allium

	attack_delay = 7

	size = SIZE_2

	value = 200