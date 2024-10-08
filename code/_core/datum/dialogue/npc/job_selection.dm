/dialogue/npc/job_selection/

/dialogue/npc/job_selection/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["*hello"] = list(
		"Greetings, [P.name]. Welcome to the Automatic Job Selection Program (AJSP). Please select an option on the right to get started.",
		"*about jobs",
		"*select a job"
	)

	.["*about jobs"] = list(
		"Jobs are a way to specify your desired line of work to NanoTrasen's database so you may be appropriately assigned and compensated for your efforts. \
		Jobs also unlock unique abilities taught you via your loyalty implant that can help you perform better at said job than those without it. \
		By default, all hires are considered Mercenaries and do not earn any passive income."
	)



