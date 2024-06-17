`timescale 1ns / 1ps
`include "fibonacci.sv"
module tb_fibonacci;

logic clk, rst_n;
logic [4:0] input_s;
logic begin_fibo;

always #(2) begin
    clk = ~clk;
end

initial begin
    clk = 0;
    rst_n = 0;
    begin_fibo = 0;
    # 5
    rst_n = 1;
    begin_fibo = 1;
    input_s = 10;
    input_s = 10;
    #500 $finish;
end

logic [15:0] fibo_out;
logic done;

fibonacci fibonacci_ins(clk, rst_n,
                        input_s,
                        begin_fibo,
                        fibo_out,
                        done);


initial begin
    $dumpfile("sim.vcd");
    $dumpvars;
end
endmodule
