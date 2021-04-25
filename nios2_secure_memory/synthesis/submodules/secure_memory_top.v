module secure_memory_top(clk,
						 reset,
						 dataa,
						 datab,
						 n,
						 clk_en,
						 start,
						 done,
						 result,
						 clk_sink,
						 reset_sink,
						 write,
						 readdata,
						 waitrequest,
						 address,
						 writedata,
						 byteenable,
						 chipselect);

  parameter xor_key = 32'h95DA4EAB;
  
  // Custom Instruction Interface
  input         clk;
  input         reset;
  input  [31:0] dataa;
  input  [31:0] datab;
  input   [2:0] n;
  input         clk_en;
  input         start;
  input         clk_sink;
  input         reset_sink;
  output        done;
  output [31:0] result;
  
  // Avalon Memory Interface
  input      [31:0] readdata;
  input             waitrequest;
  output reg [15:0] address;
  output reg  [3:0] byteenable;
  output reg        chipselect;
  output reg        write;
  output reg [31:0] writedata;

  reg start_delay, start_delay2;

  wire [31:0] datain, dataout;

  // Reads take 2 cycles, writes take 1
  assign done    = (n == 0) ? start_delay2 : start_delay;
  assign result  = dataout;

  assign datain  = (n == 0) ? readdata : dataa;

  // Assign memory interface signals
  always @(*) begin
    // Writes get XOR first, then go to memory
	if ((n > 0) & start_delay) begin 
	  address    = (datab[15:0] - 16'h8000) >> 2; // Byte aligned addr
      byteenable = 4'b1111;
      chipselect = 1'b1;
      write      = 1'b1;
      writedata  = dataout;
	end
	// Reads go to memory first, then XOR
	else if ((n == 0) & start) begin
	  address    = (datab[15:0] - 16'h8000) >> 2; // Byte aligned addr
      byteenable = 4'b1111;
      chipselect = 1'b1;
      write      = 1'b0;
      writedata  = 32'h0;
	end
	// Zero out when interface is idle
	else begin
	  address    = 32'h0;
      byteenable = 4'h0;
      chipselect = 1'b0;
      write      = 1'b0;
      writedata  = 32'h0;
	end
  end
  
  // Flop instruction controls
  always @(posedge clk or posedge reset) begin
    if (reset == 1) begin
	  start_delay   <= 1'b0;
      start_delay2  <= 1'b0;  
	end
	else begin
	  start_delay   <= start;
	  start_delay2  <= start_delay;
	end
  end
  
  // XOR encryption block always operating, takes 1 cycle
  secure_memory_xor xor_block(.clk(clk),
							  .datain(datain),
							  .dataout(dataout));
							  
  defparam xor_block.xor_key = xor_key;

endmodule
