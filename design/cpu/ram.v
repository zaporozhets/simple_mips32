`include "MIPS_Parameters.vh"

module ram(i_clk, i_addr, i_data, i_we, o_data);

input                     i_clk, i_we;
input   [`RAM_ADDR_WIDTH-1:0]  i_addr;
input   [`RAM_DATA_WIDTH-1:0]  i_data;
output  [`RAM_DATA_WIDTH-1:0]  o_data;

  
    //For single port: inout [DATA_WIDTH-1:0]  data;

    //--------------Internal variables---------------- 
    reg [`RAM_DATA_WIDTH-1:0] data_out ;
    reg [`RAM_DATA_WIDTH-1:0] mem [0:`RAM_DEPTH-1];

    integer i = 0;
    initial begin
        for (i = 0; i < `RAM_DEPTH; i = i + 1) begin
            mem[i] = 0;
        end
    end
    
    // Tri-State Buffer control 
    //For single port: assign data = (!i_we) ? data_out : 8'bz; 
    assign o_data = data_out;
    
    // Memory Write Block 
    always @ (posedge i_clk) begin
        if ( i_we ) begin
            //For single port: mem[i_addr] = data;
            mem[i_addr] = i_data;
        end
    end

    // Memory Read Block 
    always @ (posedge i_clk) begin
        if ( !i_we ) begin
            //For single port: data_out = mem[i_addr];
            data_out = mem[i_addr];
        end
    end

endmodule