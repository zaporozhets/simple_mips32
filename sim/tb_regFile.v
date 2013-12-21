`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:58:09 10/16/2013
// Design Name:   regFile
// Module Name:   /home/taras/Documents/KPI/mips/mips/sim/tb_regFile.v
// Project Name:  mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_regFile;

	// Inputs
	reg i_clk;
	reg [4:0] i_raddr1;
	reg [4:0] i_raddr2;
	reg [4:0] i_waddr;
	reg [31:0] i_wdata;
	reg i_we;

	// Outputs
	wire [31:0] o_rdata1;
	wire [31:0] o_rdata2;

    integer i;
 
    parameter CLK_PERIOD = 10;
	always #(CLK_PERIOD /2)
        i_clk <= ~i_clk; 
        
	// Instantiate the Unit Under Test (UUT)
	regFile uut (
		.i_clk(i_clk), 
		.i_raddr1(i_raddr1), 
		.i_raddr2(i_raddr2), 
		.i_waddr(i_waddr), 
		.i_wdata(i_wdata), 
		.i_we(i_we), 
		.o_rdata1(o_rdata1), 
		.o_rdata2(o_rdata2)
	);

	initial begin
		// Initialize Inputs
		i_clk = 0;
		i_raddr1 = 0;
		i_raddr2 = 0;
		i_waddr = 0;
		i_wdata = 0;
		i_we = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        
		display_all_regs;
		write_all_regs;
		read_all_regs_from_read_port_1;
		read_all_regs_from_read_port_2;   
        
		$stop;
		$finish;        
	end
    
	task display_all_regs;
		begin
			$display("display_all_regs:");
			$display("------------------------------");
			for(i = 0; i < 32; i = i + 1)
					$write("%d\t",uut.mem[i]);
			$display("\n------------------------------");
		end
	endtask    

 	task write_all_regs;
		begin
			$display("write_all_regs(random):");
			$display("------------------------------");
			i = 0;
			while(i<32) begin
				i_we = 1;
				i_waddr = i;
				i_wdata = $random % 32768;
				#(CLK_PERIOD*1)
				$write("%d\t",uut.mem[i]);
				i_we = 0;
				i = i + 1;
			end
			$display("\n------------------------------");
		end
	endtask
    
    task read_all_regs_from_read_port_1;
		begin
			$display("read_all_regs_from_read_port_1:");
			$display("------------------------------");
			i = 0;
			while(i<32) begin
				i_raddr1 = i;
				#(CLK_PERIOD*1)
				$write("%d\t",o_rdata1);
				i = i + 1;
			end
			$display("\n------------------------------");
		end
	endtask

    task read_all_regs_from_read_port_2;
		begin
			$display("read_all_regs_from_read_port_2:");
			$display("------------------------------");
			i = 0;
			while(i<32) begin
				i_raddr2 = i;
				#(CLK_PERIOD*1)
				$write("%d\t",o_rdata2);
				i = i + 1;
			end
			$display("\n------------------------------");
		end
	endtask
endmodule

