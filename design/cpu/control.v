`include "MIPS_Parameters.vh"

module control(i_instrCode, 
               o_regDst,
               o_jump, 
               o_branch,
               o_memToReg,
               o_aluOp,
               o_memWrite,
               o_aluSrc,
               o_regWrite
               );
  
input     [15:0]  i_instrCode;
output            o_regDst;
output            o_jump; 
output            o_branch;
output            o_memToReg;
output    [1:0]   o_aluOp;
output            o_memWrite;
output            o_aluSrc;
output            o_regWrite;

    wire [15:10] op;
    assign op = i_instrCode[15:10];
    
    assign o_jump = (`OP_J == op) ? 1 : 0;
    assign o_branch = (`OP_BEQ == op) ? 1 : 0;
   
    assign o_regDst = 
        (
            (`OP_ADD == op) ||
            (`OP_SUB == op) ||
            (`OP_SUB == op) ||
            (`OP_OR == op)
        ) ? 1 : 0;
 
    
    assign o_memToReg = (`OP_LW == op) ? 1 : 0;
    
    assign o_aluOp = 
        (
            (`OP_SW == op) ||
            (`OP_LW == op) ||
            (`OP_ADDI == op)   
        ) ? `ALU_OP_ADD : 
        (
            (`OP_BEQ == op)                       
        ) ? `ALU_OP_SUB :
        (
            (`OP_ADD == op) ||
            (`OP_SUB == op) ||
            (`OP_SUB == op) ||
            (`OP_OR == op)
        ) ? `ALU_OP_FUNC : `ALU_OP_NOP;
    
    assign o_memWrite = (`OP_SW == op) ? 1 : 0;
    
    assign o_aluSrc = 
        (
            (`OP_SW == op) ||
            (`OP_LW == op)  ||
            (`OP_ADDI == op)       
        ) ? 1 : 0;
        
    assign o_regWrite = 
        (
            (`OP_LW == op) ||
            (`OP_ADD == op) ||
            (`OP_SUB == op) ||
            (`OP_OR == op) ||
            (`OP_ADDI == op)
        ) ? 1 : 0;
    
endmodule