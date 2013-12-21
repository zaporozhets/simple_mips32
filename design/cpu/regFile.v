
module regFile(i_clk, 
               i_raddr1, 
               i_raddr2, 
               i_waddr, 
               i_wdata, 
               i_we,
               o_rdata1,
               o_rdata2 
               );
               
input           i_clk, i_we;
input   [4:0]   i_raddr1, i_raddr2, i_waddr;
input   [31:0]  i_wdata;           
output  [31:0]  o_rdata1, o_rdata2;


    reg [31:0] mem [0:31];  // 32-bit memory with 32 entries

    reg [31:0] _data1, _data2;

    integer i = 0;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] = 0;
        end
    end
    
    always @(*) begin
        if (i_raddr1 == 5'd0)
                _data1 = 32'd0;
        else if ((i_raddr1 == i_waddr) && i_we)
                _data1 = i_wdata;
        else
                _data1 = mem[i_raddr1][31:0];
    end

    always @(*) begin
        if (i_raddr2 == 5'd0)
                _data2 = 32'd0;
        else if ((i_raddr2 == i_waddr) && i_we)
                _data2 = i_wdata;
        else
                _data2 = mem[i_raddr2][31:0];
    end

    assign o_rdata1 = _data1;
    assign o_rdata2 = _data2;

    always @(posedge i_clk) begin
        if (i_we && i_waddr != 5'd0) begin
                // write a non $zero register
                mem[i_waddr] <= i_wdata;
        end
    end
        
endmodule