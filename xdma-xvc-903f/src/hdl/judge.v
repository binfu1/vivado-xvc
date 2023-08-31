`timescale 1ps/1ps

module judge (
  input         valid,
  input  [31:0] data1,
  input  [31:0] data2,
  output [31:0] data
);

  assign data = valid ? data1 : data2;

endmodule
