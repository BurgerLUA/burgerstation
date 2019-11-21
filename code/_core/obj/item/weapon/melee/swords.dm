/obj/item/weapon/melee/sword/sabre

	name = "sabre"
	desc = "A curved sword. Curved. Sword."

	icon = 'icons/obj/items/weapons/melee/swords/sabre.dmi'

	icon_state_worn = "worn"

	damage_type = "sword_sabre"

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK

	slot_icons = TRUE

	attack_delay = 5
	attack_delay_max = 12

/obj/item/weapon/melee/sword/sabre/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/weapon/melee/sword/claymore
	name = "steel claymore sword"
	desc = "Looking at this really makes you want to go on a crusade."
	desc_extended = "A very basic claymore sword known for its use by knights in Medieval Europe. It is one of the most common weapons in The Realm, as it is a un-cursed version of the unholy cult blade."

	icon = 'icons/obj/items/weapons/melee/swords/claymore.dmi'
	icon_state_worn = "worn"

	item_slot = SLOT_GROIN_O | SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	damage_type = "sword_claymore"

	attack_delay = 8

/obj/item/weapon/melee/sword/claymore/cult
	name = "cultist sword"
	icon = 'icons/obj/items/weapons/melee/swords/cult.dmi'
	desc = "Looking at this really makes you want to go on an EVIL crusade."
	desc_extended = "A very basic claymore sword known for its use by knights in Medieval Europe, now cursed with Nar'sie's magic."

	damage_type = "sword_claymore_cult"


/obj/item/weapon/melee/sword/claymore/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/weapon/melee/spear
	name = "steel spear"
	desc = "Unga bunga."
	desc_extended = "Commonly used by the local Ashwalkers for hunting and settlement defense. Can be thrown for heavy damage."
	icon = 'icons/obj/items/weapons/melee/swords/spear.dmi'
	damage_type = "spear"
	damage_type_thrown = "spear_thrown"

	attack_delay = 5
	attack_delay_max = 12

/obj/item/weapon/melee/zweihander
	name = "chaos zweihander"
	rarity = RARITY_LEGENDARY
	desc = "THE LEGEND."
	icon = 'icons/obj/items/weapons/melee/swords/zweihander.dmi'
	damage_type = "sword_chaos_zweihander"

	attack_delay = 10
	attack_delay_max = 30