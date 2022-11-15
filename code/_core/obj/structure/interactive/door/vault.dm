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
	var/special_password // If present, overrides open code

	var/list/special_passwords = list( //Leave a reference behind, wont ya?
		//These should all be some special phrase from a movie, game, whatever. Have a 5% chance of replacing normal password.
		"Welcome to the Sierra Madre Casino.",
		"Ashes to Ashes, Dust to Dust.",
		"All is fair in Love and War.",
		"I have the water chip.",
		"Gary.",
		"I dont want to set the world on fire.",
		"Bingo,Bango,Bongo.",
		"War. War never changes.",
		"Its the end of the world, all over again.",
		"Death is a preferable alternative to Communism.",
		"What a contradiction a human is.",
		"What in the goddamn?",
		"I have your chip.",
		"Finding it isnt the hard part. Its letting go.",
		"We cant expect god to do all the work.",
		"Who are you, who do not know your history?",
		"Truth is, the game was rigged from the start.",
		"Only currency I have is knowledge.",
		"No need to destroy it, simply cut its throat.",
		"Has your life taken a turn?",
		"Do troubles beset you?",
		"Has fortune left you behind?",
		"Begin again.",
		"Let go of the world behind.",
		"I hope youll return, in happier times.",
		"Open sesame!",
		"I have them Old World Blues.",
		"plz open. thx.",
		"Welcome to the rice fields.",
		"All your loot are belong to us."
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
	all_vault_doors[src] = "[passwordA],[passwordB],[passwordC]."
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
	var/looking_for = replace_characters("[passwordA],[passwordB],[passwordC].",list("\"" = ""))
	if(text == looking_for || moffnoaccent == looking_for || lizardnoaccent == looking_for)
		src.visible_message(span("notice","You hear a click from the door..."))
		unlock()
		open()
	else
		deactivate()
	. = ..()
