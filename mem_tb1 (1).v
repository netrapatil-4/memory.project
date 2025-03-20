`include "memory.v"
module mem_tb();

parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WITH= $clog2(DEPTH);

reg  clk_i,rst_i,wr_rd_i,valid_i;
reg  [WIDTH-1:0]wdata_i;
reg  [ADDR_WITH-1:0]addr_i;
wire [WIDTH-1:0]rdata_o;
wire ready_o; 

memory #(WIDTH,DEPTH,ADDR_WITH)dut (.*);
integer i;
always #5 clk_i=~clk_i;
initial begin
	clk_i=0;
	rst_i=1;
	rst_logic();					//reset the input signals
	repeat(2)@(posedge clk_i);
	rst_i=0;

	//write transaction
	for(i=0;i<DEPTH;i=i+1)begin 
		@(posedge clk_i);			//every opertion performed at +ve edge of clk 
		wr_rd_i=1;					// doing write opertion
		addr_i=i;
		wdata_i=$random;
		valid_i=1;
		wait(ready_o==1);
	end
		@(posedge clk_i);
			rst_logic();
	
	//read  transaction
	for(i=0;i<DEPTH;i=i+1)begin 
		@(posedge clk_i);			//every opertion performed at +ve edge of clk 
		wr_rd_i=0;					// doing read  opertion
		addr_i=i;
		valid_i=1;
		wait(ready_o==1);
	end
		@(posedge clk_i);
			rst_logic();

	#100;
	$finish;

end
task rst_logic();
begin 
	addr_i=0;
	wdata_i=0;
	wr_rd_i=0;
	valid_i=0;
end
endtask
endmodule

