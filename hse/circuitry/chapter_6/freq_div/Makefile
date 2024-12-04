N=10

all: testbench

testbench:
	verilator --cc --exe --build -j 0 -Wno-fatal --trace -CFLAGS -DNDIV=$N \
		divider.v ../adder.v ../d_flip_flop.v ../register.v ../mux.v ../substractor.v ../comparator.v ../cnt_load/counter.v testbench.cpp  \
		-GN=$N -o testbench
	cp obj_dir/testbench .

clean:
	rm -rf testbench obj_dir 
