/health/mob/living/advanced/dummy
	organic = FALSE


/health/mob/living/advanced/dummy/adjust_loss_smart(brute,burn,tox,oxy,fatigue,pain,rad,sanity,mental,organic=TRUE,robotic=TRUE,update=TRUE)
	return brute + burn + tox + oxy + fatigue + pain + rad + sanity + mental // + L + plundered + no wenches + marooned + you have scurvy
