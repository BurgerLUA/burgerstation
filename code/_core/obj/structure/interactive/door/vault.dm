/obj/structure/interactive/door/vault
	name = "secure vault door"
	desc = "If only I had a drill."
	desc_extended = "A absolute behemoth of a steel door installed with every single anti-bypass feature known to man. There is no way to get through this without the right access."
	icon = 'icons/obj/structure/airlock/vault_door.dmi'
	icon_state = "vault"
	color = "#FFFFFF"
	var/passwordA = "Echo"
	var/passwordB = "Romeo" //Err.
	var/passwordC = "Romeo"
	var/active = FALSE
	listener = TRUE
	locked = TRUE
	var/special_password
	var/list/special_passwords = list(
		"Welcome to the Sierra Madre Casino", //Leave a reference behind, wont ya?
		"Ashes to Ashes, Dust to Dust",
		"All is fair in Love and War"
	)
	var/list/passwords_normal = list( //HERE WE GOOOOO
	"Alpha",
	"Bravo",
	"Charlie",
	"Delta",
	"Echo",
	"Foxtrot",
	"Golf",
	"Hotel",
	"India",
	"Juliett",
	"Kilo",
	"Lima",
	"Mike",
	"November",
	"Oscar",
	"Papa",
	"Quebec",
	"Romeo",
	"Sierra",
	"Tango",
	"Uniform",
	"Victor",
	"Wiskey",
	"X-ray",
	"Yankee",
	"Zulu"
	)


	health = null

	allow_manual_open = FALSE

/obj/structure/interactive/door/vault/syndicate
	icon = 'icons/obj/structure/airlock/vault_door_dark.dmi'

/obj/structure/interactive/door/vault/syndicate/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	if(locked)
		active = TRUE
		src.visible_message(span("notice","The door beeps. Perhaps you should say something?"))
		CALLBACK("deactivate_\ref[src]",SECONDS_TO_DECISECONDS(10),src,.proc/deactivate)
	. = ..()

/obj/structure/interactive/door/vault/syndicate/proc/deactivate()
	active = FALSE
	src.visible_message(span("notice", "The door buzzes. I guess it didnt like what you said."))
/obj/structure/interactive/door/vault/syndicate/Finalize()
	. = ..()
	all_vault_doors += src
	pick_password()
	all_vault_doors[src] = "[passwordA],[passwordB],[passwordC]"
	if(special_password)
		all_vault_doors[src] = special_password
/obj/structure/interactive/door/vault/syndicate/proc/pick_password()
	if (prob(5))
		special_password = pick(special_passwords)
	else
		passwordA = pick(passwords_normal)
		passwordB = pick(passwords_normal)
		passwordC = pick(passwords_normal)

/obj/structure/interactive/door/vault/syndicate/on_listen(var/atom/speaker,var/datum/source,var/text,var/language_text,var/talk_type,var/frequency,var/language=LANGUAGE_BASIC,var/talk_range=TALK_RANGE)
	if(!active)
		return ..()
	if(talk_type == TEXT_RADIO)
		return ..()
	if(get_dist(source,src) > VIEW_RANGE)
		return ..()
	var/antimoth = list(
			"ø" = "o",
			"æ" = "ae",
			"å" = "a"
		)
	var/antilizard = list(
			"sss" = "s"
		)
	var/moffnoaccent = sanitize(lowertext(replace_characters(text,antimoth)))
	var/lizardnoaccent = sanitize(lowertext(replace_characters(text,antilizard)))
	var/looking_for = replace_characters("[passwordA],[passwordB],[passwordC]",list("\"" = ""))
	if(text == looking_for || moffnoaccent == looking_for || lizardnoaccent == looking_for)
		src.visible_message(span("notice","You hear a click from the door..."))
		unlock()
		open()
	else
		deactivate()
	. = ..()
