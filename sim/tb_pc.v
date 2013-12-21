`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:49:54 10/16/2013
// Design Name:   pc
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_pc.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_pc;

	// Inputs
	reg i_clk;
	reg i_rst_n;
	reg [31:0] i_pc;

	// Outputs
	wire [31:0] o_pc;

	// Instantiate the Unit Under Test (UUT)
	pc uut (
		.i_clk(i_clk), 
		.i_rst_n(i_rst_n), 
		.i_pc(i_pc), 
		.o_pc(o_pc)
	);

	initial begin
		// Initialize Inputs
		i_clk = 0;
		i_rst_n = 0;
		i_pc = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        i_rst_n = 1;
        
        #60; 
        i_pc = 123;
        
        #60; 
        i_pc = 456;
        
        #60;
        i_rst_n = 0;
        
        #60;
        
	end

	always #10 i_clk <= ~i_clk; 
    
endmodule

