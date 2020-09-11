# RVS192-CPU
A 32-bit RISC-V CPU using SystemVerilog 
# Features:
* 5-Stage Pipeline RISC-V
* 2 Level Cache (Configurable):
  1)  Level 1 Instruction Cache
  2)  Level 1 Data Cache
  3)  Level 2 Share Cache (Instruction + Data)
* Branch Predictor (Configurable):
  1)  Local Branch Predictor
  2)  Gshate Branch Predictor
  3)  Hybrid Branch Predictor
# Note:   
* Access RVS192_user_parameters.sv to config capacity of
Cache and Branch Predictor
* Access RVS192_user_define.h to config Branch Predictor's type,
enable SIMULATE macro for SIMULATION, disable SIMULATE for SYNTHESIS
