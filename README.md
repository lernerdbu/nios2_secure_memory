# nios2_secure_memory
BU EC544 project. Adding encrypted load and store as custom instructions to the NIOS II core on Cyclone IV FPGA

Important files:
  - instruction_hw/* 
 RTL designed from scratch for our custom instruction block that interfaces between the NIOS II core and the on-chip RAM
  - nios2_secure_memory.qsys
 Opens using the Quartus Platform Designer which lays out the components used and connections between them
  - software/mem_test_small_custom/memtest_small.c
 Software demo based off of example code that uses both the built-in and the new secure load/store instructions
