/obj/item/shell
	name = "sea shell"
	desc = "Where do you see the sea shell on the sea shore?"
	desc_extended = "A beautiful colored shell. Not much use, other than selling it."

	icon = 'icons/obj/item/shell.dmi'
	icon_state = "shell1"

	value = 50

/obj/item/shell/Generate()
	. = ..()
	icon_state = "shell[rand(1,3)]"
	color = random_color()