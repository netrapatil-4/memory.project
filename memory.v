// Declare 1Kb memory with 16 bit width
//module declaration 
module memory(clk_i,rst_i,addr_i,wdata_i,rdata_o,wr_rd_i,valid_i,ready_o);
//ports declartion (direction,sizes)
parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WITH= $clog2(DEPTH);

input clk_i,rst_i,wr_rd_i,valid_i;
input [WIDTH-1:0]wdata_i;
input [ADDR_WITH-1:0]addr_i;
output reg  [WIDTH-1:0]rdata_o;
output reg ready_o; 
//internal registers  
reg [WIDTH-1:0]mem[DEPTH-1:0];
integer i;
//functionality 
//procedural blocks
always@(posedge clk_i)begin
		if(rst_i==1)begin 							    //reset all the reg variables 
			rdata_o=0;
			ready_o=0;
			//mem=0; //not possible 
			for(i=0;i<DEPTH;i=i+1)mem[i]=0;
		end
		else begin									    // do functionality 
			if(valid_i==1)begin							//TB is ready to  transaction
				ready_o=1;								//im ready to accept the  transcation
					if(wr_rd_i==1)begin 				//TB doing  write transcation
						mem[addr_i]=wdata_i;	
					end
					else begin							//TB doing read transcation
						rdata_o = mem[addr_i];		
					end	
			end
			else begin
				ready_o=0;
			end
		end
end
endmodule
