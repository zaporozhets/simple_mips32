`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:13 10/21/2013
// Design Name:   adder
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_adder.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_adder;

	// Inputs
	reg [31:0] i_op1;
	reg [31:0] i_op2;

	// Outputs
	wire [31:0] o_result;

	// Instantiate the Unit Under Test (UUT)
	adder uut (
		.i_op1(i_op1), 
		.i_op2(i_op2), 
		.o_result(o_result)
	);

	initial begin
		// Initialize Inputs
		i_op1 = 0;
		i_op2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        i_op1 = 5;
        i_op2 = 3;
   
		#10;
        i_op1 = 10;
        i_op2 = 5;

		#10;
        i_op1 = 25;
        i_op2 = 50;        

	end
      
endmodule

