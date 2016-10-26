1.a.
	1. mfc0/mtc0 
		The Mips instruction can not make use of registers in coprocessor 0 directly.
		
		The mfc0 (move from coprocessor 0) instruction loads data from a coprocessor 0 register into a CPU register.

		Simlarily, The mtc0 (store to coprocessor 0) instruction stores data in a cp0 register from cpu register.


	2. .set noat/ .set at 
		.set noat : turn off assembler warnings

		.set at : turn on assembler warnings again

	3. Cause register 
		MIPS coprocessor C0 has a Cause register(register 13). The Cause register provides information about which of the interrupts are pending (from IP2 to IP7) and the causes of each of the exceptions. The exception code is stored as an unsigned integer. ( 4 bit instruction to find the cause of an exception).

	4. EPC register 
		MIPS coprocessor C0 has an EPC (Exception Program Counter) register(register 14). When Exception occurs, in MIPS the control is transferred at a fixed location, 0x80000080 . The exception handler must be located at that address. The Exception Program Counter (EPC) is used to store the address of the instruction that was executing when the exception was generated.

1.b.	spim -exception_file <exception_file_name>

		spim -exception_file ~/Downloads/140050013_5/exceptions-knaveen.s

		qtspim:
			goto  simulator > settings > MIPS
			and the load exception handler file from browsing directory

1.c.	in explanation.txt

2.	Error:
		Exception 5
		word align error at 2147481049 [Address error in store] occured and ignored

3.	observation.txt
