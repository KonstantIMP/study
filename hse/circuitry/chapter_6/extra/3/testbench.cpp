#include "Vtask3.h"

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

#include <array>

std::array<std::string, 4> ledToView(int8_t led) {
    std::array<std::string, 4> view;

    view[0] = " " + std::string {(~led & 0b00000001) ? "_" : " "} + " ";
    view[1] = std::string {(~led & 0b00100000) ? "|" : " "} + std::string {(~led & 0b01000000) ? "_" : " "} + std::string {(~led & 0b00000010) ? "|" : " "};
    view[2] = std::string {(~led & 0b00010000) ? "|" : " "} + " " + std::string {(~led & 0b00000100) ? "|" : " "};
    view[3] = " " + std::string {(~led & 0b00001000) ? "‾" : " "} + " "; 

    return view;
}

void printViews(const std::vector<std::array<std::string, 4>>& d) {
    for (int i {0}; i < 4; i++) {
        for (const auto& a : d) {
            std::cout << a[i];
        }
        std::cout << std::endl;
    }
}

void printLedsWire(std::int64_t wire, std::size_t leds_num = LEDS) {
    std::vector<std::array<std::string, 4>> leds;

    for (int i {0}; i < leds_num; i++) {
        std::int8_t l = static_cast<std::int8_t>((wire >> (8 * (leds_num - i - 1))) & 0xff);
        leds.push_back(ledToView(l));
    }

    printViews(leds);   
}

int main(int argc, char ** argv) {
    // ==================== Context init ====================
    auto context = std::make_unique<VerilatedContext>();
    context->commandArgs(argc, argv);

    // ==================== sr init ====================
    auto task = std::make_unique<Vtask3>(context.get());

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

    task->rst_n = 1; nextStep();

    for (int i = 0; i < 20; i++) {
        printLedsWire(task->out_leds);
        nextPeriod();
    }

    task->rst_n = 0; nextStep();
    printLedsWire(task->out_leds);
    
    // ====================   Finalize   ====================
    trace->dump(i++);
    
    task->final();
    trace->close();

    return 0;
}
