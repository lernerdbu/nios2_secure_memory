module aesWrapper (clk, inputData, out);
	    input          clk;
		 input  [127:0] inputData;
       output [127:0] out;// keyout;
		 wire   [127:0] state;
		 wire   [127:0] key;
		 wire   [127:0] outAES;
		 
		 assign key = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
		 assign state = 128'h3243f6a8885a308d313198a2e0370734;
		 
		 aes_128
			aes0(clk, state, key, outAES);// keyout);
			
		assign out = outAES ^ inputData;
		 
endmodule 