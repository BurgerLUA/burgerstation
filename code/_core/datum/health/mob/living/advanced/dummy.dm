/health/mob/living/advanced/dummy
	organic = FALSE


/health/mob/living/advanced/dummy/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/organic=TRUE,var/robotic=TRUE,var/update=TRUE)
	return brute + burn + tox + oxy + fatigue + pain + rad + sanity + mental // + L + plundered + no wenches + marooned + you have scurvy
