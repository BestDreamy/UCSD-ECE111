module fibonacci (input logic clk, rst_n,
                  input logic [4:0] input_s, // find the (input_s)'th number in fibonacci list
                  input logic begin_fibo, // start to calculate the fibonacci
                 output logic [15:0] fibo_out,
                 output logic done);
    function automatic void swap(ref logic [15:0] x, ref logic [15:0] y);
        int mid = x;
        x = y;
        y = mid;
    endfunction

    typedef enum {IDLE, LOAD, RUN} state_t;
    state_t state, next;

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
                if (begin_fibo) next = LOAD;
            LOAD:
                next = RUN;
            RUN:
                if (count) begin
                    count = count - 1;
                    f0 = f0 + f1;
                    swap(f0, f1);
                end else begin
                    next = IDLE;
                end
            default:
                next = IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (~ rst_n) begin
            count <= 0;
            f0 <= 0;
            f1 <= 0;
        end else if (state == LOAD) begin
            count <= fibo_out;
            f0 <= 0;
            f1 <= 1;
        end else if (state == RUN && next == IDLE) begin
            done <= 1;
            fibo_out <= f1;
        end
    end
endmodule
