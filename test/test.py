# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def basic_run(dut):
    """Test mínimo: solo resetea y deja correr unos ciclos."""

    dut._log.info("Start")

    # Reloj a 100 kHz (10 us periodo)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset inicial
    dut._log.info("Reset")
    dut.ena.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    dut.ena.value = 1

    # Deja correr algunos ciclos
    dut._log.info("Running a few cycles")
    await ClockCycles(dut.clk, 20)

    # Si llegamos aquí, el test pasa
    assert True
