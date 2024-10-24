
// alu.v - ALU module

/*module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [2:0] alu_ctrl,         // ALU control
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero                    // zero flag
);

always @(a, b, alu_ctrl) begin
    case (alu_ctrl)
        3'b000:  alu_out <= a + b;       // ADD
        3'b001:  alu_out <= a + ~b + 1;  // SUB
        3'b010:  alu_out <= a & b;       // AND
        3'b011:  alu_out <= a | b;       // OR
        3'b101:  begin                   // SLT
                     if (a[31] != b[31]) alu_out <= a[31] ? 0 : 1;
                     else alu_out <= a < b ? 1 : 0;
                 end
        default: alu_out = 0;
    endcase
end

assign zero = (alu_out == 0) ? 1'b1 : 1'b0;

endmodule*/

// alu.v - ALU module

/*module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [2:0] alu_ctrl,         // ALU control
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero                    // zero flag
);

wire signed [WIDTH-1:0] signed_a = a;    // Signed version of operand a
wire signed [WIDTH-1:0] signed_b = b;    // Signed version of operand b

always @(a, b, alu_ctrl) begin
    case (alu_ctrl)
        3'b000:  alu_out <= a + b;       // ADD,ADDi
        3'b001:  alu_out <= a + ~b + 1;  // SUB
        3'b010:  alu_out <= a & b;       // AND,ANDi
        3'b011:  alu_out <= a | b;       // OR,ORi
        3'b100:  alu_out <= a << b[4:0]; // c sll,slli
        3'b101:  alu_out <= (signed_a < signed_b) ? 1 : 0;  // slt,slti (signed comparison)
        3'b110:  alu_out <= (a<b)?1:0;   //c sllu,slliu
        3'b111:  alu_out <= a ^ b;
        default: alu_out = 0;
    endcase
end

assign zero = (alu_out == 0) ? 1'b1 : 1'b0;

endmodule*/


module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // Operands
    input       [3:0] alu_ctrl,         // ALU control signal (now 4 bits)
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero                    // Zero flag
);

wire signed [WIDTH-1:0] signed_a = a;    // Signed version of operand a
wire signed [WIDTH-1:0] signed_b = b;    // Signed version of operand b

always @(a, b, alu_ctrl) begin
    case (alu_ctrl)
        4'b0000:  alu_out <= a + b;       // ADD, ADDI
        4'b0001:  alu_out <= a + ~b + 1;       // SUB
        4'b0010:  alu_out <= a & b;       // AND, ANDI
        4'b0011:  alu_out <= a | b;       // OR, ORI
        4'b0100:  alu_out <= a << b[4:0]; // SLL, SLLI
        4'b0101:  alu_out <= (signed_a < signed_b) ? 1 : 0;  // SLT, SLTI (signed comparison)
        4'b0110:  alu_out <= (a < b) ? 1 : 0;  // SLTU, SLTIU (unsigned comparison)
        4'b0111:  alu_out <= a ^ b;       // XOR, XORI
        4'b1000:  alu_out <= a >> b[4:0]; // SRL, SRLI (logical right shift)
        4'b1001:  alu_out <= signed_a >>> b[4:0]; // SRA, SRAI (arithmetic right shift)
        default:  alu_out <= 0;            // Invalid
    endcase
end

assign zero = (alu_out == 0) ? 1'b1 : 1'b0;

endmodule
