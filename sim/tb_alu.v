`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:29:57 10/21/2013
// Design Name:   alu
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_alu.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "../design/cpu/MIPS_Parameters.vh"

module tb_alu;
   
    integer i;
    
	// Inputs
	reg [31:0] i_op1;
	reg [31:0] i_op2;
	reg [3:0] i_control;

	// Outputs
	wire [31:0] o_result;
	wire o_zf;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.i_op1(i_op1), 
		.i_op2(i_op2), 
		.i_control(i_control), 
		.o_result(o_result), 
		.o_zf(o_zf)
	);

	initial begin
		// Initialize Inputs
		i_op1 = 0;
		i_op2 = 0;
		i_control = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        $display("AND:");
        i_control = `ALU_AND;
        op_test;

        $display("OR:");
        i_control = `ALU_OR;
        op_test;

        $display("ADD:");
        i_control = `ALU_ADD;
        op_test;

        $display("SUB:");
        i_control = `ALU_SUB;
        op_test;

        $display("SOLT:");
        i_control = `ALU_SOLT;
        op_test;

        $display("NOR:");
        i_control = `ALU_NOR;
        op_test;        
		$stop;
		$finish; 
	end

    task op_test;
		begin
			$display("------------------------------");
			i = 0;
			while(i<32) begin
                i_op1 = $random % 255;
				i_op2 = $random % 255;
                #10;
				$write("i_op1:%h\ti_op2:%h\to_result:%h\to_zf:%h\n",i_op1, i_op2, o_result, o_zf);
				i = i + 1;
			end
			$display("\n------------------------------");
		end
	endtask
    
endmodule

