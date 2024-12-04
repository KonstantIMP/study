#include "Vpwm.h"

#include "verilated.h"
#include "verilated_vcd_c.h"

#include <cstddef>
#include <iostream>
#include <memory>

#ifndef PWD_WIDTH
  #define PWD_WIDTH 4
#endif //PWD_WIDTH

constexpr std::size_t CLOCK_HALF_PERIOD = 1;
constexpr std::size_t CLOCK_PERIOD = CLOCK_HALF_PERIOD * 2;

int main(int argc, char ** argv) {
    std::cout << "Frequency Divider testbench (PWD_WIDTH = " << PWD_WIDTH << ")" << std::endl;
    std::cout << "by KonstantIMP" << std::endl << std::endl;

    // ==================== Context init ====================
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    // ==================== PWM init ====================
    auto pwm = std::make_unique<Vpwm>(context.get());

    // ====================  Trace init  ====================
    Verilated::traceEverOn(true);
    auto trace = std::make_unique<VerilatedVcdC>();

    // ==================== Trace setup  ====================
    pwm->trace(trace.get(), 5);
    trace->open("waveform.vcd");
    
    // =================== Clock helpers ====================
    int i = 0;
    auto nextStep = [&] (){
        if (i % CLOCK_HALF_PERIOD == 0 && i != 0) {
            pwm->clk = !pwm->clk;
        }
        pwm->eval_step();
        trace->dump(i++);
    };

    auto nextPeriod = [&] (){
        for (int i {0}; i < CLOCK_PERIOD; i++) {
            nextStep();
        }
    };

    // ====================  Testbench   ====================

    std::cout << "PWD_WIDTH = " << PWD_WIDTH << std::endl;
    pwm->rst_n = 1;

    for (int i {0}; i <= (1 << PWD_WIDTH); i++) {
        std::cout << "(" << i << " / " << (1 << PWD_WIDTH) << ") ";
        pwm->imp = i;
        for (int j {0}; j < 3 * (1 << PWD_WIDTH); j++) {
            nextPeriod();
            std::cout << (pwm->pwv_out ? '#' : '_');
        }
        std::cout << std::endl;
    }

    // ====================   Finalize   ====================
    trace->dump(i++);
    
    pwm->final();
    trace->close();

    return 0;
}
