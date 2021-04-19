module secure_memory_top(clk,
						 reset,
						 dataa,
						 datab,
						 n,
						 clk_en,
						 start,
						 done,
						 result,
						 write,
						 readdata,
						 waitrequest,
						 address,
						 writedata,
						 byteenable,
						 chipselect);

  parameter xor_key = 32'h95DA4EAB;
// Custom Instruction Interface
  input clk;
  input reset;
  input [31:0] dataa;
  input [31:0] datab;
  input [2:0] n;
  input clk_en;
  input start;
  output reg done;
  output [31:0] result;
  
// Avalon Memory Interface
  input  [31:0] readdata;
  input         waitrequest;
  output [31:0] address;
  output  [3:0] byteenable;
  output        chipselect;
  output        write;
  output [31:0] writedata;

  wire [31:0] datain;
  wire [31:0] dataout;
  
  reg start_delay;
  reg [31:0] dataout_delay;

  assign datain = (n>0) ? dataa : readdata;
  assign result = (n>0) ? dataout_delay : dataout;

  assign address    = 32'h0;
  assign byteenable = 4'b1111;
  assign chipselect = 1'b0;
  assign write      = 1'b0;
  assign writedata  = 32'h0;
  
  always @(posedge clk) begin
    dataout_delay <= dataout;
	start_delay  <= start;
	done          <= start_delay;
  end
  
  secure_memory_xor xor_block(.clk(clk),
							  .reset(reset),
							  .clk_en(clk_en),
							  .datain(datain),
							  .dataout(dataout));
							  
  defparam xor_block.xor_key = xor_key;

endmodule