/********
seqDetect.sv

Written by Jimmy Bates (A01035957)

ELEX 7660-Digital System Design
Assignment 2

Date created: February 12, 2022

Bit shifts a bit in and checks to see if last 3 bits match input seq

code for modelsim:
vsim work.seqDetect_tb; add wave sim:*; run -all

*********/

module seqDetect #(parameter N=6) (
        output logic valid,
        input logic [N-1:0] seq,
        input logic clk, reset_n, a
        );

    logic [N-1:0] lastNbits, lastNbits_next; //for storing last 3 bits
    logic [N-1:0] bitCheck; //for checking seq with last bits

    always_comb begin : bitshift
        //Bit shift the lastNbits by 1 to the left
        lastNbits_next = lastNbits << 1;
        
        //Assign LSB of lastNbits to a
        lastNbits_next[0] = a;

        //Valid must be all bits ANDED - lastNbits XNOR'd w seq
        valid = &(lastNbits ~^ seq);
    end : bitshift

    always_ff @(posedge clk, negedge reset_n) begin : clkff
        //Take next value on clk unless reset
        if(~reset_n) 
            lastNbits <= 'b000;
        else
            lastNbits <= lastNbits_next;
    end : clkff

endmodule