/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module autotest_5 (
    input clk,
    input rst,
    input mode_switch,
    output reg [15:0] out,
    output reg [23:0] leds
  );
  
  
  
  reg autotest_reset;
  
  reg [25:0] M_counter_d, M_counter_q = 1'h0;
  
  reg [23:0] M_led_d, M_led_q = 1'h0;
  
  wire [16-1:0] M_alu_out;
  wire [1-1:0] M_alu_z;
  wire [1-1:0] M_alu_v;
  wire [1-1:0] M_alu_n;
  wire [1-1:0] M_alu_overflow;
  reg [16-1:0] M_alu_a;
  reg [16-1:0] M_alu_b;
  reg [6-1:0] M_alu_alufn;
  alu_3 alu (
    .a(M_alu_a),
    .b(M_alu_b),
    .alufn(M_alu_alufn),
    .out(M_alu_out),
    .z(M_alu_z),
    .v(M_alu_v),
    .n(M_alu_n),
    .overflow(M_alu_overflow)
  );
  
  wire [1-1:0] M_testButton_out;
  edge_detector_16 testButton (
    .clk(clk),
    .in(mode_switch),
    .out(M_testButton_out)
  );
  
  localparam BEGIN_state = 5'd0;
  localparam ADD_state = 5'd1;
  localparam ADD_OVER_state = 5'd2;
  localparam SUB_state = 5'd3;
  localparam SUB_OVER_state = 5'd4;
  localparam AND_state = 5'd5;
  localparam NAND_state = 5'd6;
  localparam OR_state = 5'd7;
  localparam NOR_state = 5'd8;
  localparam XOR_state = 5'd9;
  localparam XNOR_state = 5'd10;
  localparam A_state = 5'd11;
  localparam SHL_state = 5'd12;
  localparam SHR_state = 5'd13;
  localparam SRA_state = 5'd14;
  localparam CMPEQ_state = 5'd15;
  localparam CMPLT_state = 5'd16;
  localparam CMPLE_state = 5'd17;
  localparam MULTIPLY_state = 5'd18;
  localparam MOD_state = 5'd19;
  localparam PASS_state = 5'd20;
  localparam FAIL_state = 5'd21;
  
  reg [4:0] M_state_d, M_state_q = BEGIN_state;
  
  always @* begin
    M_state_d = M_state_q;
    M_led_d = M_led_q;
    M_counter_d = M_counter_q;
    
    autotest_reset = M_testButton_out | rst;
    M_counter_d = M_counter_q + 1'h1;
    leds = M_led_q;
    leds[16+7+0-:1] = 1'h1;
    
    case (M_state_q)
      BEGIN_state: begin
        M_alu_alufn = 1'h0;
        out = 16'h0000;
        M_alu_a = 1'h0;
        M_alu_b = 1'h0;
        if (M_counter_q[25+0-:1]) begin
          M_state_d = ADD_state;
        end
      end
      ADD_state: begin
        M_alu_alufn = 6'h00;
        M_alu_a = 16'h0003;
        M_alu_b = 16'h0004;
        if (M_alu_out == 16'h0007) begin
          M_led_d[0+0+0-:1] = 1'h1;
          out = 16'h0001;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = ADD_OVER_state;
        end
      end
      ADD_OVER_state: begin
        M_alu_alufn = 6'h00;
        M_alu_a = 16'h4000;
        M_alu_b = 16'h4000;
        if (M_alu_overflow == 1'h1) begin
          M_led_d[0+1+0-:1] = 1'h1;
          out = 16'h0002;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = SUB_state;
        end
      end
      SUB_state: begin
        M_alu_alufn = 6'h01;
        M_alu_a = 16'h0004;
        M_alu_b = 16'h0003;
        if (M_alu_out == 16'h0001) begin
          M_led_d[0+2+0-:1] = 1'h1;
          out = 16'h0003;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = SUB_OVER_state;
        end
      end
      SUB_OVER_state: begin
        M_alu_alufn = 6'h01;
        M_alu_a = 16'hbfff;
        M_alu_b = 16'h4000;
        if (M_alu_out == 16'h7fff) begin
          M_led_d[0+3+0-:1] = 1'h1;
          out = 16'h0004;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = AND_state;
        end
      end
      AND_state: begin
        M_alu_alufn = 6'h18;
        M_alu_a = 16'h0001;
        M_alu_b = 16'h0001;
        if (M_alu_out == 16'h0001) begin
          M_led_d[0+4+0-:1] = 1'h1;
          out = 16'h0005;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = NAND_state;
        end
      end
      NAND_state: begin
        M_alu_alufn = 6'h17;
        M_alu_a = 16'h8000;
        M_alu_b = 16'h8003;
        if (M_alu_out == 16'h7fff) begin
          M_led_d[0+5+0-:1] = 1'h1;
          out = 16'h0006;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = OR_state;
        end
      end
      OR_state: begin
        M_alu_alufn = 6'h1e;
        M_alu_a = 16'h000a;
        M_alu_b = 16'h000f;
        if (M_alu_out == 16'h000f) begin
          M_led_d[0+6+0-:1] = 1'h1;
          out = 16'h0007;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = NOR_state;
        end
      end
      NOR_state: begin
        M_alu_alufn = 6'h11;
        M_alu_a = 16'h0003;
        M_alu_b = 16'h0005;
        if (M_alu_out == 16'hfff8) begin
          M_led_d[0+7+0-:1] = 1'h1;
          out = 16'h0008;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = XOR_state;
        end
      end
      XOR_state: begin
        M_alu_alufn = 6'h16;
        M_alu_a = 16'h000a;
        M_alu_b = 16'h000c;
        if (M_alu_out == 16'h0006) begin
          M_led_d[8+0+0-:1] = 1'h1;
          out = 16'h0009;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = XNOR_state;
        end
      end
      XNOR_state: begin
        M_alu_alufn = 6'h19;
        M_alu_a = 16'h000a;
        M_alu_b = 16'h000c;
        if (M_alu_out == 16'hfff9) begin
          M_led_d[8+1+0-:1] = 1'h1;
          out = 16'h0010;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = A_state;
        end
      end
      A_state: begin
        M_alu_alufn = 6'h1a;
        M_alu_a = 16'h000a;
        M_alu_b = 16'h000c;
        if (M_alu_out == 16'h000a) begin
          M_led_d[8+2+0-:1] = 1'h1;
          out = 16'h0011;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = CMPEQ_state;
        end
      end
      CMPEQ_state: begin
        M_alu_alufn = 6'h32;
        M_alu_a = 16'h000a;
        M_alu_b = 16'h000a;
        if (M_alu_out == 1'h1) begin
          M_led_d[8+3+0-:1] = 1'h1;
          out = 16'h0012;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = CMPLT_state;
        end
      end
      CMPLT_state: begin
        M_alu_alufn = 6'h34;
        M_alu_a = 16'h000a;
        M_alu_b = 16'h000a;
        if (M_alu_out == 1'h0) begin
          M_led_d[8+4+0-:1] = 1'h1;
          out = 16'h0013;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = CMPLE_state;
        end
      end
      CMPLE_state: begin
        M_alu_alufn = 6'h36;
        M_alu_a = 16'h000a;
        M_alu_b = 16'h000a;
        if (M_alu_out == 1'h1) begin
          M_led_d[8+5+0-:1] = 1'h1;
          out = 16'h0014;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = SHL_state;
        end
      end
      SHL_state: begin
        M_alu_alufn = 6'h20;
        M_alu_a = 16'h000a;
        M_alu_b = 16'h0003;
        if (M_alu_out == 16'h0050) begin
          M_led_d[8+6+0-:1] = 1'h1;
          out = 16'h0015;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = SHR_state;
        end
      end
      SHR_state: begin
        M_alu_alufn = 6'h21;
        M_alu_a = 16'h0050;
        M_alu_b = 16'h0003;
        if (M_alu_out == 16'h000a) begin
          M_led_d[8+7+0-:1] = 1'h1;
          out = 16'h0016;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = SRA_state;
        end
      end
      SRA_state: begin
        M_alu_alufn = 6'h23;
        M_alu_a = 16'h8008;
        M_alu_b = 16'h0003;
        if (M_alu_out == 16'hf001) begin
          M_led_d[16+0+0-:1] = 1'h1;
          out = 16'h0017;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = MULTIPLY_state;
        end
      end
      MULTIPLY_state: begin
        M_alu_alufn = 6'h02;
        M_alu_a = 16'h0004;
        M_alu_b = 16'h0003;
        if (M_alu_out == 16'h000c) begin
          M_led_d[16+1+0-:1] = 1'h1;
          out = 16'h0018;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = MOD_state;
        end
      end
      MOD_state: begin
        M_alu_alufn = 6'h03;
        M_alu_a = 16'h0004;
        M_alu_b = 16'h0003;
        if (M_alu_out == 16'h0001) begin
          M_led_d[16+2+0-:1] = 1'h1;
          out = 16'h0019;
        end else begin
          out = 16'hab1d;
          M_state_d = FAIL_state;
        end
        if (M_counter_q[25+0-:1]) begin
          M_state_d = PASS_state;
        end
      end
      PASS_state: begin
        out = 16'heb55;
        M_alu_a = 1'h0;
        M_alu_b = 1'h0;
        M_alu_alufn = 1'h0;
        if (autotest_reset == 1'h1) begin
          M_state_d = BEGIN_state;
        end
      end
      FAIL_state: begin
        out = 16'hab1d;
        M_alu_a = 1'h0;
        M_alu_b = 1'h0;
        M_alu_alufn = 1'h0;
        if (autotest_reset == 1'h1) begin
          M_state_d = BEGIN_state;
        end
      end
      default: begin
        M_state_d = BEGIN_state;
        out = 16'h0000;
        M_alu_a = 1'h0;
        M_alu_b = 1'h0;
        M_alu_alufn = 1'h0;
      end
    endcase
    if (M_counter_q[25+0-:1] == 1'h1) begin
      M_counter_d[25+0-:1] = 1'h0;
    end
  end
  
  always @(posedge clk) begin
    if (autotest_reset == 1'b1) begin
      M_led_q <= 1'h0;
    end else begin
      M_led_q <= M_led_d;
    end
  end
  
  
  always @(posedge clk) begin
    if (autotest_reset == 1'b1) begin
      M_state_q <= 1'h0;
    end else begin
      M_state_q <= M_state_d;
    end
  end
  
  
  always @(posedge clk) begin
    if (autotest_reset == 1'b1) begin
      M_counter_q <= 1'h0;
    end else begin
      M_counter_q <= M_counter_d;
    end
  end
  
endmodule
