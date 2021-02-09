/ai/clown/hulk
	jokes = list(
		"Are you a magician? Because whenever I look at you, everyone else disappears. BECAUSE EVERYONE ELSE IS DEAD.",
		"I’m not a photographer, but I can picture me and you together. RIPPING YOU APART.",
		"They say Disneyland is the happiest place on earth. Well apparently, no one has ever been standing next to you RIPPING OUT YOUR ENTRAILS.",
		"For some reason, I was feeling a little off today. But when you came along, you definitely turned me on IN THE MOOD FOR MURDER.",
		"I seem to have lost my phone number. Can I have yours SO I CAN NOTIFY YOUR NEXT OF KIN.",
		"I’m lost. Can you give me directions to your heart SO I CAN RIP IT OUT.",
		"Hi, how was heaven when you left it BECAUSE YOU'RE GOING BACK TO IT."
	)


/ai/clown/tree
	jokes = list(
		"Why do trees hate riddles? BECAUSE IT'S EASY TO GET STUMPED.",
		"Why did the tree get stumped? BECAUSE IT COULDN'T GET TO THE ROOT OF THE PROBLEM.",
		"What's a tree's favorite drink? ROOTBEER.",
		"What did the tree do when the bank closed? IT OPENED ITS OWN BRANCH.",
		"What happens to trees on Valentine's Day? THEY GET SAPPY.",
		"How does a tree get on the internet? THEY LOG ON."
	)

/ai/clown/long
	jokes = list(
		"What did the tooth say to the departing dentist? FILL ME WHEN YOU GET BACK IN.",
		"What did the dentist say to the computer? THIS WON'T HURT A BYTE.",
		"What did the dentist see at the North Pole? A MOLAR BEAR!",
		"What does a dentist do on a roller coaster? HE BRACES HIMSELF.",
		"Why didn’t the dentist ask his secretary out? HE WAS ALREADY TAKING OUT A TOOTH.",
		"What does the dentist of the year get? A LITTLE PLAQUE."
	)

/ai/clown/pie
	jokes = list(
		"what's the best thing to put in a pie? YOUR TEETH!",
		"Why did the pie go to the dentist? BECAUSE HE NEEDED A FILLING.",
		"Why did the pie cross the road? SHE WAS MEAT AN POTATO.",
		"Why do you call a protesting pie on Wall Street? OCCU-PIE!",
		"What's the difference between pussy and apple pie? YOU CAN EAT YOUR MOM'S APPLE PIE."
	)

/ai/clown/lube
	jokes = list(
		"What's a foot longa and slippery? A SLIPPER.",
		"What's pink and slippery? TWO ADJECTIVES.",
		"What do you call a slippery book? NON-FRICTION.",
		"What do you call a water slide with cocaine at the end? A SLIPPER SLOPE.",
		"What do you call the period of time between slipping on a banana and landing on your ass? A BANANOSECOND."
	)

/ai/clown/mutant/
	jokes = list()

/ai/clown/mutant/New(var/desired_loc,var/mob/desired_owner)

	. = ..()

	var/list/objects = list(
		"apple",
		"banana",
		"cabbage",
		"potato",
		"pie",
		"car dealer",
		"soap",
		"triangle",
		"mercenary",
		"traitor",
		"antagonist"
	)

	for(var/i=1,i<=10,i++)
		if(length(objects) < 2)
			break
		var/object_one = pick(objects)
		objects -= object_one
		var/object_two = pick(objects)
		objects -= object_two
		jokes += "What did the [object_one] say to the [object_two]? JOIN US."

	return .

/ai/clown/blob/
	jokes = list(
		"What did the man say to the female? FEMALES SUCK.",
		"What did the beta cuck say to his soy boyfriend? I'M A FEMINIST.",
		"What did the chad video game character say to the lesbian? I'M BETTER THAN YOU.",
		"What did the female video game protagonist do when she saw a man? SHE DID BAD."
	)
