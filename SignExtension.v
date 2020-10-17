`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    always @ (in)
    begin
    	if(in[15] == 0) begin
    		out[15:0] <= in;
    		out[31:16] <= 0;
    		end
    	else begin
    		out[15:0] <= in;
    		out[31:16] <= 1;
    		end
    end

endmodule
