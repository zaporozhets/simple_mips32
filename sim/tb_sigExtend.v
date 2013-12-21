`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:40:51 10/16/2013
// Design Name:   signExtend
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_sigExtend.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signExtend
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_sigExtend;

	// Inputs
	reg [15:0] i_data;

	// Outputs
	wire [31:0] o_data;

	// Instantiate the Unit Under Test (UUT)
	signExtend uut (
		.i_data(i_data), 
		.o_data(o_data)
	);

	initial begin
		// Initialize Inputs
		i_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		#20; i_data = 16'b1000_0000_0000_1111;

		#20; i_data = 16'b0000_0000_0000_1111;
        
        #20; i_data = 16'b1000_0000_0000_1111;
                
        #20; i_data = 16'b0000_0000_0000_1111;
	end
      
endmodule

