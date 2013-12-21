module signExtend(i_data, o_data);
input   [15:0]  i_data;
output  [31:0]  o_data;

    assign o_data[31:0] = { {16{i_data[15]}}, i_data[15:0] };
    
endmodule