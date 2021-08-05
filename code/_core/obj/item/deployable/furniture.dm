//All items in this file can be placed down. For most, if not all intents and purposes, they are for flavor.
//Thanks given to Deployable code.

/obj/item/deployable/furniture/chair //put here to prevent confusion
	name = "chair"
	desc = "Revolutionary technology."
	desc_extended = "A comfortable chair to sit down on."
	structure_to_deploy = /obj/structure/interactive/chair/furniture
	icon = 'icons/obj/structure/chairs.dmi'
	icon_state = "chair"

	item_count_max = 1

/obj/item/deployable/furniture/table //ditto
	name = "table"
	desc = "Keep the cold ones off the floor."
	desc_extended = "A table to put items on. Alternatively, use as a make-shift barricade."
	structure_to_deploy = /obj/structure/smooth/table/furniture
	icon = 'icons/obj/structure/smooth/table/normal.dmi'
	icon_state = "table"

	item_count_max = 1

/obj/item/deployable/furniture/bed
	name = "bed"
	desc = "This could be a mistake."
	desc_extended = "A bed for sleeping on. Sleep on the bed. You sleep on this bed. You SLEEP ON THE BED."
	structure_to_deploy = /obj/structure/interactive/bed/furniture
	icon = 'icons/obj/structure/bed.dmi'
	icon_state = "bed"

	item_count_max = 1