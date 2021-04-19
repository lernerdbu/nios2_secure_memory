module secure_memory_xor(clk,
						 reset,
						 clk_en,
						 datain,
						 dataout);
 
  parameter xor_key = 32'h95DA4EAB;

  input  clk;
  input  reset;
  input  clk_en;
  input  [31:0] datain;
  output reg [31:0] dataout;

  wire [31:0] new_data;
  
  assign new_data = datain ^ xor_key;
  
  always @(posedge clk or posedge reset) begin
    if (reset == 1) begin
	  dataout <= 32'h0;
	end
	else begin
	  dataout <= new_data;
	end
  end
  
endmodule
