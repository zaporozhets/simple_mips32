`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:35:35 10/16/2013
// Design Name:   mux2in1
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_mux2in1.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux2in1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_mux2in1;

	// Inputs
	reg [31:0] i_dat0;
	reg [31:0] i_dat1;
	reg i_control;

	// Outputs
	wire [31:0] o_dat;

	// Instantiate the Unit Under Test (UUT)
	mux2in1 uut (
		.i_dat0(i_dat0), 
		.i_dat1(i_dat1), 
		.i_control(i_control), 
		.o_dat(o_dat)
	);

	initial begin
		// Initialize Inputs
		i_dat0 = 0;
		i_dat1 = 0;
		i_control = 0;

		// Wait 100 ns for global reset to finish
		#100;
 		i_dat0 = 1;
		i_dat1 = 2;
		i_control = 0;       
        
        #10;
		i_control = 1;         

		#10;
 		i_dat0 = 3;
		i_dat1 = 4;
		i_control = 0;  
        
 		#10;
		i_control = 1; 
        
	end
      
endmodule

