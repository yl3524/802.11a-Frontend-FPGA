`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2022 02:23:34 AM
// Design Name: 
// Module Name: mapTable
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mapTable(
    // Input ports
    input logic                en,
    input logic          [5:0] data_in,
    // Output ports
    output logic signed [12:0] q, // Imaginary part
    output logic signed [12:0] i, // Real part
    // Control signal
    input logic          [2:0] bpsc,
    input logic                is_zero,
    input logic                is_pilot,
    input logic                pilot_indicator
    );
    
    logic [25:0] out;
    assign out = {q,i};
    
    always_comb begin
        if ( en && is_zero ) begin
            out = {13'd0, 13'd0};
        end
        else if ( en && is_pilot ) begin
            if ( pilot_indicator ) out = {13'd0, 13'd2048};
            else out = {13'd0, -13'd2048};
        end 
        else if (en && bpsc == 3'd1) begin // BPSK (+-1)
            case(data_in)
                //                Q      I
//                6'b000000: out = {12'd0, -12'd1};
//                6'd000001: out = {12'd0,  12'd1};

                6'b000000: out = {13'd0, -13'd2048};
                6'b000001: out = {13'd0,  13'd2048};
            endcase
        end
        
        else if (en && bpsc == 3'd2) begin // QPSK (+-0.7071)
            case(data_in)
                //                  Q      I
//                6'b0000_01: out = { 4'd1, -4'd1};
//                6'b0000_00: out = {-4'd1, -4'd1};
                
//                6'b0000_11: out = { 4'd1,  4'd1};
//                6'b0000_10: out = {-4'd1,  4'd1};

                6'b0000_01: out = { 13'd1448, -13'd1448};
                6'b0000_00: out = {-13'd1448, -13'd1448};
                
                6'b0000_11: out = { 13'd1448,  13'd1448};
                6'b0000_10: out = {-13'd1448,  13'd1448};
            endcase
        end
        else if (en && bpsc == 3'd4) begin // QAM 16 (+-0.3162, +-0.9487)
            case(data_in)
                //                  Q      I
//                6'b00_0010: out = { 4'd3, -4'd3};
//                6'b00_0011: out = { 4'd1, -4'd3};
//                6'b00_0001: out = {-4'd1, -4'd3};
//                6'b00_0000: out = {-4'd3, -4'd3};
                
//                6'b00_0110: out = { 4'd3, -4'd1};
//                6'b00_0111: out = { 4'd1, -4'd1};
//                6'b00_0101: out = {-4'd1, -4'd1};
//                6'b00_0100: out = {-4'd3, -4'd1};
                
//                6'b00_1110: out = { 4'd3,  4'd1};
//                6'b00_1111: out = { 4'd1,  4'd1};
//                6'b00_1101: out = {-4'd1,  4'd1};
//                6'b00_1100: out = {-4'd3,  4'd1};
                
//                6'b00_1010: out = { 4'd3,  4'd3};
//                6'b00_1011: out = { 4'd1,  4'd3};
//                6'b00_1001: out = {-4'd1,  4'd3};
//                6'b00_1000: out = {-4'd3,  4'd3};

                6'b00_0010: out = { 13'd1943, -13'd1943};
                6'b00_0011: out = { 13'd648,  -13'd1943};
                6'b00_0001: out = {-13'd648,  -13'd1943};
                6'b00_0000: out = {-13'd1943, -13'd1943};

                6'b00_0110: out = { 13'd1943, -13'd648};
                6'b00_0111: out = { 13'd648,  -13'd648};
                6'b00_0101: out = {-13'd648,  -13'd648};
                6'b00_0100: out = {-13'd1943, -13'd648};

                6'b00_1110: out = { 13'd1943,  13'd648};
                6'b00_1111: out = { 13'd648,   13'd648};
                6'b00_1101: out = {-13'd648,   13'd648};
                6'b00_1100: out = {-13'd1943,  13'd648};

                6'b00_1010: out = { 13'd1943,  13'd1943};
                6'b00_1011: out = { 13'd648,   13'd1943};
                6'b00_1001: out = {-13'd648,   13'd1943};
                6'b00_1000: out = {-13'd1943,  13'd1943};
            endcase
        end
        
        else if (en && bpsc == 2'd6) begin // QAM 64 (+-0.1543, +-0.4629, +-0.7715, +-1.0801)
            case(data_in)
                //                  Q      I
//                6'b000_100: out = { 4'd7, -4'd7};
//                6'b000_101: out = { 4'd5, -4'd7};
//                6'b000_111: out = { 4'd3, -4'd7};
//                6'b000_110: out = { 4'd1, -4'd7};
//                6'b000_010: out = {-4'd1, -4'd7};
//                6'b000_011: out = {-4'd3, -4'd7};
//                6'b000_001: out = {-4'd5, -4'd7};
//                6'b000_000: out = {-4'd7, -4'd7};
                
//                6'b001_100: out = { 4'd7, -4'd5};
//                6'b001_101: out = { 4'd5, -4'd5};
//                6'b001_111: out = { 4'd3, -4'd5};
//                6'b001_110: out = { 4'd1, -4'd5};
//                6'b001_010: out = {-4'd1, -4'd5};
//                6'b001_011: out = {-4'd3, -4'd5};
//                6'b001_001: out = {-4'd5, -4'd5};
//                6'b001_000: out = {-4'd7, -4'd5};
                
//                6'b011_100: out = { 4'd7, -4'd3};
//                6'b011_101: out = { 4'd5, -4'd3};
//                6'b011_111: out = { 4'd3, -4'd3};
//                6'b011_110: out = { 4'd1, -4'd3};
//                6'b011_010: out = {-4'd1, -4'd3};
//                6'b011_011: out = {-4'd3, -4'd3};
//                6'b011_001: out = {-4'd5, -4'd3};
//                6'b011_000: out = {-4'd7, -4'd3};
                
//                6'b010_100: out = { 4'd7, -4'd1};
//                6'b010_101: out = { 4'd5, -4'd1};
//                6'b010_111: out = { 4'd3, -4'd1};
//                6'b010_110: out = { 4'd1, -4'd1};
//                6'b010_010: out = {-4'd1, -4'd1};
//                6'b010_011: out = {-4'd3, -4'd1};
//                6'b010_001: out = {-4'd5, -4'd1};
//                6'b010_000: out = {-4'd7, -4'd1};
                
//                6'b110_100: out = { 4'd7,  4'd1};
//                6'b110_101: out = { 4'd5,  4'd1};
//                6'b110_111: out = { 4'd3,  4'd1};
//                6'b110_110: out = { 4'd1,  4'd1};
//                6'b110_010: out = {-4'd1,  4'd1};
//                6'b110_011: out = {-4'd3,  4'd1};
//                6'b110_001: out = {-4'd5,  4'd1};
//                6'b110_000: out = {-4'd7,  4'd1};
                
//                6'b111_100: out = { 4'd7,  4'd3};
//                6'b111_101: out = { 4'd5,  4'd3};
//                6'b111_111: out = { 4'd3,  4'd3};
//                6'b111_110: out = { 4'd1,  4'd3};
//                6'b111_010: out = {-4'd1,  4'd3};
//                6'b111_011: out = {-4'd3,  4'd3};
//                6'b111_001: out = {-4'd5,  4'd3};
//                6'b111_000: out = {-4'd7,  4'd3};
                
//                6'b101_100: out = { 4'd7,  4'd5};
//                6'b101_101: out = { 4'd5,  4'd5};
//                6'b101_111: out = { 4'd3,  4'd5};
//                6'b101_110: out = { 4'd1,  4'd5};
//                6'b101_010: out = {-4'd1,  4'd5};
//                6'b101_011: out = {-4'd3,  4'd5};
//                6'b101_001: out = {-4'd5,  4'd5};
//                6'b101_000: out = {-4'd7,  4'd5};
                
//                6'b100_100: out = { 4'd7,  4'd7};
//                6'b100_101: out = { 4'd5,  4'd7};
//                6'b100_111: out = { 4'd3,  4'd7};
//                6'b100_110: out = { 4'd1,  4'd7};
//                6'b100_010: out = {-4'd1,  4'd7};
//                6'b100_011: out = {-4'd3,  4'd7};
//                6'b100_001: out = {-4'd5,  4'd7};
//                6'b100_000: out = {-4'd7,  4'd7};

                6'b000_100: out = { 13'd2212, -13'd2212};
                6'b000_101: out = { 13'd1580, -13'd2212};
                6'b000_111: out = { 13'd948,  -13'd2212};
                6'b000_110: out = { 13'd316,  -13'd2212};
                6'b000_010: out = {-13'd316,  -13'd2212};
                6'b000_011: out = {-13'd948,  -13'd2212};
                6'b000_001: out = {-13'd1580, -13'd2212};
                6'b000_000: out = {-13'd2212, -13'd2212};
                
                6'b001_100: out = { 13'd2212, -13'd1580};
                6'b001_101: out = { 13'd1580, -13'd1580};
                6'b001_111: out = { 13'd948,  -13'd1580};
                6'b001_110: out = { 13'd316,  -13'd1580};
                6'b001_010: out = {-13'd316,  -13'd1580};
                6'b001_011: out = {-13'd948,  -13'd1580};
                6'b001_001: out = {-13'd1580, -13'd1580};
                6'b001_000: out = {-13'd2212, -13'd1580};
                
                6'b011_100: out = { 13'd2212, -13'd948};
                6'b011_101: out = { 13'd1580, -13'd948};
                6'b011_111: out = { 13'd948,  -13'd948};
                6'b011_110: out = { 13'd316,  -13'd948};
                6'b011_010: out = {-13'd316,  -13'd948};
                6'b011_011: out = {-13'd948,  -13'd948};
                6'b011_001: out = {-13'd1580, -13'd948};
                6'b011_000: out = {-13'd2212, -13'd948};
                
                6'b010_100: out = { 13'd2212, -13'd316};
                6'b010_101: out = { 13'd1580, -13'd316};
                6'b010_111: out = { 13'd948,  -13'd316};
                6'b010_110: out = { 13'd316,  -13'd316};
                6'b010_010: out = {-13'd316,  -13'd316};
                6'b010_011: out = {-13'd948,  -13'd316};
                6'b010_001: out = {-13'd1580, -13'd316};
                6'b010_000: out = {-13'd2212, -13'd316};
                
                6'b110_100: out = { 13'd2212,  13'd316};
                6'b110_101: out = { 13'd1580,  13'd316};
                6'b110_111: out = { 13'd948,   13'd316};
                6'b110_110: out = { 13'd316,   13'd316};
                6'b110_010: out = {-13'd316,   13'd316};
                6'b110_011: out = {-13'd948,   13'd316};
                6'b110_001: out = {-13'd1580,  13'd316};
                6'b110_000: out = {-13'd2212,  13'd316};
                
                6'b111_100: out = { 13'd2212,  13'd948};
                6'b111_101: out = { 13'd1580,  13'd948};
                6'b111_111: out = { 13'd948,   13'd948};
                6'b111_110: out = { 13'd316,   13'd948};
                6'b111_010: out = {-13'd316,   13'd948};
                6'b111_011: out = {-13'd948,   13'd948};
                6'b111_001: out = {-13'd1580,  13'd948};
                6'b111_000: out = {-13'd2212,  13'd948};
                
                6'b101_100: out = { 13'd2212,  13'd1580};
                6'b101_101: out = { 13'd1580,  13'd1580};
                6'b101_111: out = { 13'd948,   13'd1580};
                6'b101_110: out = { 13'd316,   13'd1580};
                6'b101_010: out = {-13'd316,   13'd1580};
                6'b101_011: out = {-13'd948,   13'd1580};
                6'b101_001: out = {-13'd1580,  13'd1580};
                6'b101_000: out = {-13'd2212,  13'd1580};
                
                6'b100_100: out = { 13'd2212,  13'd2212};
                6'b100_101: out = { 13'd1580,  13'd2212};
                6'b100_111: out = { 13'd948,   13'd2212};
                6'b100_110: out = { 13'd316,   13'd2212};
                6'b100_010: out = {-13'd316,   13'd2212};
                6'b100_011: out = {-13'd948,   13'd2212};
                6'b100_001: out = {-13'd1580,  13'd2212};
                6'b100_000: out = {-13'd2212,  13'd2212};
                
            endcase
        end
    end
endmodule