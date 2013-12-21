module shiftLeftBy2(i_data, o_data);
parameter WIDTH = 32;
input   [WIDTH-1:0]   i_data;
output  [WIDTH-1:0]   o_data;
 
    assign o_data[WIDTH-1:0] = i_data[WIDTH-1:0] << 2;
    
endmodule