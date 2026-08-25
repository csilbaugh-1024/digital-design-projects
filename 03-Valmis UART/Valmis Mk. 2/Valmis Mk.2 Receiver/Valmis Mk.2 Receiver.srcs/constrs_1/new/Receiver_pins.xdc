# USB input
set_property -dict { PACKAGE_PIN B18 IOSTANDARD LVCMOS33 } [get_ports { y }];

# LED outputs
set_property -dict { PACKAGE_PIN U16    IOSTANDARD LVCMOS33 } [get_ports { D[0] }];
set_property -dict { PACKAGE_PIN E19    IOSTANDARD LVCMOS33 } [get_ports { D[1] }];
set_property -dict { PACKAGE_PIN U19    IOSTANDARD LVCMOS33 } [get_ports { D[2] }];
set_property -dict { PACKAGE_PIN V19    IOSTANDARD LVCMOS33 } [get_ports { D[3] }];
set_property -dict { PACKAGE_PIN W18    IOSTANDARD LVCMOS33 } [get_ports { D[4] }];
set_property -dict { PACKAGE_PIN U15    IOSTANDARD LVCMOS33 } [get_ports { D[5] }];
set_property -dict { PACKAGE_PIN U14    IOSTANDARD LVCMOS33 } [get_ports { D[6] }];

# clock
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];