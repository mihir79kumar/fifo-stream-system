`timescale 1ns / 1ps


module mod_a(clk,rst,wr_en, data_in,data_out);
input clk,rst;
output reg wr_en;
input [7:0]data_in;
output reg [7:0]data_out;

always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
        data_out<= 0;
        wr_en<=0;
        end
        else 
        begin
        data_out<=data_in;
        wr_en<=1;
        end
    end
endmodule
