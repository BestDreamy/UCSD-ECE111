module fibonacci (input logic clk, rst_n,
                  input logic [4:0] input_s, // find the (input_s)'th number in fibonacci list
                  input logic begin_fibo, // start to calculate the fibonacci
                 output logic [15:0] fibo_out,
                 output logic done
);
    enum localparam {IDLE = 1'b0, RUN = 1'b1} state, next;

    logic  [4:0] count;
    logic [15:0] f0, f1;
    always_ff @(posedge clk) begin
        if (~ rst_n) begin
            state <= IDLE;
            done <= 0;
            fibo_out <= 0;
        end else begin
            state <= next;
        end
    end

    always_comb begin
        case (state)
            IDLE:
                if (begin_fibo) next = RUN;
            RUN:
                
        endcase
    end
endmodule
