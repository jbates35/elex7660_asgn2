/********
vendingMachine.sv

Written by Jimmy Bates (A01035957)

ELEX 7660-Digital System Design
Assignment 2

Date created: February 12, 2022

Vending machine - counts up to 100.

code for modelsim:
vsim work.vendingMachine_tb; add wave sim:*; run -all

*********/

module vendingMachine (
    output logic valid,
    input logic nickel, dime, quarter,
    input logic clk, reset_n
);

    logic [6:0] change; //To make code easier, store change in intermediate var.
    logic [8:0] total, total_next; //Logic that stores total amount

    always_comb begin : vendinglogic
        //Store change in intermediate variable
        change = nickel*5 + dime*10 + quarter*25;

        //Increase total by coins unless total is over 100 (then reset)
        total_next = (total>=100) ? total + change : change;

        //Valid if there is more than 100 cents in the vending machine
        valid = (total >= 100);
    end : vendinglogic

    always_ff @(posedge clk, negedge reset_n) begin : clkff
        //Store next value of total, unless reset to 0
        if(~reset_n)
            total <= 0;
        else   
            total <= total_next;
    end : clkff

endmodule