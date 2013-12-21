`include "MIPS_Parameters.vh"

module rom
(
	input [(`ROM_ADDR_WIDTH-1):0] i_addr,
	output [(`ROM_DATA_WIDTH-1):0] o_data
);
    
    reg [`ROM_DATA_WIDTH-1:0] mem [0:`ROM_DEPTH-1];
    
    integer fd = 0, i = 0;
    initial begin
        fd = $fopen("/home/taras/Documents/KPI/mips/tests/mips1.hex","r"); 
        while ( ! $feof(fd)) begin
            $fscanf(fd, "%x", mem[i]);
            i = i + 1;
        end
        $fclose(fd);
    end

    assign o_data = mem[i_addr>>2];
    
endmodule
