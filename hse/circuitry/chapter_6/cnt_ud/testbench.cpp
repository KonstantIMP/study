#include "Vcounter.h"

#include "verilated.h"
#include "verilated_vcd_c.h"

#include <cstddef>
#include <iostream>
#include <memory>

constexpr std::size_t CLOCK_HALF_PERIOD = 2;
constexpr std::size_t CLOCK_PERIOD = CLOCK_HALF_PERIOD * 2;

int main(int argc, char ** argv) {
    std::cout << "Counter with Up and Down testbench" << std::endl;
    std::cout << "by KonstantIMP" << std::endl << std::endl;

    // ==================== Context init ====================
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    // ==================== Counter init ====================
    auto counter = std::make_unique<Vcounter>(context.get());

    // ====================  Trace init  ====================
    Verilated::traceEverOn(true);
    auto trace = std::make_unique<VerilatedVcdC>();

    // ==================== Trace setup  ====================
    counter->trace(trace.get(), 5);
    trace->open("waveform.vcd");
    
    // =================== Clock helpers ====================
    int i = 0;
    auto nextStep = [&] (){
        if (i % CLOCK_HALF_PERIOD == 0 && i != 0) {
            counter->clk = !counter->clk;
        }
        counter->eval_step();
        trace->dump(i++);
    };

    auto nextPeriod = [&] (){
        for (int i {0}; i < CLOCK_PERIOD; i++) {
            nextStep();
        }
    };

    // ====================  Testbench   ====================

    counter->rst_n = counter->up_down = 1;

    std::cout << static_cast<int>(counter->cnt) << std::endl;
    for (int i {0}; i < 2; i++) {
        nextPeriod();
        std::cout << "+1 = " << static_cast<int>(counter->cnt) << std::endl;
    }

    counter->up_down = 0;
    for (int i {0}; i < 4; i++) {
        nextPeriod();
        std::cout << "-1 = " << static_cast<int>(counter->cnt) << std::endl;
    }

    nextStep();
    counter->rst_n = 0;
    for (int i {0}; i < CLOCK_PERIOD - 1; i++) {
        nextStep();
    }
    std::cout << "After reset = " << static_cast<int>(counter->cnt) << std::endl;

    // ====================   Finalize   ====================
    trace->dump(i++);
    
    counter->final();
    trace->close();

    return 0;
}
