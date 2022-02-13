/********
vendingMachine_tb.sv

Written by Jimmy Bates (A01035957)

ELEX 7660-Digital System Design
Assignment 2

Date created: February 12, 2022

Testbench for vendingMachine. Counts up to 100 and then gives a green light 
One scenario that needs tested is if we are at 95 cents and a nickel
quarter and dime gets put in.


code for modelsim:
vsim work.vendingMachine_tb; add wave sim:*; run -all

*********/

module vendingMachine_tb;

    //All input logic
    logic valid,
    logic nickel, dime, quarter,
    logic clk, reset_n

    //Import assignments to logic
    vendingMachine uut (.*);

    //Reset

    //Count up to 8, checking an input of each combination. 

    //Reset

    //Count up to 95
    //Now add a nickel, dime and quarter at same time
    //Should have 0 now, stop

endmodule