`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:54:03 10/21/2013
// Design Name:   aluControl
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_aluControl.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: aluControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "../design/cpu/MIPS_Parameters.vh"

module tb_aluControl;

	// Inputs
	reg [1:0] i_aluOp;
	reg [5:0] i_func;

	// Outputs
	wire [3:0] o_aluControl;

	// Instantiate the Unit Under Test (UUT)
	aluControl uut (
		.i_aluOp(i_aluOp), 
		.i_func(i_func), 
		.o_aluControl(o_aluControl)
	);

	initial begin
		// Initialize Inputs
		i_aluOp = 0;
		i_func = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        $display("Test #1 Addition (for load and store)");
        #100;
        i_aluOp = 2'b00;
        i_func  = 6'b100100;
        
        $display("Test #2 Subtraction (for beq)");
		#100;
        i_aluOp = 2'b01;
        i_func  = 6'b100100;
/*
R-type	10	add         100000	add	                010
R-type	10	subtract	100010	subtract	        110
R-type	10	AND         100100	and	                000
R-type	10	OR          100101	or                  001
R-type	10	SLT         101010	set on less than	111
*/
        $display("Test #3 add");
		#100;
        i_aluOp = 2'b10;
        i_func  = 6'b100000;        
        
        $display("Test #4 sub ");
		#100;
        i_aluOp = 2'b10;
        i_func  = 6'b100010; 

        $display("Test #5 and");
		#100;
        i_aluOp = 2'b10;
        i_func  = 6'b100100; 
        
        $display("Test #6 or");
		#100;
        i_aluOp = 2'b10;
        i_func  = 6'b100101; 
        
        $display("Test #7 solt");
		#100;
        i_aluOp = 2'b10;
        i_func  = 6'b101010; 
        
        $display("Test #8");
        #100;
        i_aluOp = 2'b11;
        i_func  = 6'b100100;
	end
        
    
endmodule

