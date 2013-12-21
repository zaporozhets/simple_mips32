`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:54:06 11/20/2013
// Design Name:   mips
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_mips.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_mips;

    // Inputs
	reg cpu_clk;
	reg cpu_rst_n;
    
	// Instantiate the Unit Under Test (UUT)
    mips uut (
        .cpu_clk(cpu_clk), 
        .cpu_rst_n(cpu_rst_n)
    );
	initial begin
		// Initialize Inputs
        cpu_clk = 0;
        cpu_rst_n = 0;
        
        #100;
        cpu_rst_n = 1;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end

	always #10 cpu_clk <= ~cpu_clk; 
    
endmodule

