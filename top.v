`timescale 1ns / 1ps

module top( 
    input clk, rst,
    input [7:0] data_top,
    output [7:0] data_out_top
);

    // Interconnect Routing Wires
    wire [7:0] data_out_temp;  // From mod1 to FIFO
    wire [7:0] data_fifo_to_b; // From FIFO to mod2 (CRITICAL FIX)
    wire wr_en, rd_en;
    wire full, empty;

    // Instantiate Module A
    mod_a mod1 (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en), 
        .data_in(data_top),
        .data_out(data_out_temp)
    );

    // Instantiate FIFO Buffer
    fifo_8x8 fifo (
        .clk(clk), 
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en), 
        .data_in(data_out_temp), 
        .data_out(data_fifo_to_b), // Fixed: Routed to the shared interconnect wire
        .full(full), 
        .empty(empty)
    );

    // Instantiate Module B
    mod_b mod2 (
        .clk(clk),
        .rst(rst), 
        .data_in(data_fifo_to_b), // Fixed: Reads directly from the FIFO interconnect wire
        .rd_en(rd_en), 
        .data_out(data_out_top)
    );

endmodule