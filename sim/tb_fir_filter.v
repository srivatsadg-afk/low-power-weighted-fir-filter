`timescale 1ns / 1ps

module tb_fir_filter;

      parameter DATA_WIDTH = 16;
      parameter COEFF_WIDTH = 16;
      parameter TAPS = 4;

      reg clk;
      reg rst_n;
  reg signed [DATA_WIDTH-1:0] x_in;
  wire signed [DATA_WIDTH+COEFF_WIDTH:0] y_out;

  fir_filter_retimed #(
    .DATA_WIDTH(DATA_WIDTH),
    .COEFF_WIDTH(COEFF_WIDTH),
    .TAPS(TAPS)
  ) uut (
    .clk(clk),
    .rst_n(rst_n),
    .x_in(x_in),
    .y_out(y_out)
  );

      initial begin
                clk = 0;
                forever #5 clk = ~clk;
      end

      initial begin
                rst_n = 0;
                x_in = 0;
                #20;
                rst_n = 1;
                #10;

                // Apply impulse test
                x_in = 16'sh7FFF;
                #10;
                x_in = 0;
                #50;

                // Step input test
                x_in = 16'sh1000;
                #100;

                $finish;
      end

endmodule
