library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity four_bit_full_adder_tb is
end four_bit_full_adder_tb;

architecture Sim of four_bit_full_adder_tb is
    signal A    : STD_LOGIC_VECTOR(3 downto 0);
    signal B    : STD_LOGIC_VECTOR(3 downto 0);
    signal Cin  : STD_LOGIC;
    signal Sum  : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout : STD_LOGIC;
    
begin
    UUT : entity work.four_bit_full_adder
    port map(
        A   => A,
        B   => B,
        Cin => Cin,
        Sum => Sum,
        Cout=> Cout
    );

        -- test every single combination possible via loops, and compare each actual
        -- result with corresponding expected result. If all pass, test is a success.
        process
            variable expected   : unsigned(4 downto 0);
            variable actual     : unsigned(4 downto 0);
        begin
            for i in 0 to 15 loop
                for j in 0 to 15 loop
                    -- Case Cin = 0
                    A   <= STD_LOGIC_VECTOR(to_unsigned(i, 4));
                    B   <= STD_LOGIC_VECTOR(to_unsigned(j, 4));
                    Cin <= '0';
                    wait for 10 ns;
                    
                    
                    expected    := to_unsigned(i, 5) + to_unsigned(j, 5);
                    actual      := unsigned(Cout & Sum);
                    
                    -- PASS/FAIL logic
                    if actual /= expected then
                        report "FAIL! A=" & integer'image(i) &
                            " B=" & integer'image(j) &
                            " Cin=" & std_logic'image(Cin)
                        severity error;
                    end if;
                    
                    -- Case Cin = 1
                    Cin <= '1';
                    wait for 10 ns;                    
                    
                    expected    := to_unsigned(i, 5) + to_unsigned(j, 5) +1;
                    actual      := unsigned(Cout & Sum);
                    
                    -- PASS/FAIL logic
                    if actual /= expected then
                        report "FAIL! A=" & integer'image(i) &
                            " B=" & integer'image(j) &
                            " Cin=" & std_logic'image(Cin)
                        severity error;
                    end if;         
                end loop;
            end loop;
            report "TEST DONE!";
            wait;
        end process;
end Sim;
