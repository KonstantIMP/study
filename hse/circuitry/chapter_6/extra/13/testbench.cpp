#include "Vtask13.h"

#include "verilated.h"
#include "verilated_vcd_c.h"

#include <cstddef>
#include <cstdint>
#include <iomanip>
#include <iostream>
#include <memory>
#include <functional>
#include <string>
#include <vector>

constexpr std::size_t CLOCK_HALF_PERIOD = 1;
constexpr std::size_t CLOCK_PERIOD = CLOCK_HALF_PERIOD * 2;

constexpr std::size_t LEDS = 6;

void showLeds(std::int8_t l) {
    for (int i {0}; i < 8; i++) {
        if ((0b1 << (8 - i - 1)) & l) {
            std::cout << "#";
        } else {
            std::cout << "-";
        }
    }
    std::cout << std::endl;
}

int main(int argc, char ** argv) {
    // ==================== Context init ====================
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    // ==================== sr init ====================
    auto task = std::make_unique<Vtask13>(context.get());

    // ====================  Trace init  ====================
    Verilated::traceEverOn(true);
    auto trace = std::make_unique<VerilatedVcdC>();

    // ==================== Trace setup  ====================
    task->trace(trace.get(), 5);
    trace->open("waveform.vcd");

    // =================== Clock helpers ====================
    int i = 0;
    auto nextStep = [&] (){
        if (i % CLOCK_HALF_PERIOD == 0 && i != 0) {
            task->clk = !task->clk;
        }
        task->eval_step();
        trace->dump(i++);
    };

    auto nextPeriod = [&] (){
        for (int i {0}; i < CLOCK_PERIOD; i++) {
            nextStep();
        }
    };

    // ====================  Testbench   ====================

    task->rst_n = task->data_in = 1;

    for (int i = 0; i < 16; i++) {
        showLeds(task->leds);
        nextPeriod();
        if (i % 5 == 4) {
            task->data_in = task->data_in ? 0 : 1;
        }
        if (i == 10) {
            std::cout << "Clk" << std::endl;
            task->button = 1;
        } else if (i == 11) {
            task->button = 0;
        }
    }
    
    // ====================   Finalize   ====================
    trace->dump(i++);
    
    task->final();
    trace->close();

    return 0;
}
