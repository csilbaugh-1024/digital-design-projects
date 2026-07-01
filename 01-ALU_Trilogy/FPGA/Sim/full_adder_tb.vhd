library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity full_adder_tb is
end full_adder_tb;

architecture Sim of full_adder_tb is
    signal A    : STD_LOGIC;
    signal B    : STD_LOGIC; 
    signal Cin  : STD_LOGIC;
    Signal Sum  : STD_LOGIC;
    signal Cout : STD_LOGIC;
    
begin
    UUT : entity work.full_adder
    port map(
        A   => A,
        B   => B,
        Cin => Cin,
        Sum => Sum,
        Cout=> Cout
    ); 
        
        process
        begin
            A <= '0';
            B <= '0';
            Cin <= '0';
            wait for 10 ns;
            
            A <= '0';
            B <= '0';
            Cin <= '1';
            wait for 10 ns;
            
            A <= '0';
            B <= '1';
            Cin <= '0';
            wait for 10 ns;
            
            A <= '0';
            B <= '1';
            Cin <= '1';
            wait for 10 ns;
            
            A <= '1';
            B <= '0';
            Cin <= '0';
            wait for 10 ns;
            
            A <= '1';
            B <= '0';
            Cin <= '1';
            wait for 10 ns;
            
            A <= '1';
            B <= '1';
            Cin <= '0';
            wait for 10 ns;
            
            A <= '1';
            B <= '1';
            Cin <= '1';
            wait;
            
        end process;
    end Sim;
