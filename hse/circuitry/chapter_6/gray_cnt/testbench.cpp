#include "Vgray_counter.h"

#include "verilated.h"
#include "verilated_vcd_c.h"

#include <cstddef>
#include <functional>
#include <iomanip>
#include <iostream>
#include <memory>

#ifndef NWIDTH
  #define NWIDTH 2 
#endif //NWIDTH

constexpr std::size_t CLOCK_HALF_PERIOD = 1;
constexpr std::size_t CLOCK_PERIOD = CLOCK_HALF_PERIOD * 2;

int main(int argc, char ** argv) {
    std::cout << "Gray Counter testbench (NWIDTH = " << NWIDTH << ")" << std::endl;
    std::cout << "by KonstantIMP" << std::endl << std::endl;

    // ==================== Context init ====================
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    // ==================== Counter init ====================
    auto gray = std::make_unique<Vgray_counter>(context.get());

    // ====================  Trace init  ====================
    Verilated::traceEverOn(true);
    auto trace = std::make_unique<VerilatedVcdC>();

    // ==================== Trace setup  ====================
    gray->trace(trace.get(), 5);
    trace->open("waveform.vcd");
    
    // =================== Clock helpers ====================
    int i = 0;
    auto nextStep = [&] (){
        if (i % CLOCK_HALF_PERIOD == 0 && i != 0) {
            gray->clk = !gray->clk;
        }
        gray->eval_step();
        trace->dump(i++);
    };

    auto nextPeriod = [&] (){
        for (int i {0}; i < CLOCK_PERIOD; i++) {
            nextStep();
        }
    };

    std::function<std::string(int)> toBin;
    toBin = [&] (int i) -> std::string {
        if (i == 1) {
            return "1";
        } else if (i == 0) {
            return "0";
        } 
        return toBin(i / 2) + toBin(i % 2);
    };

    // ====================  Testbench   ====================

    std::cout << "NWIDTH = " << NWIDTH << std::endl;
    gray->rst_n = 1;

    for (int i {0}; i < (1 << NWIDTH); i++) {
        std::cout << "(" << i << " / " << (1 << NWIDTH) << ") ";
        std::cout << std::setw(4) << std::setfill('0') << toBin(gray->cnt) << std::endl;
        nextPeriod();
    }

    // ====================   Finalize   ====================
    trace->dump(i++);
    
    gray->final();
    trace->close();

    return 0;
}
