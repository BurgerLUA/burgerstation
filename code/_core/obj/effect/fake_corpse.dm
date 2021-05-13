/obj/effect/fake_corpse
	name = "corpse"
	desc = "Here lies x. They never scored."
	desc_extended = "The body of someone."
	appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM | LONG_GLIDE | KEEP_TOGETHER

	anchored = TRUE

/obj/effect/fake_corpse/proc/copy_body(var/mob/living/L)

	appearance = L.appearance

	name = L.name
	desc = "Here lies [L.name]. They never scored."

	var/matrix/M = get_base_transform()
	M.Turn(90)
	transform = M

	return TRUE