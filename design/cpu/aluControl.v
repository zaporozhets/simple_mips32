`include "MIPS_Parameters.vh"

module aluControl(i_aluOp, i_func, o_aluControl);
 
input       [1:0]   i_aluOp;
input       [5:0]   i_func;
output  reg [3:0]   o_aluControl;
  
    reg [3:0] _funct = 4'd0;

/*
R-type	10	add         100000	add	                010
R-type	10	subtract	100010	subtract	        110
R-type	10	AND         100100	and	                000
R-type	10	OR          100101	or                  001
R-type	10	SLT         101010	set on less than	111
*/
    always @(*) begin
        case(i_func[3:0])
            4'b0000:  _funct = `ALU_ADD;
            4'b0010:  _funct = `ALU_SUB;
            4'b0100:  _funct = `ALU_AND;
            4'b0101:  _funct = `ALU_OR;
            4'b1010:  _funct = `ALU_SOLT;
            default: _funct = 4'd0;
        endcase
    end

/*
    00      Addition (for load and store)
    01      Subtraction (for beq)
    10      Determined by funct field (R-type instruction)
    11      Not used
*/
    always @(*) begin
        case(i_aluOp)
            `ALU_OP_ADD: o_aluControl = `ALU_ADD;
            `ALU_OP_SUB: o_aluControl = `ALU_SUB;
            `ALU_OP_FUNC: o_aluControl = _funct;
            `ALU_OP_NOP: o_aluControl = `ALU_ADD;
            default: o_aluControl = 0;
        endcase
    end
    
endmodule