N=4

all: testbench

testbench:
	verilator --cc --exe --build -j 0 -Wno-fatal --trace -CFLAGS -DWIDTH=$N \
		shift_register.v ../d_flip_flop.v testbench.cpp  \
		-GWIDTH=$N -o testbench
	cp obj_dir/testbench .

clean:
	rm -rf testbench obj_dir 
