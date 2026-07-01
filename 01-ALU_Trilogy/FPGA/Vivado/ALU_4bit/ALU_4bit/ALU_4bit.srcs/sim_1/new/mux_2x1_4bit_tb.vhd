library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_2x1_4bit_tb is
end mux_2x1_4bit_tb;

architecture sim of mux_2x1_4bit_tb is
   
    signal t_A  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_B  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_sel: STD_LOGIC := '0';
    signal t_C  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

begin

uut: entity work.four_bit_2x1_mux
    port map(
        A   => t_A,
        B   => t_B,
        sel => t_sel,
        C   => t_C
    );
    
        process
            variable expected   : unsigned(3 downto 0);
            variable actual     : unsigned(3 downto 0);
        begin
            -- Case sel=0
            t_A     <= "0110";
            t_B     <= "1001";
            t_sel   <= '0';
            wait for 10 ns;
        
            expected    := unsigned(t_B);
            actual      := unsigned(t_C);
        
            -- PASS/FAIL logic
            if actual /= expected then
                report "FAIL! A=" & to_string(t_A) &
                    " B=" & to_string(t_B) &
                    " sel=" & to_string(t_sel) &
                    " C=" & to_string(t_C)
                severity error;
            end if;
            
            -- Case sel=1
            t_A     <= "0110";
            t_B     <= "1001";
            t_sel   <= '1';
            wait for 10 ns;
            
            expected    := unsigned(t_A);
            actual      := unsigned(t_C);
            
            -- PASS/FAIL logic
            if actual /= expected then
                report "FAIL! A=" & to_string(t_A) &
                    " B=" & to_string(t_B) &
                    " sel=" & to_string(t_sel) &
                    " C=" & to_string(t_C)
                severity error;
            end if;
            report "TEST DONE!";
            wait;
        end process; 
end sim;