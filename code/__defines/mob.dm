#define SIZE_CRITTER SIZE_3
#define SIZE_ANIMAL SIZE_5
#define SIZE_HUMAN SIZE_7
#define SIZE_GIANT SIZE_8
#define SIZE_BOSS SIZE_9
#define SIZE_GOD SIZE_10


#define BLOOD_VOLUME_DEFAULT 510



#define PROCESS_LIVING(x) if(!x.processing) SSliving.processing_mobs |= x; x.processing = TRUE
#define UNPROCESS_LIVING(x) if(x.processing) SSliving.processing_mobs -= x; x.processing = FALSE