#define SHUTTLE_DEFAULT_TRANSIT_TIME 30 //In seconds.
#define SHUTTLE_DEFAULT_TRANSIT_TIME_NO_LIVING 15
#define SHUTTLE_DEFAULT_WAITING_TIME 30
#define SHUTTLE_DEFAULT_IDLE_TIME 10

#define SHUTTLE_STATE_NONE "none"
#define SHUTTLE_STATE_LAUNCHING "launching" //We're going to launch.
#define SHUTTLE_STATE_TRANSIT "transit" //We're currently in transit.
#define SHUTTLE_STATE_LANDING "landing" //We're currently landing.
#define SHUTTLE_STATE_LANDED "landed" //We have landed.
#define SHUTTLE_STATE_WAITING "waiting" //We have enough people to launch, now we wait just for more, just in case.