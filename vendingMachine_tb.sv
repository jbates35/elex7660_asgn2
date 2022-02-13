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

    logic valid, nickel, dime, quarter, clk, reset_n;
    logic [2:0] coins; 

    //initialize module
    vendingMachine uut (.*);

    initial begin

        //initialize clock and starting coin values
        clk = '0;
        coins = 3'b000;

        //Reset first
        reset_n = 0;
        @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        //Test all combinations of coins
        //Make sure when vending machine is >100 the next cycle vending machine
        //doens't eat the coins
        for (int i = 0; i <= 7; i++) begin : coinfor
            coins = i;
            @(posedge clk); 
        end : coinfor
        
        coins = 'b000;
        repeat(2) @(posedge clk);

        //Reset again
        reset_n = 0;
        @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        //Now lets get coins to 95
        coins = 'h7;
        @(posedge clk);
        coins = 'h7;
        @(posedge clk);
        coins = 'h3;
        @(posedge clk);
        coins = 'h7;
        repeat(2) @(posedge clk);

        //Simulation done
        $stop;

    end

    always begin
        //Assign coins to the diff coins
        quarter = coins[2];
        dime = coins[1];
        nickel = coins[0];

        //clk
        #500ns clk = ~clk;
    end

endmodule