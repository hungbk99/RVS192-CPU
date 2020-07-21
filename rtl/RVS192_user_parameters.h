//////////////////////////////////////////////////////////////////////////////////
// File Name: 		RVS192_user_parameters.h
// Module Name:		Parameter configuration 		
// Project Name:	RVS192
// Author:	 		hungbk99
// University:     	DP S192	HCMUT
//////////////////////////////////////////////////////////////////////////////////
	parameter	ICACHE_SIZE = 32,
 	parameter 	ICACHE_BLOCK_SIZE = 64,
	parameter	ICACHE_WAY = 4,
	parameter	DCACHE_SIZE = 32,
	parameter	DCACHE_BLOCK_SIZE = 64,
	parameter	DCACHE_WAY = 8,
	parameter 	DCACHE_WB_DEPTH = 10,
	parameter	L2_CACHE_SIZE = 256,
	parameter	L2_CACHE_BLOCK_SIZE = 64,
	parameter 	L2_CACHE_WAY = 16,
	parameter 	L2_CACHE_WB_DEPTH = 20,
	parameter	GSHARE_HISTORY_LENGTH = 12,
	parameter 	LOCAL_HISTORY_LENGTH = 10,
	parameter	GSHARE_GPT_INDEX = 10,
	parameter 	LOCAL_LPT_INDEX = 10,
	parameter 	LOCAL_LHT_INDEX = 12,
	parameter 	BTB_INDEX = 8,
	parameter 	BTB_TAG_LENGTH = 30-BTB_INDEX		
