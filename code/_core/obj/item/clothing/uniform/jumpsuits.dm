/obj/item/clothing/uniform/jumpsuit
	name = "jumpsuit"
	desc = "A nice jumpsuit."
	desc_extended = "When you really can't be bothered to get matching pants."

	icon = 'icons/obj/items/clothing/uniforms/poly_suit_new.dmi'

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	item_slot = SLOT_TORSO

	polymorphic = TRUE

	no_initial_blend = TRUE

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E,
		MAGIC = ARMOR_D,
		COLD = ARMOR_D,
	)

	"primary" = "#FFFFFF"
	"secondary" = "#FFFFFF"
	"tertiary" = "#FFFFFF"

	"primary"_desc = "shirt"
	"secondary"_desc = "pants"
	"tertiary"_desc = "shoulders"

	value = 10

/obj/item/clothing/uniform/jumpsuit/random/on_spawn()
	"primary" = random_color()
	"secondary" = random_color()
	"tertiary" = random_color()
	return ..()

/obj/item/clothing/uniform/jumpsuit/grey
	"primary" = "#A0A0A0"
	"secondary" = "#A0A0A0"
	"tertiary" = "#A0A0A0"

/obj/item/clothing/uniform/jumpsuit/red
	"primary" = COLOR_RED
	"secondary" = COLOR_RED
	"tertiary" = COLOR_RED

/obj/item/clothing/uniform/jumpsuit/blue
	"primary" = COLOR_BLUE
	"secondary" = COLOR_BLUE
	"tertiary" = COLOR_BLUE

/obj/item/clothing/uniform/jumpsuit/science
	"primary" = COLOR_WHITE
	"secondary" = COLOR_WHITE
	"tertiary" = COLOR_SCIENCE

/obj/item/clothing/uniform/jumpsuit/dark
	name = "reinforced jumpsuit"

	"primary" = COLOR_BLACK
	"secondary" = COLOR_BLACK
	"tertiary" = COLOR_BLACK

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_E,
		COLD = ARMOR_C,
	)

	value = 30

/obj/item/clothing/uniform/jumpsuit/dark/security
	"primary" = "#ADBEDA"
	"secondary" = "#586B8B"
	"tertiary" = "#ADBEDA"

/obj/item/clothing/uniform/jumpsuit/chemist
	"primary" = COLOR_WHITE
	"secondary" = COLOR_WHITE
	"tertiary" = COLOR_CHEMISTRY


/obj/item/clothing/uniform/jumpsuit/bartender
	"primary" = COLOR_WHITE
	"secondary" = COLOR_BLACK
	"tertiary" = COLOR_WHITE

/obj/item/clothing/uniform/jumpsuit/medical_doctor
	"primary" = COLOR_WHITE
	"secondary" = COLOR_WHITE
	"tertiary" = COLOR_MEDICAL

/obj/item/clothing/uniform/jumpsuit/engineering
	"primary" = COLOR_ENGINEERING_BRIGHT
	"secondary" = COLOR_ENGINEERING
	"tertiary" = COLOR_ORANGE