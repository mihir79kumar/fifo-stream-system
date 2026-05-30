`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2026 00:21:41
// Design Name: 
// Module Name: mod_b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mod_b( clk,rst, data_in,rd_en, data_out );
input clk,rst ;
input [7:0]data_in;
output reg rd_en;
output reg [7:0] data_out;

parameter idle=2'b00;
parameter s1= 2'b01;
parameter data_phase=2'b10;

reg [1:0]ps,ns;

//present state logic

always @(posedge clk or posedge rst)
    begin
    if (rst)
        ps<=idle;
    else 
        ps<=ns;
    end
    
// next state logic

always @(*)
    begin 
        case(ps)
            idle: begin 
                ns=s1;
                rd_en=0;
                end
            s1: begin
                ns=data_phase;
                rd_en=0;
                end
           data_phase:
           begin
            ns=idle;
            rd_en=1;
           end
        endcase

end

always @(posedge clk or posedge rst) begin
        if (rst)
            data_out <= 8'b0;
        else if (rd_en)
            data_out <= data_in;
    end
endmodule
