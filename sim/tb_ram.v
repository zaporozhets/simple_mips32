`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:47:40 10/16/2013
// Design Name:   ram
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_ram.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_ram;

	// Inputs
	reg i_clk;
	reg [4:0] i_addr;
	reg [31:0] i_data;
	reg i_we;

	// Outputs
	wire [31:0] o_data;

    integer i;
 
    parameter CLK_PERIOD = 10;
	always #(CLK_PERIOD /2)
        i_clk <= ~i_clk; 
        
	// Instantiate the Unit Under Test (UUT)
	ram uut (
		.i_clk(i_clk), 
		.i_addr(i_addr), 
		.i_data(i_data), 
		.i_we(i_we), 
		.o_data(o_data)
	);

	initial begin
		// Initialize Inputs
		i_clk = 0;
		i_addr = 0;
		i_data = 0;
		i_we = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        display_all_mem;
        write_all_mem;
        read_all_mem;
        display_all_mem;
        
		$stop;
		$finish;        
	end
    
	task display_all_mem;
		begin
			$display("display_all_mem:");
			$display("------------------------------");
			for(i = 0; i < 32; i = i + 1)
					$write("%d\t",uut.mem[i]);
			$display("\n------------------------------");
		end
	endtask    

 	task write_all_mem;
		begin
			$display("write_all_mem(random):");
			$display("------------------------------");
			i = 0;
			while(i<32) begin
				i_we = 1;
				i_addr = i;
				i_data = $random % 32768;
				#(CLK_PERIOD*1)
				$write("%d\t",uut.mem[i]);
				i_we = 0;
				i = i + 1;
			end
			$display("\n------------------------------");
		end
	endtask
    
    task read_all_mem;
		begin
			$display("read_all_mem:");
			$display("------------------------------");
			i = 0;
			while(i<32) begin
				i_addr = i;
				#(CLK_PERIOD*1)
				$write("%d\t",o_data);
				i = i + 1;
			end
			$display("\n------------------------------");
		end
	endtask
      
endmodule

