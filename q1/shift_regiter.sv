module shift_register #(parameter N=4)
                      (input logic clk,
                       input logic rst_n,
                       input logic serial_parallel,
                       input logic load_enable,
                       input logic serial_in,
                       input logic [N-1:0] parallel_in,
                       output logic [N-1:0] parallel_out,
                       output logic serial_out);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            parallel_out <= N'd0;
        else if (load_enable)
            parallel_out <= serial_parallel ? parallel_in : {serial_in, parallel_out[N-1:1]};
    end

    assign serial_out = parallel_out[0];

endmodule
