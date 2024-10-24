
// alu_decoder.v - logic for ALU decoder

/*module alu_decoder (
    input            opb5,
    input [2:0]      funct3,
    input            funct7b5,
    input [1:0]      ALUOp,
    output reg [2:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 3'b000;             // addition
        2'b01: ALUControl = 3'b001;             // subtraction
        default:
            case (funct3) // R-type or I-type ALU
                3'b000: begin
                    // True for R-type subtract
                    if   (funct7b5 & opb5) ALUControl = 3'b001; //sub
                    else ALUControl = 3'b000; // add, addi
                end
                3'b001:  ALUControl = 3'b100; //c sll,slli
                3'b010:  ALUControl = 3'b101; // slt, slti
                3'b011:  ALUControl = 3'b110; //c sltu,sltiu
                3'b100:  ALUControl = 3'b111; //c xor,xori
                3'b110:  ALUControl = 3'b011; // or, ori
                3'b111:  ALUControl = 3'b010; // and, andi
                default: ALUControl = 3'bxxx; // ???
            endcase
    endcase
end

endmodule*/

// alu_decoder.v - logic for ALU decoder

// alu_decoder.v - logic for ALU decoder

module alu_decoder (
    input            opb5,        // For R-type instructions
    input [2:0]      funct3,      // 3-bit function field
    input            funct7b5,    // MSB of funct7 for R-type
    input [1:0]      ALUOp,       // ALU operation code
    output reg [3:0] ALUControl   // ALU control signal (4 bits now)
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0000;   // For ADD (lw/sw)
        2'b01: ALUControl = 4'b0001;   // For SUB (branch)
        default: 
            case (funct3) 
                3'b000: begin
                    if (funct7b5 & opb5) ALUControl = 4'b0001; // SUB
                    else ALUControl = 4'b0000; // ADD, ADDI
                end
                3'b001:  ALUControl = 4'b0100; // SLL, SLLI
                3'b010:  ALUControl = 4'b0101; // SLT, SLTI (signed comparison)
                3'b011:  ALUControl = 4'b0110; // SLTU, SLTIU (unsigned comparison)
                3'b100:  ALUControl = 4'b0111; // XOR, XORI
                3'b101: begin
                    if (funct7b5) ALUControl = 4'b1001; // SRA, SRAI
                    else ALUControl = 4'b1000; // SRL, SRLI
                end
                3'b110:  ALUControl = 4'b0011; // OR, ORI
                3'b111:  ALUControl = 4'b0010; // AND, ANDI
                default: ALUControl = 4'b1111; // Invalid
            endcase
    endcase
end
endmodule

