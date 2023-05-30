/obj/structure/interactive/vending/wizard
	name = "wizard vendor"
	desc = "Authentic!"
	icon_state = "MagiVend"
	desc_extended = "An authentic Wizard vendor used by the Wizard Federation to equip their Wizards with Wizard federation Wizard stuff. Uses magic shard tokens as currency."

	stored_types = list(
		/obj/item/clothing/overwear/armor/knight/battlemage,
		/obj/item/clothing/head/helmet/full/knight/battlemage,
		/obj/item/supply_crate/magic,
		/obj/item/soulgem/uncommon,
		/obj/item/container/simple/beaker/bottle/health_potion,
		/obj/item/container/simple/beaker/bottle/stamina_potion,
		/obj/item/container/simple/beaker/bottle/mana_potion,
		/obj/item/weapon/ranged/spellgem/chaos,
		/obj/item/weapon/ranged/spellgem/crystal,
		/obj/item/weapon/ranged/spellgem/f50cal,
		/obj/item/weapon/ranged/spellgem/fireball,
		/obj/item/weapon/ranged/spellgem/oozey,
		/obj/item/weapon/ranged/spellgem/tesla,
		/obj/item/weapon/ranged/wand/quartz,
		/obj/item/weapon/melee/torch/lantern,
		/obj/item/weapon/ranged/magic/spellblade/runesword,
		/obj/item/weapon/melee/shield/heartstone,
		/obj/item/soulgem/uncommon/filled,
		/obj/item/soulgem/rare,
		/obj/item/soulgem/mystic,

	)

	accepts_item = /obj/item/currency/magic_token
	health = null

/obj/structure/interactive/vending/wizard/prank
	name = "magic prank vendor"
	desc = "... we swear these are pranks and not murder."
	desc_extended = "A prank vendor containing the absolutely worst pranks and toys of the galaxy."
	icon_state = "games"

	stored_types = list(
		/obj/item/container/simple/can/dr_gibb/explosive,
		/obj/item/clothing/back/storage/satchel/bluespace/prank,
		/obj/item/container/healing/bandage/prank,
		/obj/item/container/spray/ketchup,
		/obj/item/container/spray/mustard,
		/obj/item/firing_pin/electronic/iff/nanotrasen/nyantrasen,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube,
		/obj/item/announcement/wizard,
		/obj/item/bikehorn/magic,
		/obj/item/broom/magic
	)