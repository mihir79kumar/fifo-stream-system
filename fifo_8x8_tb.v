`timescale 1ns / 1ps

module fifo_8x8(clk, rst, wr_en, rd_en, data_in, data_out, full, empty);
input clk, rst, wr_en, rd_en;
input [7:0] data_in;
output reg [7:0] data_out;
output full, empty;
integer i;

reg [7:0] memory[7:0];
reg [3:0] wr_ptr, rd_ptr;

always @(posedge clk or posedge rst) begin
    if (rst) begin 
        wr_ptr   <= 0;
        rd_ptr   <= 0;
        data_out <= 0;
        for(i = 0; i < 8; i = i + 1)
            memory[i] <= 0;
    end
    else begin
        
        if (wr_en && !full) begin
            memory[wr_ptr[2:0]] <= data_in;
            wr_ptr              <= wr_ptr + 1;
        end
        
      
        if (rd_en && !empty) begin
            data_out            <= memory[rd_ptr[2:0]];
            rd_ptr              <= rd_ptr + 1;
        end
    end
end
        
assign full  = (wr_ptr[2:0] == rd_ptr[2:0]) && (wr_ptr[3] != rd_ptr[3]);
assign empty = (wr_ptr == rd_ptr);

endmodule