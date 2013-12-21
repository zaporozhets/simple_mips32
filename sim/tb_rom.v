`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:29:17 10/16/2013
// Design Name:   rom
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_rom.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rom
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_rom;

	// Inputs
	reg [7:0] i_addr;

	// Outputs
	wire [31:0] o_data;

    integer i;
 	// Inputs
	reg i_clk;
    
    parameter CLK_PERIOD = 10;
	always #(CLK_PERIOD /2)
        i_clk <= ~i_clk; 
        
	// Instantiate the Unit Under Test (UUT)
	rom uut (
		.i_addr(i_addr), 
		.o_data(o_data)
	);

	initial begin
		// Initialize Inputs
		i_addr = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		display_all_mem;
		$stop;
		$finish; 
	end
    
	task display_all_mem;
		begin
			$display("display_all_mem:");
			$display("------------------------------");
            i = 0;
			for(i = 0; i < 32; i = i + 1) begin
                i_addr = i;
                #(CLK_PERIOD*1);
                $write("%d\t", o_data);
            end
			$display("\n------------------------------");
		end
	endtask      
endmodule

