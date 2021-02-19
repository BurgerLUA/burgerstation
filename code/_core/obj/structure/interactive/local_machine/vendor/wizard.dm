/obj/structure/interactive/vending/wizard
	name = "wizard vendor"
	desc = "Authentic!"
	icon_state = "magivend"
	desc_extended = "An authentic Wizard vendor used by the Wizard Federation to equip their Wizards with Wizard federation Wizard stuff. Uses magic shard tokens as currency."

	stored_types = list(
		/obj/item/clothing/overwear/armor/knight/battlemage,
		/obj/item/clothing/head/helmet/knight/battlemage,
		/obj/item/weapon/ranged/magic/staff/basic,
		/obj/item/weapon/ranged/magic/staff/blackflame,
		/obj/item/weapon/ranged/magic/staff/chaos,
		/obj/item/weapon/ranged/magic/staff/fire,
		/obj/item/weapon/ranged/magic/tome/chaos,
		/obj/item/weapon/ranged/magic/tome/crystal,
		/obj/item/weapon/ranged/magic/tome/fireball,
		/obj/item/weapon/ranged/magic/tome/flame,
		/obj/item/weapon/ranged/magic/tome/frost,
		/obj/item/weapon/ranged/magic/tome/ice,
		/obj/item/weapon/ranged/magic/tome/lightning,
		/obj/item/weapon/ranged/magic/tome/missile,
		/obj/item/weapon/ranged/magic/tome/shock,
		/obj/item/weapon/ranged/magic/tome/summon/space_bear,
		/obj/item/supply_crate/magic,
		/obj/item/soulgem,
		/obj/item/soulgem/common,
		/obj/item/soulgem/uncommon,
		/obj/item/enchanting_chalk,
		/obj/item/paper/book/enchanting_guide,
		/obj/item/paper/book/enchanting/disarm,
		/obj/item/paper/book/enchanting/fire,
		/obj/item/paper/book/enchanting/soul_trap,
		/obj/item/paper/book/enchanting/stagger,
		/obj/item/paper/book/enchanting/stun,
		/obj/item/container/beaker/bottle/health_potion,
		/obj/item/container/beaker/bottle/stamina_potion,
		/obj/item/container/beaker/bottle/mana_potion
	)

	accepts_item = /obj/item/currency/magic_token

/obj/structure/interactive/vending/wizard/prank
	name = "magic prank vendor"
	desc = "... we swear these are pranks and not murder."
	desc_extended = "A prank vendor containing the absolutely worst pranks and toys of the galaxy."
	icon_state = "games"

	stored_types = list(
		/obj/item/container/beaker/can/dr_gibb/explosive,
		/obj/item/clothing/back/storage/satchel/bluespace/prank,
		/obj/item/container/medicine/bandage/prank,
		/obj/item/container/spray/ketchup,
		/obj/item/container/spray/mustard,
		/obj/item/firing_pin/electronic/iff/nanotrasen/nyantrasen,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube,
		/obj/item/announcement/wizard,
		/obj/item/bikehorn/magic,
		/obj/item/broom/magic
	)