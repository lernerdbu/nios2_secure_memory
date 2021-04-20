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
  input         clk;
  input         reset;
  input  [31:0] dataa;
  input  [31:0] datab;
  input   [2:0] n;
  input         clk_en;
  input         start;
  output        done;
  output [31:0] result;
  
  // Avalon Memory Interface
  input  [31:0]     readdata;
  input             waitrequest;
  output reg [31:0] address;
  output reg [3:0]  byteenable;
  output reg        chipselect;
  output reg        write;
  output reg [31:0] writedata;

  wire [31:0] datain;
  wire [31:0] dataout;
  wire        active1, active2;
  
  reg [31:0] dataa_delay, dataa_delay2;
  reg [31:0] datab_delay, datab_delay2;
  reg  [2:0] n_delay, n_delay2;
  reg        clk_en_delay, clk_en_delay2;
  reg        start_delay, start_delay2, start_delay3;

  assign active1 = start_delay & clk_en_delay;
  assign active2 = start_delay2 & clk_en_delay2;
  
  // Decrypt after 2nd cycle for reads, after 1st cycle for writes
  assign datain  = ((n_delay > 0) & active1) ? dataa_delay : 
                   (((n_delay2 == 0) & active2) ? readdata : xor_key);
  // Reads take 3 cycles, writes take 2
  assign done    = ((n_delay2 > 0) & active2) ? start_delay2 : start_delay3;
  assign result  = dataout;


  // Assign memory interface signals
  always @(*) begin
    //Reads go to mem first, then xor
    if ((n_delay == 0) & active1) begin 
      address    = datab_delay;
      byteenable = 4'b1111;
      chipselect = start_delay;
      write      = 1'b0;
      writedata  = 32'h0;
	end  
	// Writes go to xor, them mem
	else if ((n_delay2 > 0) & active2) begin 
	  address    = datab_delay2;
      byteenable = 4'b1111;
      chipselect = start_delay2;
      write      = 1'b1;
      writedata  = dataout;
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
  always @(posedge clk or negedge reset) begin
    if (reset == 0) begin
      dataa_delay   <= 32'h0;
	  datab_delay   <= 32'h0;
	  n_delay       <= 3'h0;
	  clk_en_delay  <= 1'b0;
	  start_delay   <= 1'b0;
	  
      dataa_delay2  <= 32'h0;
	  datab_delay2  <= 32'h0;
	  n_delay2      <= 3'h0;
	  clk_en_delay2 <= 1'b0;
	  start_delay2  <= 1'b0;
	  
	  start_delay3  <= 1'b0;	
	end
	else begin
      dataa_delay   <= dataa;
	  datab_delay   <= datab;
	  n_delay       <= n;
	  clk_en_delay  <= clk_en;
	  start_delay   <= start;
	  
      dataa_delay2  <= dataa_delay;
	  datab_delay2  <= datab_delay;
	  n_delay2      <= n_delay;
	  clk_en_delay2 <= clk_en_delay;
	  start_delay2  <= start_delay;
	  
	  start_delay3  <= start_delay2 & active2 & (n_delay2 == 0);
	end
  end
  
  // XOR encryption block always operating, takes 1 cycle
  secure_memory_xor xor_block(.clk(clk),
							  .datain(datain),
							  .dataout(dataout));
							  
  defparam xor_block.xor_key = xor_key;

endmodule
