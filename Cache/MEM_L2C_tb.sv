//////////////////////////////////////////////////////////////////////////////////
// File Name: 		MEM_L2C_tb.sv
// Module Name:		Mem - L2 Cache Interface Testbench
// Project Name:	RVS192
// Author:	 		hungbk99
// University:     	DP S192	HCMUT
// Copyright (C) 	Le Quang Hung 
// Email: 			quanghungbk1999@gmail.com  
//////////////////////////////////////////////////////////////////////////////////

`include"RVS192_user_define.h"
import 	RVS192_package::*;
import	RVS192_user_parameters::*;
module	MEM_L2C_tb();
	timeunit 10us;
	include"L2_Cache.sv";
	include"Memory.sv";
	parameter 	WB_DEPTH = 16;	
	parameter	WORD_LENGTH = 16;	
	parameter	TAG_LENGTH = DATA_LENGTH-BYTE_OFFSET-WORD_OFFSET-$clog2(L2_CACHE_LINE);	
	parameter	POINTER_WIDTH = $clog2(WB_DEPTH);	
//	Il1 Cache	
	cache_update_type										IL2_out;
	logic 													inst_update_ack;
	logic 													inst_update_req;
	logic 	[PC_LENGTH-1:0]									pc_up;
//	DL1 Cache
	cache_update_type										DL2_out;
	logic 													data_update_ack;
	logic 													data_update_req;
	logic 	[PC_LENGTH-1:0]									alu_out_up;	
	logic	[DATA_LENGTH-1:0]								dirty_data1;
	logic	[DATA_LENGTH-1:0]								dirty_data2;
	logic 	[DATA_LENGTH-1:0]								dirty_addr;	
	logic 	 												dirty_req;
	logic 													dirty_ack;
	logic 	 												dirty_replace;	
	logic 	[2*DATA_LENGTH-BYTE_OFFSET-1:0]					wb_data;	
	logic		 											wb_req;
	logic 		 											wb_ack;	
	logic 		 											full_flag;
//	Mem
	logic	[INST_LENGTH-1:0]								inst_mem_read;
	logic	[DATA_LENGTH-1:0]								data_mem_read;
	logic	[DATA_LENGTH-1:0]								data_mem_write;	
	logic 													inst_read_req,
															data_read_req,
															data_write_req;
	logic	[DATA_LENGTH-1:0]								data_addr,
															data_mem_write_sync;
	logic	[PC_LENGTH-1:0]									inst_addr;
	logic 													data_res;
	logic 													inst_res;
//	System
	logic													clk_l1;
	logic 													clk_l2;
	logic													rst_n;	
	logic 													mem_clk,
															dirty_req_sync,
															wb_req_ena1,
															wb_req_ena,
															dirty_write_ena,
															ena,
															wb_en,
															stop,
															write_done;
															
	logic 	[L2_CACHE_LINE-1:0]	VALID_CHECK [L2_CACHE_WAY-1:0];	
	logic 	[L2_CACHE_LINE-1:0]	DIRTY_CHECK [L2_CACHE_WAY-1:0];	
	
	logic 	[$clog2(L2_CACHE_LINE)-1:0]							inst_index,
																data_index,
																wb_index_split,
																dirty_index,
																data_replace_index;	
	logic 	[L2_CACHE_LINE-1:0]									data_hit_way,
																inst_hit_way;
																
	logic 	[31:0]												data_wb;
	logic 	[29:0]												tag_wb;

	logic 	[TAG_LENGTH-1:0]									inst_tag,
																wb_tag_split,
																data_replace_tag,
																dirty_tag,
																data_tag,
																inst_hit_tag,
																data_hit_tag,
																inst_tag_out_way	[L2_CACHE_WAY],
																data_tag_out_way	[L2_CACHE_WAY];

	logic	[POINTER_WIDTH:0] 									w_ptr,
																r_ptr;
														
	logic	[POINTER_WIDTH-1:0]	 								w_addr,
																r_addr;

	logic 	[WB_DEPTH-1:0]										valid;

	logic 	[$clog2(WORD_LENGTH)-1:0]							word_count;	
	logic 	[2:0]												current_state;	

	logic														inst_replace_req,
																data_replace_req;
	logic 	[TAG_LENGTH-1:0]									inst_tag_replace,
																data_tag_replace;
	logic 														inst_replace_il1_ack,
																data_replace_il1_ack,
																inst_replace_dl1_ack,
																data_replace_dl1_ack;																	
	L2_Cache	CACHE
	(
	.*
	);
	
	Memory	MEM
	(
	.*
	);

	assign 	current_state = CACHE.DATA_WRITE_INTERFACE.current_state;	
	assign 	write_done = CACHE.DATA_WRITE_INTERFACE.write_done;
	assign 	word_count = CACHE.DATA_WRITE_INTERFACE.word_count;
	assign 	w_addr = CACHE.WB_L2.w_addr;
	assign 	r_addr = CACHE.WB_L2.r_addr;
	assign 	w_ptr = CACHE.WB_L2.w_ptr;
	assign 	r_ptr = CACHE.WB_L2.r_ptr;
	assign 	valid = CACHE.WB_L2.valid;	
	assign 	VALID_CHECK = CACHE.VALID_CHECK;
	assign 	DIRTY_CHECK = CACHE.DIRTY_CHECK;
	assign 	data_replace_index = CACHE.data_replace_index;
	assign 	dirty_index = CACHE.dirty_index;
	assign 	wb_index_split = CACHE.wb_index_split;
	assign 	dirty_req_sync = CACHE.dirty_req_sync;
	assign 	data_index = CACHE.data_index;
	assign 	wb_req_ena = CACHE.wb_req_ena;
	assign 	wb_req_ena1 = CACHE.wb_req_ena1;
	assign 	dirty_write_ena = CACHE.dirty_write_ena;
	assign 	data_hit_way = CACHE.data_hit_way;
	assign 	inst_hit_way = CACHE.inst_hit_way;
	assign 	data_mem_write_sync = MEM.data_mem_write_sync;
	assign 	inst_tag_out_way = CACHE.inst_tag_out_way;
	assign 	data_tag_out_way = CACHE.data_tag_out_way;
	assign 	stop = CACHE.DATA_WRITE_INTERFACE.stop;
	
	initial begin
		ena = 1'b0;
		clk_l1 = 1;
		clk_l2 = 1;
		mem_clk = 1;;
		rst_n = 0;
		//	L1 data dirty
		dirty_replace = '0;	
		dirty_data1 = '0;
		dirty_data2 = '0;
		dirty_addr = '0;	
		dirty_req = '0;;	
		//	WB
		wb_data = '0;	
		wb_req = '0;		
		//	L1 data replace
		data_update_req = 1'b1;			//	data miss 
		alu_out_up = '0;	
		//	L1 inst replace
		inst_update_req = 1'b1;			//	inst miss
		pc_up = 32'h0004_0000;
		#1
		rst_n = 1'b1;
		#400
		pc_up = 32'h0004_1000;
		inst_update_req = 1'b0;			
		data_update_req = 1'b0;				
		#5
		pc_up = 32'h0004_1010;
		alu_out_up = 32'h0000_0100;			
		#12
		pc_up = 32'h0004_0010;
		#2
		pc_up = 32'h0004_0000;
		#2
		pc_up = 32'h0004_0060;			//	different index
		#2
		ena = 1'b1;
		pc_up = 32'h0004_1011;
		#(4*6)
		dirty_replace = 1'b1;
		dirty_addr = 0;
		dirty_data1 = 32'h0000_0000;
		dirty_data2 = 32'h0000_0080;
		#2
		dirty_data1 = 32'h0000_0010;
		dirty_data2 = 32'h0000_0090;		
		#2
		dirty_data1 = 32'h0000_0020;
		dirty_data2 = 32'h0000_0100;
		#2
		dirty_data1 = 32'h0000_0030;
		dirty_data2 = 32'h0000_0110;
		#2
		dirty_data1 = 32'h0000_0040;
		dirty_data2 = 32'h0000_0120;
		#2
		dirty_data1 = 32'h0000_0050;
		dirty_data2 = 32'h0000_0130;
		#2
		dirty_data1 = 32'h0000_0060;
		dirty_data2 = 32'h0000_0140;
		#2
		dirty_data1 = 32'h0000_0070;
		dirty_data2 = 32'h0000_0150;
		#2
		dirty_replace = 1'b0;
		dirty_req = 1'b1;
		#6
		dirty_req = 1'b0;
//		Check replace dirty L2
		force CACHE.RANDOM.inst_replace_way_new = 4;
		inst_update_req = 1'b1;			//	inst miss
		pc_up = 32'h0014_0000;		
	end

	always_ff @(posedge clk_l1)
	begin
		if(!ena)
		begin
			wb_req <= 1'b0;
			tag_wb <= 30'h007;
			data_wb <= 32'h1110;
			wb_en <= 1'b1;
		end
		else 
		begin
			if(!full_flag)
			begin
				wb_data <= {tag_wb, data_wb};
				wb_en <= 1'b0;
				if(wb_en)
					wb_req <= 1'b1;
			end
			if(wb_ack)
			begin
				wb_req <= 1'b0;			
				wb_en <= 1'b1;
				tag_wb <= tag_wb + 1;
				data_wb <= data_wb +1;				
			end
		end
	end

//	Clock Gen	
	initial begin
		forever #1	clk_l1 = !clk_l1;
	end

	initial begin
		forever #2	clk_l2 = !clk_l2;	
	end
	
	initial begin
		forever #3	mem_clk = !mem_clk;				
	end
	
endmodule	