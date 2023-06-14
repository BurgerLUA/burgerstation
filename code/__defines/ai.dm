#define ALERT_LEVEL_NONE 0 //No threats detected.
#define ALERT_LEVEL_NOISE 1 //We heard or saw something strange that requires further investigation. Probably not a hostile, though.
#define ALERT_LEVEL_CAUTION 2 //We heard or saw something strange that is more than likely a hostile.
#define ALERT_LEVEL_COMBAT 3 //We are currently searching for hostiles or are engaged with them.




#define QUEUE_CHUNK_AI_UPDATE(chunk) SSai.queued_ai_update_chunks[chunk] = TRUE
