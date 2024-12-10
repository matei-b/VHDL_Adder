library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_1Bit is
    Port (
        A    : in  STD_LOGIC;    -- Input bit A
        B    : in  STD_LOGIC;    -- Input bit B
        Cin  : in  STD_LOGIC;    -- Carry-in
        S    : out STD_LOGIC;    -- Sum
        P : buffer STD_LOGIC; -- Group propagate
        G : buffer STD_LOGIC; -- Group generate
        Cout : out STD_LOGIC     -- Carry-out
    );
end CLA_1Bit;

architecture Behavioral of CLA_1Bit is
begin
    -- Generate and Propagate
    P <= A xor B;
    G  <= A and B;

    -- Sum and Carry-Out
    S <= P xor Cin;
    Cout <= G or (P and Cin);
end Behavioral;
