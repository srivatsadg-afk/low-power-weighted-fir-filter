`timescale 1ns / 1ps

module fir_filter_retimed #(
      parameter DATA_WIDTH = 16,
      parameter COEFF_WIDTH = 16,
      parameter TAPS = 4
)(
      input  wire                              clk,
      input  wire                              rst_n,
  input  wire signed [DATA_WIDTH-1:0]      x_in,
  output reg  signed [DATA_WIDTH+COEFF_WIDTH:0] y_out
);

  // Filter Coefficients (Weighted Taps)
  localparam signed [COEFF_WIDTH-1:0] H0 = 16'sh0CCD; // 0.1
  localparam signed [COEFF_WIDTH-1:0] H1 = 16'sh199A; // 0.2
  localparam signed [COEFF_WIDTH-1:0] H2 = 16'sh2666; // 0.3
  localparam signed [COEFF_WIDTH-1:0] H3 = 16'sh3333; // 0.4

      // Retimed Pipeline Registers
  reg signed [DATA_WIDTH-1:0] x_reg0, x_reg1, x_reg2;
  reg signed [DATA_WIDTH+COEFF_WIDTH-1:0] m0_reg, m1_reg, m2_reg, m3_reg;
  reg signed [DATA_WIDTH+COEFF_WIDTH:0]   add_stage1_reg, add_stage2_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
                  x_reg0         <= 'd0;
                  x_reg1         <= 'd0;
                  x_reg2         <= 'd0;
                  m0_reg         <= 'd0;
                  m1_reg         <= 'd0;
                  m2_reg         <= 'd0;
                  m3_reg         <= 'd0;
                  add_stage1_reg <= 'd0;
                  add_stage2_reg <= 'd0;
                  y_out          <= 'd0;
    end else begin
                  x_reg0 <= x_in;
                  x_reg1 <= x_reg0;
                  x_reg2 <= x_reg1;

                  m0_reg <= x_in   * H0;
                  m1_reg <= x_reg0 * H1;
                  m2_reg <= x_reg1 * H2;
                  m3_reg <= x_reg2 * H3;

                  add_stage1_reg <= m0_reg + m1_reg;
                  add_stage2_reg <= m2_reg + m3_reg;

                  y_out <= add_stage1_reg + add_stage2_reg;
    end
  end

endmodule
