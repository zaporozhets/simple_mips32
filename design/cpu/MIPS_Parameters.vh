`ifndef _mips_parameters_vh_
`define _mips_parameters_vh_

`define ROM_DATA_WIDTH (32)
`define ROM_ADDR_WIDTH (8)
`define ROM_DEPTH (1 << `ROM_ADDR_WIDTH)

`define RAM_DATA_WIDTH (32)
`define RAM_ADDR_WIDTH (5) //32 4-byte words 
`define RAM_DEPTH (1 << `RAM_ADDR_WIDTH)

`define ALU_AND  (4'b0000)
`define ALU_OR   (4'b0001)
`define ALU_ADD  (4'b0010)
`define ALU_SUB  (4'b0110)
`define ALU_SOLT (4'b0111) //SOLT - Set On Less then
`define ALU_NOR  (4'b1100)

`define ALU_OP_ADD  (2'b00)
`define ALU_OP_SUB  (2'b01)
`define ALU_OP_FUNC (2'b10)
`define ALU_OP_NOP  (2'b11)


`define OP_BEQ  (6'b0001_00)    // Branches if the two registers are equal
`define OP_J    (6'b0000_10)    // Jumps to the calculated address
`define OP_SW   (6'b1010_11)    // The contents of $t is stored at the specified address
`define OP_LW   (6'b1000_11)    // A word is loaded into a register from the specified address.

`define OP_ADD  (6'b0000_00)    // Adds two registers and stores the result in a register
`define OP_SUB  (6'b0000_00)    // Subtracts two registers and stores the result in a register
`define OP_OR   (6'b0000_00)    // Bitwise logical ors two registers and stores the result in a register
`define OP_AND  (6'b0000_00)    // Bitwise ands two registers and stores the result in a register
`define OP_ADDU (6'b0000_00)    // Adds two registers and stores the result in a register
`define OP_SUBU (6'b0000_00)    // Subtracts two registers and stores the result in a register

`define OP_ADDI (6'b0010_00)    // Adds a register and a sign-extended immediate value and stores the result in a register
`define OP_ADDUI (6'b0010_01)    // Adds a register and a sign-extended immediate value and stores the result in a register


`endif  //_mips_parameters_vh_