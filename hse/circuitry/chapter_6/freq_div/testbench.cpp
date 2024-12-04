#include "Vdivider.h"

#include "verilated.h"
#include "verilated_vcd_c.h"

#include <cstddef>
#include <iostream>
#include <memory>

#ifndef NDIV
  #define NDIV 10
#endif //NDIV

constexpr std::size_t CLOCK_HALF_PERIOD = 1;
constexpr std::size_t CLOCK_PERIOD = CLOCK_HALF_PERIOD * 2;

int main(int argc, char ** argv) {
    std::cout << "Frequency Divider testbench (N = " << NDIV << ")" << std::endl;
    std::cout << "by KonstantIMP" << std::endl << std::endl;

    // ==================== Context init ====================
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    // ==================== Divider init ====================
    auto divider = std::make_unique<Vdivider>(context.get());

    // ====================  Trace init  ====================
    Verilated::traceEverOn(true);
    auto trace = std::make_unique<VerilatedVcdC>();

    // ==================== Trace setup  ====================
    divider->trace(trace.get(), 5);
    trace->open("waveform.vcd");
    
    // =================== Clock helpers ====================
    int i = 0;
    auto nextStep = [&] (){
        if (i % CLOCK_HALF_PERIOD == 0 && i != 0) {
            divider->clk = !divider->clk;
        }
        divider->eval_step();
        trace->dump(i++);
    };

    auto nextPeriod = [&] (){
        for (int i {0}; i < CLOCK_PERIOD; i++) {
            nextStep();
        }
    };

    // ====================  Testbench   ====================

    std::cout << "N = " << NDIV << std::endl;
    divider->rst_n = 1;

    for (int i {0}; i < 10; i++) {
        for (int j {0}; j < NDIV; j++) {
            nextPeriod();
            if (divider->clk_div) {
                std::cout << "#";
            } else {
                std::cout << "_";
            }
        }
        std::cout << std::endl;
    }

    // ====================   Finalize   ====================
    trace->dump(i++);
    
    divider->final();
    trace->close();

    return 0;
}
