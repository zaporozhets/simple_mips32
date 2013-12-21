`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:26:58 10/16/2013
// Design Name:   shiftLeftBy2
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_shiftLeftBy2.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: shiftLeftBy2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_shiftLeftBy2;

	// Inputs
	reg [31:0] i_data;

	// Outputs
	wire [31:0] o_data;
    
    integer i;
	// Instantiate the Unit Under Test (UUT)
	shiftLeftBy2 uut (
		.i_data(i_data), 
		.o_data(o_data)
	);

	initial begin
		// Initialize Inputs
		i_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		shift_loop;
		$stop;
		$finish; 
        
	end
 	task shift_loop;
		begin
			$display("shift_loop(counter):");
			$display("------------------------------");
			i = 0;
			while(i<32) begin
				i_data = i;
				#20;$write("i_data: %d, o_data: %d\n", i_data, o_data);
				i = i + 1;
			end
			$display("\n------------------------------");
		end
	endtask
    
endmodule

