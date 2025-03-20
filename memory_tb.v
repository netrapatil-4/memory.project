`include "memory.v"
module mem_tb();

reg  clk_i,rst_i,wr_rd_i,valid_i;
reg  [15:0]wdata_i;
reg  [5:0]addr_i;
wire [15:0]rdata_o;
wire ready_o; 

memory dut (.*);

always #5 clk_i=~clk_i;
initial begin
	clk_i=0;
	rst_i=1;
	rst_logic();					//reset the input signals
	repeat(2)@(posedge clk_i);
	rst_i=0;

	//write transaction
		@(posedge clk_i);			//every opertion performed at +ve edge of clk 
		wr_rd_i=1;					// doing write opertion
		addr_i=50;
		wdata_i=$random;
		valid_i=1;
		wait(ready_o==1);
		@(posedge clk_i);
			rst_logic();
	
	//read  transaction
		@(posedge clk_i);			//every opertion performed at +ve edge of clk 
		wr_rd_i=0;					// doing read  opertion
		addr_i=50;
		valid_i=1;
		wait(ready_o==1);
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

