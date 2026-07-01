# A switches
set_property -dict { PACKAGE_PIN W13    IOSTANDARD LVCMOS33 } [get_ports { A[3] }];
set_property -dict { PACKAGE_PIN W14    IOSTANDARD LVCMOS33 } [get_ports { A[2] }];
set_property -dict { PACKAGE_PIN V15    IOSTANDARD LVCMOS33 } [get_ports { A[1] }];
set_property -dict { PACKAGE_PIN W15    IOSTANDARD LVCMOS33 } [get_ports { A[0] }];

# B switches
set_property -dict { PACKAGE_PIN W17    IOSTANDARD LVCMOS33 } [get_ports { B[3] }];
set_property -dict { PACKAGE_PIN W16    IOSTANDARD LVCMOS33 } [get_ports { B[2] }];
set_property -dict { PACKAGE_PIN V16    IOSTANDARD LVCMOS33 } [get_ports { B[1] }];
set_property -dict { PACKAGE_PIN V17    IOSTANDARD LVCMOS33 } [get_ports { B[0] }];

# Select switches
set_property -dict { PACKAGE_PIN R2     IOSTANDARD LVCMOS33 } [get_ports { s2 }];
set_property -dict { PACKAGE_PIN T1     IOSTANDARD LVCMOS33 } [get_ports { s1 }];
set_property -dict { PACKAGE_PIN U1     IOSTANDARD LVCMOS33 } [get_ports { s0 }];

set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports { Output[0] }];
set_property -dict { PACKAGE_PIN E19  IOSTANDARD LVCMOS33 } [get_ports { Output[1] }];
set_property -dict { PACKAGE_PIN U19  IOSTANDARD LVCMOS33 } [get_ports { Output[2] }];
set_property -dict { PACKAGE_PIN V19  IOSTANDARD LVCMOS33 } [get_ports { Output[3] }];

