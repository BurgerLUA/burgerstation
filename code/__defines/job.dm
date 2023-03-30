#define FLAG_JOB_NONE (1<<0)

#define FLAG_JOB_HEALING (1<<1) //Gain money by healing other players.

#define FLAG_JOB_KILLING (1<<2) //Gain money by killing other enemies.

#define FLAG_JOB_CLEANING (1<<3) //Gain money by cleaning messes.


#define HAS_JOB_FLAG(player,job_flag) (SSjob.all_jobs[player.job]?.job_flags & job_flag)