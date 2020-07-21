//////////////////////////////////////////////////////////////////////////////////
// File Name: 		Cache_tb.sv
// Module Name:		Mem - Cache Interface Testbench
// Project Name:	RVS192
// Author:	 		hungbk99
// University:     	DP S192	HCMUT
// Copyright (C) 	Le Quang Hung 
// Email: 			quanghungbk1999@gmail.com  
//////////////////////////////////////////////////////////////////////////////////

`include"RVS192_user_define.h"
import 	RVS192_package::*;
import	RVS192_user_parameters::*;
module Cache_tb
(
	output	logic												ICC_halt,
	output	logic 	[INST_LENGTH-1:0]							inst_fetch,
	input 	logic 	[PC_LENGTH-1:0]								pc,
	output 	logic												DCC_halt,
	output 	logic 	[DATA_LENGTH-1:0]							data_read,
	input 	logic 	[DATA_LENGTH-1:0]							data_write,
	input	[DATA_LENGTH-1:0]							alu_out,
	input												cpu_read,
	input												cpu_write,		
														clk_l1,
														clk_l2,
														mem_clk,
														rst_n
);
	timeunit	1us;
/*
	include"DL1_Cache.sv";
	include"IL1_Cache.sv";
	include"L2_Cache.sv";
	include"Memory.sv";
*/
	parameter	L2_TAG_LENGTH = DATA_LENGTH-BYTE_OFFSET-WORD_OFFSET-$clog2(L2_CACHE_LINE);

//	CPU

//	HANDSHAKE			
//	System	
//	logic 												clk_l1;
//	logic 												rst_n;
	
//	CPU

//	Dirty handshake		
//	Replace handshake	
	logic												inst_replace_req,
														data_replace_req;	
	logic 	[DATA_LENGTH-BYTE_OFFSET-WORD_OFFSET-1:0]	dl1_dirty_addr;													
//	 	logic 	[DATA_LENGTH-1:0]								update_addr;
//	logic 												update_req;
	logic 												update_ack;
//	Write Buffer
	logic												L2_full_flag;
//	 	logic 	[DATA_LENGTH-1:0]		wb_addr;	
//	System	

//	Il1 Cache
	cache_update_type									IL2_out;
//	output 	logic										inst_update_ack;
	logic 												inst_update_req;
	logic 	[PC_LENGTH-1:0]								pc_up;
	logic 												inst_replace_il1_ack,
														data_replace_il1_ack;			
	logic												L2_inst_il1_ack,
														L2_inst_dl1_ack,
														L2_data_il1_ack,
														L2_data_dl1_ack;
//	DL1 Cache
	cache_update_type									DL2_out;
//	output 	logic										data_update_ack;
	logic 												data_update_req;
	logic 	[PC_LENGTH-1:0]								alu_out_up;	
	logic	[DATA_LENGTH-1:0]							dirty_data1;
	logic	[DATA_LENGTH-1:0]							dirty_data2;
	logic 	[DATA_LENGTH-1:0]							dirty_addr;				// DL1 chi gui tag va index do do phai them bit 0 truoc khi su dung
	logic 	 											dirty_req;
	logic												dirty_ack;
	logic 	 											dirty_replace;	
	logic 	[2*DATA_LENGTH-BYTE_OFFSET-1:0]				wb_data;	
	logic		 										wb_req;
	logic 												wb_ack;	
	logic 												full_flag;
	logic 												inst_replace_dl1_ack,
														data_replace_dl1_ack;		
//	To both IL1 and DL1
	logic												inst_replace_check,
														data_replace_check;
	logic 	[L2_TAG_LENGTH+$clog2(L2_CACHE_LINE)-1:0]	inst_addr_replace,
														data_addr_replace;																
//	Mem
//	System
//	logic 												clk_l2;
	
	logic 	[INST_LENGTH-1:0]							inst_mem_read;
	logic 	[DATA_LENGTH-1:0]							data_mem_read;
	logic												inst_res,		//	Use for synchoronous
														data_res;
	logic	[DATA_LENGTH-1:0]							data_mem_write,
														data_addr;
	logic 	[PC_LENGTH-1:0]								inst_addr;
	logic 												inst_read_req,
														data_read_req,
														data_write_req;
//														mem_clk;

	IL1_Cache	IL1_DUT
	(
	.*
	);
	
	DL1_Cache	DL1_DUT
	(
	.inst_replace_req(inst_replace_check),
	.data_replace_req(data_replace_check),		
	.*
	);
	
	L2_Cache	L2_DUT
	(
	.dirty_addr({dl1_dirty_addr, {(BYTE_OFFSET+WORD_OFFSET){1'b0}}}),
	.*
	);
	
	Memory 		MEM_DUT
	(
	.*
	);

/*	
	initial begin
		clk_l1 = 1'b1;
		clk_l2 = 1'b1;
		mem_clk = 1'b1;
		rst_n = 1'b0;
		cpu_read = 1'b0;
		cpu_write = 1'b0;
		data_write = 32'h567;
		#4
		rst_n = 1'b1;
		pc = 32'h0004_0010;
		alu_out = 32'h10;
		cpu_read = 1'b1;

	end

	always_ff @(posedge clk_l1)
	begin
		if(IL2_out.update)
			pc = 32'h0004_0040;
		if(DL2_out.update)
		begin
			alu_out = 32'h040;
			cpu_write = 1'b1;
			cpu_read = 1'b0;
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
*/	
endmodule