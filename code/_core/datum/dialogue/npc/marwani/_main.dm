/dialogue/npc/marwani/
	name = "Ilaeza Marwani"
	id = "marwani_dialogue"

/dialogue/npc/marwani/get_dialogue_options(var/mob/living/advanced/player/P)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Hello, is there something you wish to discuss? If not, you should go see #1.",
		"the mayor",
		"goodbye"
	)

	dialogue_options["the mayor"] = list(
		"He should be here somewhere... have you tried checking #1? It is the big building, just southwest of here.",
		"bar"
	)
	dialogue_options["the bar"] = list(
		"Just because we've been cursed with #1 doesn't mean we can't have fun. It's a great place to go an socialize, assuming if there is any alcohol.",
		"immortality"
	)
	dialogue_options["immortality"] = list(
		"Yes, everyone and anything with a soul in this #1 is immortal. When you succumb to #2, you travel to the last #3 used. Microorganisms don't seem to have a soul so disease does not exist here, and you can still be 'mortally' wounded.",
		"realm",
		"death",
		"wishgranter"
	)

	dialogue_options["realm"] = list(
		"An odd place, isn't it? According to #1, it wasn't always like this. I'm not one for stories, but if you ever do find him, I'm sure he'll tell you all about it.",
		"the mayor"
	)

	dialogue_options["death"] = list(
		"Well you aren't TECHNICALLY immortal. When you die, you're given a new body here. All your #1, #2, and #3 stay behind with your old #4.",
		"wounds",
		"weapons",
		"armor",
		"corpse"
	)

	dialogue_options["wounds"] = list(
		"You can still get wounds here, yes. If you have one, be sure to treat it as soon as possible, or you might get an infection."
	)

	dialogue_options["weapons"] = list(
		"If you're looking for weapons, you'll have to buy them with #1 like everyone else from #2. He's the weaponsmith.",
		"currency",
		"Bundy Bundus"
	)

	dialogue_options["armor"] = list(
		"Good armor is incredibly rare here as it usually requires a lot of materials to make. I think #1 can provide you with something basic, if you have the #2.",
		"Bundy Bundus",
		"currency"
	)

	dialogue_options["currency"] = list(
		"We don't use credits or gold for goods around here. We usually trade for goods or items of equal value or use. Merchants usually like trading #1 or #2 for goods.",
		"food",
		"trinkets"
	)

	dialogue_options["food"] = list(
		"No one ever goes hungry in this #1. I, personally, haven't eaten for several months now, however that doesn't mean that people can't experience pleasure from eating. Given how numb our existence is, good food can go a long way!",
		"realm"
	)
	dialogue_options["trinkets"] = list(
		"A lot of the citzens here long for objects of interest like toys or puzzles that we took for granted in our previous life. It gets really boring here sometimes if you're not an adventurer.",
	)
	dialogue_options["Bundy Bundus"] = list(
		"He's uh... a strange one. He tends to the #1 in the north, or whatever is left of it. Also sells #2.",
		"old farm",
		"weapons"
	)
	dialogue_options["old farm"] = list(
		"Well, it's not really a farm. It used to be in the beginning, but so many people started #1 any harvests before they could be properly be distributed. Eventually, people started stealing the seeds themselves, so now all you have is just a land of dirt.",
		"stealing"
	)
	dialogue_options["stealing"] = list(
		"People steal all the time here. Some even resort to #1 people for items just to risk #1. Not many people have any furniture or items because of it.",
		"killing",
		"the wraith of Nar-sie"
	)
	dialogue_options["killing"] = list(
		"People usually kill outside the walls here. Inside the walls, that #1 feeling you get prevents that chaos from happening. Most of the villagers here say it's because of the #2, #3 says it's because of something else.",
		"pacifism",
		"wishgranter",
		"the mayor"
	)
	dialogue_options["pacifism"] = list(
		"Everyone feels it here. I wouldn't really call it pacifism, personally, more like laziness. People still get angry, they curse and swear and insult as much as they want, but no one really feels like hitting anyone over it. This even extends to trivial things like tearing down houses or nailing down furniture."
	)

	dialogue_options["the wraith of Nar-sie"] = list(
		"I hear if you wrong someone you'll invoke the wraith of Nar-sie or something. Plenty of people here have wronged others here before, but nothing has happened to them. And besides, I don't think Nar-sie is the type of person who cares about morality. I think #1 knows more about the subject than I do."
	)

	dialogue_options["wishgranter"] = list(
		"Oh, yes. This strange glowing thing is the wishgranter. Resurrected souls come through here quite a bit; old and new. My role is to help all the new ones like I did with you, so I usually stay around here."
	)

	return dialogue_options

