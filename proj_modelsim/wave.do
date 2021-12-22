onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_UC_tb/CLK
add wave -noupdate /MIPS_UC_tb/RST
add wave -noupdate /MIPS_UC_tb/INSTR
add wave -noupdate /MIPS_UC_tb/UC_STATE
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/GPIO_o_tb
add wave -noupdate /MIPS_UC_tb/GPIO_i_tb
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/PCin_mux
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/PC_reg
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/AdrSM_mux
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/MS_Rdat
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/Instr_reg
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/Peri_mux
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/RF_RD1
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/RF_RD2
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/ALUresult
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/SignImm
add wave -noupdate -radix hexadecimal /MIPS_UC_tb/DUT/ACC_reg
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/PCen
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/IorD
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/MemWrite
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/IRWrite
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/PCWrite
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/BranchEq
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/PCSrc
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/ALUSrcA
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/RegWrite
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/MemtoReg
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/RegDst
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/BranchNeq
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/Jen
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/SignZero
add wave -noupdate -expand -group ControlSignals /MIPS_UC_tb/DUT/IntorPeri
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {162 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 60
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {112 ns} {206 ns}
