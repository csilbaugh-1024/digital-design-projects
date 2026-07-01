library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_4bit is
    port(
        A       : in STD_LOGIC_VECTOR(3 downto 0);
        B       : in STD_LOGIC_VECTOR(3 downto 0);
        s2      : in STD_LOGIC;
        s1      : in STD_LOGIC;
        s0      : in STD_LOGIC;
        Output  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end ALU_4bit;

architecture behavioral of ALU_4bit is

    signal NOT_B, NOT_A, A_NAND_B, A_XOR_B, A_OR_B, A_AND_B, B_mux_out, sum_or_diff : STD_LOGIC_VECTOR(3 downto 0); -- logic gate inputs, 2x1 mux output, adder output
    signal NOT_s0 : STD_LOGIC;
   
begin
    NOT_B           <= not B;
    NOT_A           <= not A;
    A_NAND_B        <= A nand B;
    A_XOR_B         <= A xor B;
    A_OR_B          <= A or B;
    A_AND_B         <= A and B;
    NOT_s0          <= not s0;
    
    Mux_2x1 : entity work.four_bit_2x1_mux
        port map(
            A           => B,
            B           => NOT_B,
            sel         => NOT_s0,
            C           => B_mux_out
        );
     
    Adder_Subtractor    : entity work.four_bit_full_adder
        port map(
            A           => A,
            B           => B_mux_out,
            Cin         => s0,
            Sum         => sum_or_diff,
            Cout        => open
        );

    Mux_8x1 : entity work.four_bit_8x1_mux  
        port map(
            i7  => NOT_B,
            i6  => NOT_A,
            i5  => A_NAND_B,
            i4  => A_XOR_B,
            i3  => A_OR_B,
            i2  => A_AND_B,
            i1  => sum_or_diff, -- difference in this case
            i0  => sum_or_diff, -- sum
            s2  => s2,
            s1  => s1,
            s0  => s0,
            C   => output
        );
end behavioral;
            
    