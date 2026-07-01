library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity four_bit_full_adder is
    port(
        A   : in STD_LOGIC_VECTOR(3 downto 0);
        B   : in STD_LOGIC_VECTOR(3 downto 0);
        Cin : in STD_LOGIC;
        Sum : out STD_LOGIC_VECTOR(3 downto 0);
        Cout: out STD_LOGIC
    );
end four_bit_full_adder;

architecture Struct of four_bit_full_adder is
    signal c1, c2, c3 : STD_LOGIC;
    
begin
    FA0: entity work.full_adder
        port map(
            A   =>  A(0),
            B   =>  B(0),
            Cin =>  Cin,
            Sum =>  Sum(0),
            Cout=>  c1
        );
    
    FA1: entity work.full_adder
        port map(
            A   =>  A(1),
            B   =>  B(1),
            Cin =>  c1,
            Sum =>  Sum(1),
            Cout=>  c2
        );

    FA2: entity work.full_adder
        port map(
            A   =>  A(2),
            B   =>  B(2),
            Cin =>  c2,
            Sum =>  Sum(2),
            Cout=>  c3
        );

    FA3: entity work.full_adder
        port map(
            A   =>  A(3),
            B   =>  B(3),
            Cin =>  c3,
            Sum =>  Sum(3),
            Cout=>  Cout
        );
end Struct;
