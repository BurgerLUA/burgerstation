//TODO: Convert to accent.

/language/canuck
	name = "Canuckian"
	id = LANGUAGE_CANUCK

	var/regex/regex_eh
	var/regex/regex_end
	var/regex/regex_all

	var/regex/regex_ue
	var/regex/regex_ou

	var/regex/regex_fuck

	var/list/possible_chirps = list(
		"go for a soda" = 100,
		"fuckin looser" = 100,
		"pheasants" = 100,
		"figger it out" = 100,
		"give your balls a tug you titfucker" = 25,
		"titfucker, give your balls a tug" = 25,
		"titfucker" = 25,
		"give your balls a tug" = 25,
		"three things will happen. I hit you, you hit the pavement, the ambulance hits 60" = 5,
		"your mom just liked my NanoBook post from 2 years ago in the beach gateway, tell her I'll put my swimtrunks on for her any time she likes" = 5,
		"tell your mom to top up the PDA she bought me so I can text her latenight" = 5,
		"tell your mom that I drained the bank account she setup for me; top it up so I can get some NtBurger" = 5,
		"I made your mom so wet, John Trasen deployed a 24 hour infantry unit to stack sandbags around my bed" = 5,
		"your life is so pathetic, I made 15k running a charity event to raise awareness for it" = 5,
		"your voice is an existential crisis an made me question my whole fucking life" = 5,
		"your mom groped me two shifts ago, shut the fuck up or I'll take it to NanoBook" = 5,
		"tell your mom to leave me alone, she's been laying in my fuckin waterbed since Labour day" = 5,
		"your life is so sad I get a charity tax break just for hanging out with you" = 5,
		"you should've heard your mom last night; she sounded like a window closing on a catgirl's tail. She was like: \"AAAAAAAAAAAH.\"" = 5,
		"you should've heard your mom last night; she sounded like my great aunt when I pull a suprise visit. She was like: \"OOOOOOOOOOOOOOOOOOOH.\"" = 5,
		"your mom ugly cried because she left the lens cap on the camcorder last night; it's fucking amateur hour over there" = 5
	)

/language/canuck/New()

	regex_eh = regex("\\?+")
	regex_end = regex("\[.\]$")
	regex_all = regex("all","i")

	regex_ue = regex("ue")
	regex_ou = regex("ou")

	regex_fuck = regex("fuck you","i")

	. = ..()

/language/canuck/process_text(var/speaker,var/text)

	text = periodize(text) //Always add punctuation.

	if(regex_eh.Find(text)) //Is a question.
		if(prob(80))
			text = regex_eh.Replace(text,", eh?")
		else
			text = regex_eh.Replace(text,", bud?")
	else
		if(regex_fuck.Find(text))
			regex_end.Replace(", [pickweight(possible_chirps)].")
		else if(prob(80))
			if(regex_all.Find(text))
				text = regex_end.Replace(text,", boys.")
			else
				if(prob(80))
					text = regex_end.Replace(text,", bud.")
				else
					text = regex_end.Replace(text,", my guy.")
		else
			text = regex_end.Replace(text,", okay?")

	text = regex_ue.Replace(text,"oe")
	text = regex_ou.Replace(text,"oo")

	return text

