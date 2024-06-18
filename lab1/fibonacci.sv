module fibonacci (input logic clk, rst_n,
                  input logic[4:0] input_s, // find the (input_s)'th number in fibonacci list
                  input logic begin_fibo, // start to calculate the fibonacci
                 output logic[15:0] fibo_out,
                 output logic done);
    function automatic void swap(ref logic[15:0] x, ref logic[15:0] y);
        logic[15:0] mid = x;
        x = y;
        y = mid;
    endfunction

    typedef enum {IDLE, LOAD, RUN} state_e;
    state_e state, next;

    logic[4:0] count;
    logic[15:0] f0, f1;
    always_ff @(posedge clk) begin
        if (~ rst_n) begin
            state <= IDLE;
            done <= 0;
            fibo_out <= 0;
        end else begin
            state <= next;
        end
    end

    always_ff @(posedge clk) begin
        case (state)
            IDLE:
                if (begin_fibo) begin
                    next <= LOAD;
                    count <= input_s;
                    f0 <= 0;
                    f1 <= 1;
                end
            RUN:
                if (count != 5'b0) begin
                    count <= count - 1;
                    f1 <= f0 + f1;
                    f0 <= f1;
                end else begin
                    next <= IDLE;
                end
            default:
                next <= IDLE;
        endcase
    end
endmodule
