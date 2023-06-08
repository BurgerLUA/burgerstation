/mob/living/advanced/player/proc/set_job(var/job/desired_job) //Setjob is only called when the player takes a new job.

	if(!desired_job)
		job = null
		job_rank = 1
		return TRUE

	if(desired_job == job)
		return FALSE

	var/job/J = JOB(desired_job)
	if(!J)
		return FALSE

	job = desired_job
	job_rank = 1
	job_next_promotion = world.realtime + 604800*10 //1 week

	src.to_chat(span("notice","You are now \a [J.name]."))

	return TRUE

/mob/living/advanced/player/proc/check_promotion()

	if(!job)
		return FALSE

	var/job/J = JOB(job)
	if(!J)
		return FALSE

	if(!job_next_promotion)
		return FALSE

	if(world.realtime < job_next_promotion)
		return FALSE

	var/rank_length = length(J.ranks)
	if(job_rank >= rank_length)
		return FALSE

	job_rank++

	src.to_chat(span("notice","You have been promoted from [J.get_rank_title(job_rank-1)] to [J.get_rank_title(job_rank)]! Your skills, attributes, and paycheck have been increased!"))

	return TRUE