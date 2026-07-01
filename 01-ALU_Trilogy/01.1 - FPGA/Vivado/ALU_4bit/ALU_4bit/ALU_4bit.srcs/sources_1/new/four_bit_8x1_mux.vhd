library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_bit_8x1_mux is
    port(
        i7  : in STD_LOGIC_VECTOR(3 downto 0);
        i6  : in STD_LOGIC_VECTOR(3 downto 0);
        i5  : in STD_LOGIC_VECTOR(3 downto 0);
        i4  : in STD_LOGIC_VECTOR(3 downto 0);
        i3  : in STD_LOGIC_VECTOR(3 downto 0);
        i2  : in STD_LOGIC_VECTOR(3 downto 0);
        i1  : in STD_LOGIC_VECTOR(3 downto 0);
        i0  : in STD_LOGIC_VECTOR(3 downto 0);
        s2  : in STD_LOGIC;
        s1  : in STD_LOGIC;
        s0  : in STD_LOGIC;
        C   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end four_bit_8x1_mux;

architecture behavioral of four_bit_8x1_mux is
    signal select_vector:   STD_LOGIC_VECTOR(2 downto 0);
begin
    select_vector <= s2 & s1 & s0;
    
    process(select_vector, i0, i1, i2, i3, i4, i5, i6, i7)
    begin
        case select_vector is
            when "000"  => C <= i0;
            when "001"  => C <= i1;
            when "010"  => C <= i2;
            when "011"  => C <= i3;
            when "100"  => C <= i4;
            when "101"  => C <= i5;
            when "110"  => C <= i6;
            when "111"  => C <= i7;
            when others => C <= "0000"; -- protective measure for any other case
        end case;
    end process;
end behavioral;
