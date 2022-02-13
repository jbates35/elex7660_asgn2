/********
seqDetect.sv

Written by Jimmy Bates (A01035957)

ELEX 7660-Digital System Design
Assignment 2

Date created: February 12, 2022

Bit shifts a bit in and checks to see if last 3 bits match input seq

code for modelsim:
vsim work.seqDetect_tb; add wave -r sim:/seqDetect_tb/*; run -all

*********/

module seqDetect #(parameter N=6) (
        output logic valid,
        input logic [N-1:0] seq,
        input logic clk, reset_n, a
        );

    logic [N-1:0] lastNbits, lastNbits_next; //for storing last 3 bits
    logic [N-1:0] counter, counter_next; //Hold when MSB is 1

    always_comb begin : bitshift
        //Bit shift the lastNbits by 1 to the left and concacenate with a
        lastNbits_next = { lastNbits[N-2:0], a };
        
        //Take next counter so it can hold when all bits are valid
        counter_next = { counter[N-2:0], 'b1 };

        //Valid must be all bits ANDED - lastNbits XNOR'd w seq
        valid = 0;
        if(&counter & &(lastNbits ~^ seq)) valid = 1;
    end : bitshift

    always_ff @(posedge clk, negedge reset_n) begin : clkff
        //Take next value on clk unless reset
        if(~reset_n) begin
            lastNbits <= 0;
            counter <= 0;
        end else begin
            lastNbits <= lastNbits_next;
            counter <= counter_next;
        end
    end : clkff

endmodule