/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_sumador (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (1 = output)
    input  wire       ena,      // siempre 1 cuando está habilitado
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - bajo para reset
);

    // ============================
    // Señales internas
    // ============================
    wire       enable;
    wire [7:0] out;
    wire       cout;

    // Usamos solo el bit 0 de ui_in como enable
    assign enable = ui_in[0];

    // Conectamos la salida del sumador a los pines dedicados
    assign uo_out = out;

    // IOs: solo el bit 7 es salida (cout), el resto en 0
    assign uio_out[6:0] = 7'b000_0000;
    assign uio_out[7]   = cout;

    // uio_oe: 1 = output, 0 = input
    // Solo el bit 7 es salida, los demás son entradas
    assign uio_oe = 8'b1000_0000;

    // ============================
    // Instancia del sumador
    // ============================
    sumador sumador_Unit (
        .clk   (clk),
        .rst   (rst_n),   // tu sumador tiene reset activo en bajo
        .enable(enable),
        .out   (out),
        .cout  (cout)
    );

    // ============================
    // Evitar warnings por señales sin usar
    // ============================
    wire _unused = &{ena, uio_in, ui_in[7:1], 1'b0};

endmodule

`default_nettype wire
