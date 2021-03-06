/*
 * Copyright 2012, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

`timescale 1ns / 1ps

module test_aesWrapper;

	// Inputs
	reg clk;
	reg [127:0] inputData;

	// Outputs
	wire [127:0] out;

    // Instantiate the Unit Under Test (UUT)
  aesWrapper uut (
      .clk(clk), 
      .inputData(inputData), 
      .out(out)
  );

	initial begin
	clk = 0;
	inputData = 0;

	#100;
        /*
         * TIMEGRP "key" OFFSET = IN 6.4 ns VALID 6 ns AFTER "clk" HIGH;
         * TIMEGRP "state" OFFSET = IN 6.4 ns VALID 6 ns AFTER "clk" HIGH;
         * TIMEGRP "out" OFFSET = OUT 2.2 ns BEFORE "clk" HIGH;
         */
        @ (negedge clk);
        	# 110;
        	inputData = 128'hcb956176982812716aa581a54a532e1d;
        	#10;
        	inputData = 128'hf2b0e56b9af41b8ab6b404325339252f;
        	#10
       		inputData = 128'h0;
        
	$display("Good.");
        $finish;
	end
      
    always #5 clk = ~clk;
endmodule

