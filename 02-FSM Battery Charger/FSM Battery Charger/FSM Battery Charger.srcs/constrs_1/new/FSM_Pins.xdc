# input ports
set_property -dict { PACKAGE_PIN V17    IOSTANDARD LVCMOS33 } [get_ports { f }];
set_property -dict { PACKAGE_PIN V16    IOSTANDARD LVCMOS33 } [get_ports { b }];

# rightmost LEDs will show output values
set_property -dict { PACKAGE_PIN U16    IOSTANDARD LVCMOS33 } [get_ports { d }];
set_property -dict { PACKAGE_PIN E19    IOSTANDARD LVCMOS33 } [get_ports { c }];

#clock
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];