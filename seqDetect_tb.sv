/********
seqDetect_tb.sv

Written by Jimmy Bates (A01035957)

ELEX 7660-Digital System Design
Assignment 2

Date created: February 12, 2022

Test bench for sequence detector

code for modelsim:
vsim work.seqDetect_tb; add wave -r sim:/seqDetect_tb/*; run -all

*********/

`define INPUT1  'b01101011
`define SEQ1    'b011

`define INPUT2  'b11111011
`define SEQ2    'b111

`define M 3

module seqDetect_tb;

    //All input logic
    logic valid;
    logic [`M-1:0] seq; //Store sequence to test against input sequence
    logic clk, reset_n, a;
    logic [7:0] inputSequence; // Store bit word to pass through a

    //Instantiate module and import to assignments
    seqDetect #(.N(`M)) uut (.*);

    initial begin

        //Init clock
        clk = '0;

        //Reset
        reset_n = '0;
        @(posedge clk);
        reset_n = '1;
        @(posedge clk);

        //Round 1
        inputSequence = `INPUT1; //Store some set of bits in a 8 bit word
        seq = `SEQ1; //Setup correct seq

        a = 1'bx; // Indeterminate while sequence is off

        //For loop that runs through each bit
        for (int i = 0; i<8; i++) begin : for_seq
            a = inputSequence[i];   //Shove the bit in!
            @(posedge clk);         //Cycle
        end : for_seq

        a = 1'bx; // Indeterminate while sequence is off

        //Run clock 3 more times to clear sequence
        repeat(3) @(posedge clk);

        //Reset
        reset_n = '0;
        @(posedge clk);
        reset_n = '1;
        @(posedge clk);

        //Round 2
        inputSequence = `INPUT2; //Store some set of bits in a 8 bit word
        seq = `SEQ2;             //Setup correct seq

        a = 1'bx; // Indeterminate while sequence is off
        
        //For loop that runs through each bit
        for (int i = 0; i<8; i++) begin : for_seq
            a = inputSequence[i];   //Shove the bit in!
            @(posedge clk);         //Cycle
        end : for_seq

        a = 1'bx; // Indeterminate while sequence is off

        //Run clock 3 more times to clear sequence
        repeat(3) @(posedge clk);

        //Stop
        $stop ;
    
    end

    //Clock at 2MHz
    always
        #500ns clk = ~clk ;

endmodule