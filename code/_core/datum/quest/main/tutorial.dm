//1 --Get your clothes.
//10 --Get your weapon
//20 --Find out what's making all the commotion
//30 --Defeat the cultists

/quest/main/tutorial
	name = "New Beginnings"
	objectives = list(
		"clothes" = "Retrieve your clothes from the wardrobe.",
		"weapon" = "Retrieve your weapon from the chest.",
		"call" = "Investigate the noise disturbance.",
		"cult" = "Defeat the cultists."
	)

/quest/main/tutorial/on_stage_changed(var/previous_stage)
	switch(stage)
		if(1)
			set_objective_displayed("clothes")
		if(10)
			set_objective_displayed("weapon")
		if(20)
			set_objective_displayed("call")
		if(30)
			set_objective_displayed("cult")