library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 4-bit Carry Look-Ahead Adder Entity
entity CLA_4Bit is
    Port (
        A       : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input A
        B       : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input B
        Cin     : in  STD_LOGIC;                    -- Carry-in
        S       : out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit sum output
        P_group : out STD_LOGIC;                    -- Group propagate
        G_group : out STD_LOGIC;                    -- Group generate
        Cout    : out STD_LOGIC                     -- Carry-out
    );
end CLA_4Bit;

architecture Behavioral of CLA_4Bit is
    signal P : STD_LOGIC_VECTOR(3 downto 0); -- Propagate signals
    signal G : STD_LOGIC_VECTOR(3 downto 0); -- Generate signals
    signal C : STD_LOGIC_VECTOR(4 downto 0); -- Carry signals (C(0) is Cin)

begin
    -- Connect carry-in to C(0)
    C(0) <= Cin;

    -- Generate and Propagate Signals
    gen_prop: for i in 0 to 3 generate
        P(i) <= A(i) xor B(i);
        G(i) <= A(i) and B(i);
    end generate;

    -- Compute intermediate carry signals
    C(1) <= G(0) or (P(0) and C(0));
    C(2) <= G(1) or (P(1) and C(1));
    C(3) <= G(2) or (P(2) and C(2));
    C(4) <= G(3) or (P(3) and C(3));

    -- Calculate sum bits
    S <= P xor C(3 downto 0);

    -- Group propagate and generate
    P_group <= P(0) and P(1) and P(2) and P(3);
    G_group <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0));

    -- Carry-out
    Cout <= C(4);

end Behavioral;