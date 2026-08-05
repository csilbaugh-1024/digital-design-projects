library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comp_3bit_tb is
end comp_3bit_tb;

architecture Sim of comp_3bit_tb is

    signal t_A : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal t_B : STD_LOGIC_VECTOR(2 downto 0) := "110";
    signal t_gt: STD_LOGIC;
    
begin

uut: entity work.comp_3bit
    port map(
        A => t_A,
        B => t_B,
        gt=> t_gt
    );
    
        process
        begin
            -- A less than B
            t_A <= "010";
            wait for 10 ns;
            assert t_gt = '0'
                report "FAIL! Comparator failed to recognize A less than B."
                severity error;
            
            -- equal
            t_A <= "110";
            wait for 10 ns;
            assert t_gt = '0'
                report "FAIL! Comparator failed to recognize A equal to B."
                severity error;
            
            -- A greater than B
            t_A <= "111";
            wait for 10 ns;
            assert t_gt = '1'
                report "FAIL! Comparator failed to recognize A greater than B."
                severity error;
            
            report "TEST SUCCESS!"
                severity note;
            wait;
        end process;
end Sim;
