module secure_memory_xor(clk,
						 datain,
						 dataout);
 
  parameter xor_key = 32'h95DA4EAB;

  input  clk;
  input  [31:0] datain;
  output reg [31:0] dataout;

  wire [31:0] new_data;
  
  assign new_data = datain ^ xor_key;
  
  always @(posedge clk) begin
	dataout <= new_data;
  end
  
endmodule
