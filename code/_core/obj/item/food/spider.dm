/obj/item/consumable/food/spider/
	name = "spider foods"
	icon = 'icons/obj/items/consumable/food/spider.dmi'

	heal_amount_health = 0
	heal_amount_stamina = 0
	heal_amount_mana = 0
	uses_left = 4

	consume_verb = "eat"

/obj/item/consumable/food/spider/spider_leg
	name = "raw spider leg"
	icon_state = "spiderleg"

	heal_amount_health = -25
	heal_amount_stamina = 50
	heal_amount_mana = -25

/obj/item/consumable/food/spider/spider_leg/cooked
	name = "boiled spider leg"
	icon_state = "spiderlegcooked"

	heal_amount_health = 20
	heal_amount_stamina = 30
	heal_amount_mana = 0


/obj/item/consumable/food/spider/spider_eggs
	name = "raw spider eggs"
	icon_state = "spidereggs"

	heal_amount_health = -25
	heal_amount_stamina = -25
	heal_amount_mana = 50

/obj/item/consumable/food/spider/spider_eggs/cooked
	name = "green eggs and ham"
	icon_state = "spidereggsham"

	heal_amount_health = 20
	heal_amount_stamina = 0
	heal_amount_mana = 30