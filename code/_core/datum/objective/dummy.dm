/objective/dummy
	name = "Dummy Objective"
	var/completed = FALSE
	credit_reward = 100
	burgerbux_reward = 1

/objective/dummy/get_description()
	return "Do nothing."

/objective/dummy/check_completion()

	if(completed)
		return COMPLETED

	return ..()