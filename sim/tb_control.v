`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:12:34 11/20/2013
// Design Name:   control
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_control.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "../design/cpu/MIPS_Parameters.vh"

module tb_control;

    integer i;
	// Inputs
	reg [15:0] i_instrCode;

	// Outputs
	wire o_regDst;
	wire o_jump;
	wire o_branch;
	wire o_memToReg;
	wire [1:0] o_aluOp;
	wire o_memWrite;
	wire o_aluSrc;
	wire o_regWrite;

	// Instantiate the Unit Under Test (UUT)
	control uut (
		.i_instrCode(i_instrCode), 
		.o_regDst(o_regDst), 
		.o_jump(o_jump), 
		.o_branch(o_branch), 
		.o_memToReg(o_memToReg), 
		.o_aluOp(o_aluOp), 
		.o_memWrite(o_memWrite), 
		.o_aluSrc(o_aluSrc), 
		.o_regWrite(o_regWrite)
	);

	initial begin
		// Initialize Inputs
		i_instrCode = 16'hFF_FF;
        i = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
        #20;
        $display("Test #1 OP_BEQ");
        i_instrCode[15:10] = `OP_BEQ;
        i = i + 1;
        
        #20;
        $display("Test #2 OP_J");
        i_instrCode[15:10] = `OP_J;
        i = i + 1;
        
        #20;
        $display("Test #3 OP_SW");
        i_instrCode = {`OP_SW, 10'b0};
        i = i + 1;
        
        #20;
        $display("Test #4 OP_LW");
        i_instrCode = {`OP_LW, 10'b0};
        i = i + 1;
        
        #20;
        $display("Test #5 OP_ADD");
        i_instrCode = {`OP_ADD, 10'b0};
        i = i + 1;
        
        #20;
        $display("Test #6 OP_SUB");
        i_instrCode = {`OP_SUB, 10'b0};
        i = i + 1;
        
        #20;
        $display("Test #7 OP_OR");
        i_instrCode = {`OP_OR, 10'b0};
        i = i + 1;
        
        #20;
        $display("Test #8 OP_AND");
        i_instrCode = {`OP_AND, 10'b0};
        i = i + 1;
        
        #20;
        $display("Test #9 OP_ADDI");
        i_instrCode = {`OP_ADDI, 10'b0};
        i = i + 1;
        
        $stop;
		$finish; 
	end
      
endmodule

