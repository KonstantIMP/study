#include "Vshift_register.h"

#include "verilated.h"
#include "verilated_vcd_c.h"

#include <cstddef>
#include <iomanip>
#include <iostream>
#include <memory>
#include <functional>

#ifndef WIDTH
  #define WIDTH 4
#endif //WIDTH

constexpr std::size_t CLOCK_HALF_PERIOD = 1;
constexpr std::size_t CLOCK_PERIOD = CLOCK_HALF_PERIOD * 2;

int main(int argc, char ** argv) {
    std::cout << "Frequency Divider testbench (PWD_WIDTH = " << WIDTH << ")" << std::endl;
    std::cout << "by KonstantIMP" << std::endl << std::endl;

    // ==================== Context init ====================
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    // ==================== sr init ====================
    auto sr = std::make_unique<Vshift_register>(context.get());

    // ====================  Trace init  ====================
    Verilated::traceEverOn(true);
    auto trace = std::make_unique<VerilatedVcdC>();

    // ==================== Trace setup  ====================
    sr->trace(trace.get(), 5);
    trace->open("waveform.vcd");
    
    // =================== Clock helpers ====================
    int i = 0;
    auto nextStep = [&] (){
        if (i % CLOCK_HALF_PERIOD == 0 && i != 0) {
            sr->clk = !sr->clk;
        }
        sr->eval_step();
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

    std::cout << "WIDTH = " << WIDTH << std::endl;
    sr->rst_n = 1; sr->shift_en = 1;

    for (int i {0}; i <= WIDTH * 3; i++) {
        sr->data_in = (i % 3 == 2 ? 0 : 1);
        std::cout << "(" << std::setw(2) << std::setfill(' ') << i << " / " << (1 << WIDTH) << ") "
            << "+" << static_cast<int>(sr->data_in) << " " << (sr->shift_en ? " on" : "off") << " ";
        nextPeriod();
        std::cout << std::setw(WIDTH) << std::setfill('0') << toBin(sr->data_out) << std::endl;
        if (i == WIDTH * 2) sr->shift_en = 0;
    }

    // ====================   Finalize   ====================
    trace->dump(i++);
    
    sr->final();
    trace->close();

    return 0;
}
