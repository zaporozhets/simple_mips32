`include "MIPS_Parameters.vh"

module mips(
    cpu_clk,
    cpu_rst_n
);
    input cpu_clk;
    input cpu_rst_n;
      
/******************************************************************************
*
* uut PC
*
******************************************************************************/ 
    wire [31:0] cpu_pc_o_pc;  
	pc cpu_pc (
		.i_clk(cpu_clk), 
		.i_rst_n(cpu_rst_n), 
		.i_pc(cpu_mux_o_dat), 
		.o_pc(cpu_pc_o_pc)
	);

/******************************************************************************
*
* uut PC Adder
*
******************************************************************************/ 
    wire [31:0]  cpu_pc_adder_o_result;
	adder cpu_pc_adder (
		.i_op1(cpu_pc_o_pc), 
		.i_op2(4), 
		.o_result(cpu_pc_adder_o_result)
	);
    
/******************************************************************************
*
* uut ROM
*
******************************************************************************/  
    wire [(`ROM_ADDR_WIDTH-1):0] cpu_rom_i_addr = cpu_pc_o_pc;
    wire [(`ROM_DATA_WIDTH-1):0] cpu_rom_o_data;
	rom cpu_rom (
		.i_addr(cpu_rom_i_addr), 
		.o_data(cpu_rom_o_data)
	);
    
/******************************************************************************
*
* uut Control
*
******************************************************************************/  
	wire [15:0] cpu_control_i_instrCode = cpu_rom_o_data[31:16];
	wire cpu_control_o_regDst;
	wire cpu_control_o_jump;
	wire cpu_control_o_branch;
	wire cpu_control_o_memToReg;
	wire [1:0] cpu_control_o_aluOp;
	wire cpu_control_o_memWrite;
	wire cpu_control_o_aluSrc;
	wire cpu_control_o_regWrite;
	control cpu_control (
		.i_instrCode(cpu_control_i_instrCode), 
		.o_regDst(cpu_control_o_regDst), 
		.o_jump(cpu_control_o_jump), 
		.o_branch(cpu_control_o_branch), 
		.o_memToReg(cpu_control_o_memToReg), 
		.o_aluOp(cpu_control_o_aluOp), 
		.o_memWrite(cpu_control_o_memWrite), 
		.o_aluSrc(cpu_control_o_aluSrc), 
		.o_regWrite(cpu_control_o_regWrite)
	);    
    
/******************************************************************************
*
* uut Mux Reg file
*
******************************************************************************/
    wire [31:0] cpu_muxreg_i_dat0 = cpu_rom_o_data[20:16];
	wire [31:0] cpu_muxreg_i_dat1 = cpu_rom_o_data[15:11];
    wire [31:0] cpu_muxreg_o_dat;
	mux2in1 cpu_mux_regfile (
		.i_dat0(cpu_muxreg_i_dat0), 
		.i_dat1(cpu_muxreg_i_dat1), 
		.i_control(cpu_control_o_regDst), 
		.o_dat(cpu_muxreg_o_dat)
	);
 
/******************************************************************************
*
* uut Reg File
*
******************************************************************************/
	wire [4:0] cpu_regs_i_raddr1 = cpu_rom_o_data[25:21];
	wire [4:0] cpu_regs_i_raddr2 = cpu_rom_o_data[20:16];
	wire [4:0] cpu_regs_i_waddr = cpu_muxreg_o_dat;
	wire [31:0] cpu_regs_i_wdata = cpu_mux_ram_o_dat;
	wire [31:0] cpu_regs_o_rdata1;
	wire [31:0] cpu_regs_o_rdata2;
    
	regFile cpu_regs (
		.i_clk(cpu_clk), 
		.i_raddr1(cpu_regs_i_raddr1), 
		.i_raddr2(cpu_regs_i_raddr2), 
		.i_waddr(cpu_regs_i_waddr), 
		.i_wdata(cpu_regs_i_wdata), 
		.i_we(cpu_control_o_regWrite), 
		.o_rdata1(cpu_regs_o_rdata1), 
		.o_rdata2(cpu_regs_o_rdata2)
	);
    
/******************************************************************************
*
* uut ALU Control
*
******************************************************************************/
	wire [1:0] cpu_aluctrl_i_aluOp = cpu_control_o_aluOp;
	wire [5:0] cpu_aluctrl_i_func = cpu_rom_o_data[5:0];
	wire [3:0] cpu_aluctrl_o_aluControl;
	aluControl cpu_aluctrl (
		.i_aluOp(cpu_aluctrl_i_aluOp), 
		.i_func(cpu_aluctrl_i_func), 
		.o_aluControl(cpu_aluctrl_o_aluControl)
	);

/******************************************************************************
*
* uut ALU Sign Extender
*
******************************************************************************/
    wire[31:0] cpu_alu_sigext_o_data;
	signExtend cpu_alu_sigext (
		.i_data(cpu_rom_o_data[15:0]), 
		.o_data(cpu_alu_sigext_o_data)
    ); 
    
/******************************************************************************
*
* uut Mux ALU
*
******************************************************************************/
    wire [31:0] cpu_muxalu_o_dat;
	mux2in1 cpu_mux_alu (
		.i_dat0(cpu_regs_o_rdata2), 
		.i_dat1(cpu_alu_sigext_o_data), 
		.i_control(cpu_control_o_aluSrc), 
		.o_dat(cpu_muxalu_o_dat)
	);

/******************************************************************************
*
* uut ALU
*
******************************************************************************/
	wire [31:0] cpu_alu_o_result;
    wire cpu_alu_o_zf;
	alu cpu_alu (
		.i_op1(cpu_regs_o_rdata1), 
		.i_op2(cpu_muxalu_o_dat), 
		.i_control(cpu_aluctrl_o_aluControl), 
		.o_result(cpu_alu_o_result), 
		.o_zf(cpu_alu_o_zf)
	);
    
/******************************************************************************
*
* uut RAM
*
******************************************************************************/
	wire [4:0] cpu_ram_i_addr = cpu_alu_o_result;
	wire [31:0] cpu_ram_i_data = cpu_regs_o_rdata2;
	wire [31:0] cpu_ram_o_data;
    
	ram cpu_ram (
		.i_clk(cpu_clk), 
		.i_addr(cpu_ram_i_addr), 
		.i_data(cpu_ram_i_data), 
		.i_we(cpu_control_o_memWrite), 
		.o_data(cpu_ram_o_data)
	);
    
 /******************************************************************************
*
* uut Mux RAM
*
******************************************************************************/ 
    wire [31:0] cpu_mux_ram_o_dat;
	mux2in1 cpu_mux_ram (
		.i_dat0(cpu_alu_o_result), 
		.i_dat1(cpu_ram_o_data), 
		.i_control(cpu_control_o_memToReg), 
		.o_dat(cpu_mux_ram_o_dat)
	);
    
/******************************************************************************
*
* uut PC Shifter(for jump/brunch)
*
******************************************************************************/
    wire [31:0] cpu_pc_shifter_o_data;
	shiftLeftBy2 cpu_pc_shifter (
		.i_data(cpu_alu_sigext_o_data), 
		.o_data(cpu_pc_shifter_o_data)
	);

 /******************************************************************************
*
* uut Brunch PC Adder
*
******************************************************************************/
    wire [31:0] cpu_br_adder_o_result;
	adder cpu_br_adder (
		.i_op1(cpu_pc_shifter_o_data), 
		.i_op2(cpu_pc_adder_o_result), 
		.o_result(cpu_br_adder_o_result)
	);
    
 /******************************************************************************
*
* uut PC MUX(for jump/brunch)
*
******************************************************************************/
    wire [31:0] cpu_jb_mux_i_dat0 = cpu_br_adder_o_result;
    wire [31:0] cpu_jb_mux_i_dat1 = cpu_pc_shifter_o_data;
    wire cpu_jb_mux_i_control = cpu_control_o_jump;
    wire [31:0] cpu_jb_mux_o_dat;   
	mux2in1 cpu_jb_mux_pc (
		.i_dat0(cpu_jb_mux_i_dat0), 
		.i_dat1(cpu_jb_mux_i_dat1), 
		.i_control(cpu_jb_mux_i_control), 
		.o_dat(cpu_jb_mux_o_dat)
	);
    
/******************************************************************************
*
* uut PC MUX(norm/jump/brunch)
*
******************************************************************************/
    wire [31:0] cpu_mux_i_dat0 = cpu_pc_adder_o_result;
    wire [31:0] cpu_mux_i_dat1 = cpu_jb_mux_o_dat;
    wire cpu_mux_i_control = cpu_control_o_jump || (cpu_control_o_branch && cpu_alu_o_zf);
    wire [31:0] cpu_mux_o_dat;
	mux2in1 cpu_mux_pc (
		.i_dat0(cpu_mux_i_dat0), 
		.i_dat1(cpu_mux_i_dat1), 
		.i_control(cpu_mux_i_control), 
		.o_dat(cpu_mux_o_dat)
	);

endmodule
