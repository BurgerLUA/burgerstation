/obj/item/container/food/burger
	name = "burger"
	desc = "Makes you think."
	desc_extended = "A basic meal, but it's cheap and easy to make, so expect this to be all you eat here."

	icon = 'icons/obj/items/consumable/food/burgers.dmi'
	icon_state = "burger"

	consume_verb = "eat"

/obj/item/container/food/burger/ham
	name = "hamburger"
	icon_state = "burger"

/obj/item/container/food/burger/ham/on_spawn()
	reagents.add_reagent("bicaridine",50)
	return ..()

/*


/obj/item/container/food/burger/ham/double
	name = "bite bite burger"
	icon_state = "bigbiteburger"
	uses_left = 8

/obj/item/container/food/burger/ham/quad
	name = "super big bite burger"
	icon_state = "superbiteburger"
	uses_left = 16

/obj/item/container/food/burger/bacon
	name = "bacon hamburger"
	icon_state = "baconburger"

/obj/item/container/food/burger/tofu
	name = "tofuburger"
	icon_state = "tofuburger"


/obj/item/container/food/burger/brain
	name = "brainburger"
	icon_state = "brainburger"

	heal_amount_health = 20
	heal_amount_stamina = 20
	heal_amount_mana = 100

/obj/item/container/food/burger/xeno
	name = "xenoburger"
	icon_state = "xburger"

	heal_amount_health = 100
	heal_amount_stamina = -100
	heal_amount_mana = -100

/obj/item/container/food/burger/jelly
	name = "jellyburger"
	icon_state = "jellyburger"

	heal_amount_health = 100
	heal_amount_stamina = 10
	heal_amount_mana = 0

/obj/item/container/food/burger/roburger
	name = "roborger"
	icon_state = "roburger"

	heal_amount_health = 0
	heal_amount_stamina = 100
	heal_amount_mana = 0

/obj/item/container/food/burger/spellburger
	name = "spellburger"
	icon_state = "spellburger"

	heal_amount_health = 0
	heal_amount_stamina = 10
	heal_amount_mana = 1000

/obj/item/container/food/burger/appendix
	name = "appendix burger"
	icon_state = "appendixburger"

	heal_amount_health = 50
	heal_amount_stamina = 10
	heal_amount_mana = 0


/obj/item/container/food/burger/fish
	name = "fish burger"
	icon_state = "fishburger"

	heal_amount_health = 50
	heal_amount_stamina = 20
	heal_amount_mana = 0

/obj/item/container/food/burger/fish/crab
	name = "crab burger"

/obj/item/container/food/burger/clown
	name = "clown burger"
	icon_state = "clownburger"

	heal_amount_health = 0
	heal_amount_stamina = 0
	heal_amount_mana = 0

/obj/item/container/food/burger/clown/New(var/desired_loc)
	..()
	heal_amount_health = rand(-10,10) * 10
	heal_amount_stamina = rand(-10,10) * 10
	heal_amount_mana = rand(-10,10) * 10

/obj/item/container/food/burger/mime
	name = "mime burger"
	icon_state = "mimeburger"

	heal_amount_health = 20
	heal_amount_stamina = 100
	heal_amount_mana = 20

/obj/item/container/food/burger/colored
	name = "colored burger"
	icon_state = "cburger"

	color = "#FFFFFF"

	heal_amount_health = 0
	heal_amount_stamina = 0
	heal_amount_mana = 0

/obj/item/container/food/burger/colored/New(var/desired_loc)
	..()
	heal_amount_health = GetRedPart(color)/2.55
	heal_amount_stamina = GetGreenPart(color)/2.55
	heal_amount_mana = GetBluePart(color)/2.55
	var/total_mod = 100/(heal_amount_health + heal_amount_stamina + heal_amount_mana)

	heal_amount_health *= total_mod
	heal_amount_stamina *= total_mod
	heal_amount_mana *= total_mod

/obj/item/container/food/burger/bear
	name = "bearger"
	icon_state = "bearger"

	heal_amount_health = 100
	heal_amount_stamina = 100
	heal_amount_mana = 0

/obj/item/container/food/burger/fivealarm
	name = "five alarm burger"
	icon_state = "fivealarmburger"

	heal_amount_health = 0
	heal_amount_stamina = 1000
	heal_amount_mana = 0

/obj/item/container/food/burger/ratburger
	name = "ratburger"
	icon_state = "ratburger"

	heal_amount_health = 50
	heal_amount_stamina = -25
	heal_amount_mana = -25

/obj/item/container/food/burger/baseballburger
	name = "baseball burger"
	icon_state = "baseball"

	heal_amount_health = 25
	heal_amount_stamina = 10
	heal_amount_mana = 0
*/