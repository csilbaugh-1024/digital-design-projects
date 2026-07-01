library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_8x1_4bit_tb is
end mux_8x1_4bit_tb;

architecture sim of mux_8x1_4bit_tb is

    signal t_i7 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_i6 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_i5 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_i4 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_i3 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_i2 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_i1 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_i0 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal t_select_vector  : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal t_C  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    
begin

uut: entity work.four_bit_8x1_mux
    port map(
        i7  => t_i7,
        i6  => t_i6,
        i5  => t_i5,
        i4  => t_i4,
        i3  => t_i3,
        i2  => t_i2,
        i1  => t_i1,
        i0  => t_i0,
        s2  => t_select_vector(2),
        s1  => t_select_vector(1),
        s0  => t_select_vector(0),
        C   => t_C
    );
        
        process
            variable expected   : unsigned(3 downto 0);
            variable actual     : unsigned(3 downto 0);
        begin
            -- set arbitrary input values
            t_i7    <=  "0111";
            t_i6    <=  "0110";
            t_i5    <=  "0101";
            t_i4    <=  "0100";
            t_i3    <=  "0011";
            t_i2    <=  "0010";
            t_i1    <=  "0001";
            t_i0    <=  "0000";
            for i in 0 to 7 loop -- compute all possible select combinations
                t_select_vector <= STD_LOGIC_VECTOR(to_unsigned(i, 3));
                wait for 10 ns;
                expected    := to_unsigned(i, 4);
                actual      := unsigned(t_C);
                
                -- PASS/FAIL logic
                if actual /= expected then
                    report "FAIL! Mux did not select correct input value" &
                    " Select =" & to_string(t_select_vector) &
                    " C=" & to_string(t_C)
                    severity error;
                end if;
            end loop;
            
            report "TEST DONE!";
            wait;
    end process;
end sim;