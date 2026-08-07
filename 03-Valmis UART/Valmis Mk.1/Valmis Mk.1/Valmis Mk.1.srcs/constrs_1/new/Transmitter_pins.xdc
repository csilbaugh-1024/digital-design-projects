# input ports
set_property -dict { PACKAGE_PIN V17    IOSTANDARD LVCMOS33 } [get_ports {W[0]}];
set_property -dict { PACKAGE_PIN V16    IOSTANDARD LVCMOS33 } [get_ports {W[1]}];
set_property -dict { PACKAGE_PIN W16    IOSTANDARD LVCMOS33 } [get_ports {W[2]}];
set_property -dict { PACKAGE_PIN W17    IOSTANDARD LVCMOS33 } [get_ports {W[3]}];
set_property -dict { PACKAGE_PIN W15    IOSTANDARD LVCMOS33 } [get_ports {W[4]}];
set_property -dict { PACKAGE_PIN V15    IOSTANDARD LVCMOS33 } [get_ports {W[5]}];
set_property -dict { PACKAGE_PIN W14    IOSTANDARD LVCMOS33 } [get_ports {W[6]}];

set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports { data_in }];

# output in USB
set_property -dict { PACKAGE_PIN A18 IOSTANDARD LVCMOS33 } [get_ports { y }];

# clock
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];