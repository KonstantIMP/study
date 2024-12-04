N=2

all: testbench

testbench:
	verilator --cc --exe --build -j 0 -Wno-fatal --trace -CFLAGS -DPWD_WIDTH=$N \
		pwm.v ../adder.v ../d_flip_flop.v ../register.v ../mux.v ../substractor.v ../comparator.v ../cnt_load/counter.v testbench.cpp  \
		-GPWD_WIDTH=$N -o testbench
	cp obj_dir/testbench .

clean:
	rm -rf testbench obj_dir 
