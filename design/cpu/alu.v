`include "MIPS_Parameters.vh"

module alu(i_op1, i_op2, i_control, o_result, o_zf);

input       [31:0]  i_op1, i_op2;
input       [3:0]   i_control;
output  reg [31:0]  o_result;
output              o_zf;
  
  
    wire [31:0] sub_ab;
    wire [31:0] add_ab;
    wire                 oflow_add;
    wire                 oflow_sub;
    wire                 oflow;
    wire                 slt;
    
    assign o_zf = (0 == o_result);

    assign sub_ab = i_op1 - i_op2;
    assign add_ab = i_op1 + i_op2;

    // overflow occurs (with 2's complement numbers) when
    // the operands have the same sign, but the sign of the result is
    // different.  The actual sign is the opposite of the result.
    // It is also dependent on wheter addition or subtraction is performed.
    assign oflow_add = (i_op1[31] == i_op2[31] && add_ab[31] != i_op1[31]) ? 1 : 0;
    assign oflow_sub = (i_op1[31] == i_op2[31] && sub_ab[31] != i_op1[31]) ? 1 : 0;

    assign oflow = (i_control == 4'b0010) ? oflow_add : oflow_sub;

    // set if less than, 2s compliment 32-bit numbers
    assign slt = oflow_sub ? ~(i_op1[31]) : i_op1[31];

    always @(  i_op1,  i_op2, i_control ) begin
        case (i_control)
            `ALU_ADD: o_result <= add_ab;                // a + b
            `ALU_AND: o_result <= i_op1 & i_op2;         // and
            `ALU_NOR: o_result <= ~(i_op1 | i_op2);      // nor
            `ALU_OR:  o_result <= i_op1 | i_op2;         // or
            `ALU_SOLT:o_result <= {{31{1'b0}}, slt};     // set if less than
            `ALU_SUB: o_result <= sub_ab;                // a - b
            //XOR: out <= i_op1 ^ i_op2;            // xor
            default: o_result <= 0;
        endcase
    end
endmodule