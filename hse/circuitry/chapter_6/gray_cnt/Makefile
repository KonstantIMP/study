N=2

all: testbench

testbench:
	verilator --cc --exe --build -j 0 -Wno-fatal --trace -CFLAGS -DNWIDTH=$N \
		gray_counter.v ../adder.v ../d_flip_flop.v ../register.v ../mux.v ../bin2gray.v ../comparator.v ../cnt_load/counter.v testbench.cpp  \
		-GWIDTH=$N -o testbench
	cp obj_dir/testbench .

clean:
	rm -rf testbench obj_dir 
