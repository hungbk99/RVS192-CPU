//////////////////////////////////////////////////////////////////////////////////
// File Name: 		Write_Buffer.sv
// Module Name:		RVS192 Branch Prediction Unit 		
// Project Name:	RVS192
// Author:	 		hungbk99
// University:     	DP S192	HCMUT
//////////////////////////////////////////////////////////////////////////////////

module	Write_Buffer
#(
parameter	DATA_LENGTH = 32,
parameter	TAG_LENGTH = 30,
parameter 	WB_DEPTH =10
)
(
	output 	logic 	[DATA_LENGTH+TAG_LENGTH-1:0]	data_out,
	output 	logic 	[DATA_LENGTH-1:0]				data_hit,
	output 	logic 									full_flag,
													empty_flag,
													overflow_flag,
													underflow_flag,
													hit,
	input	[DATA_LENGTH-1:0]						data_in,
	input 	[TAG_LENGTH-1:0]						tag_in,
	input	store,
	input 	load,
	input	clk,
	input 	rst_n
);
 
	parameter	POINTER_WIDTH = $clog2(WB_DEPTH);
	logic	[DATA_LENGTH+TAG_LENGTH-1:0]	WB	[WB_DEPTH-1:0];
	logic										write_en,
												read_en;
	logic	[POINTER_WIDTH:0] 					w_ptr,
												r_ptr;
	logic	[POINTER_WIDTH-1:0]	 				w_addr,
												r_addr,
												hit_addr;
	logic 	[WB_DEPTH-1:0]	[TAG_LENGTH-1:0]	tag_check;									
	
//	Write Counter
	always_ff @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			w_ptr <= '0;
		else if(write_en && !hit)
			w_ptr <= w_ptr + 1'b1;
	end
	
	assign 	write_en = store && !full_flag;
	
//	Read Counter
	always_ff @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			r_ptr <= '0;
		else if(read_en)
			r_ptr <= r_ptr + 1'b1;
	end		
	
	assign	read_en = load && !empty_flag;
	
//	Sync RAM with sync read, write, reset
	assign	w_addr = w_ptr[POINTER_WIDTH-1:0];
	assign	r_addr = r_ptr[POINTER_WIDTH-1:0];
	
	always_ff @(posedge clk)
	begin
		if(write_en)
		begin
			if(hit)
				WB[hit_addr] <= {tag_in, data_in};
			else
				WB[w_addr] <= {tag_in, data_in};
		end
		data_out <= WB[r_addr];
		data_hit <= WB[hit_addr][DATA_LENGTH-1:0];
	end
	
//	Interrupt Flag Generator
	assign	full_flag = (w_ptr[POINTER_WIDTH-1:0] == r_ptr[POINTER_WIDTH-1:0]) && (w_ptr[POINTER_WIDTH] != r_ptr[POINTER_WIDTH]);
	assign 	empty_flag = w_ptr[POINTER_WIDTH:0] == r_ptr[POINTER_WIDTH:0];
	assign 	overflow_flag = full_flag && store;
	assign 	underflow_flag = empty_flag && load;
	
//	Hit
	always_comb	begin
		hit_addr = 'x;
		hit = '0;
		for(int i = 0; i < WB_DEPTH; i++)
		begin
			tag_check[i] = WB[i][DATA_LENGTH+TAG_LENGTH-1:DATA_LENGTH];
			if(tag_in == tag_check[i])
			begin
			hit = 1'b1;
			hit_addr = i;
			end
		end
	end
	
endmodule


