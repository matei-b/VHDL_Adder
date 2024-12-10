library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_4Bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input A
        B    : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input B
        Cin  : in  STD_LOGIC;                    -- Carry-in
        S    : out STD_LOGIC_VECTOR(4 downto 0); -- 5-bit sum output
        Cout : out STD_LOGIC                     -- Carry-out
    );
end CLA_4Bit;

architecture Behavioral of CLA_4Bit is
    -- Internal signals
    signal P : STD_LOGIC_VECTOR(3 downto 0); -- Propagate signals
    signal G : STD_LOGIC_VECTOR(3 downto 0); -- Generate signals
    signal C : STD_LOGIC_VECTOR(4 downto 0); -- Carry signals (C(0) is Cin)
    signal P_group : STD_LOGIC;              -- Group propagate
    signal G_group : STD_LOGIC;              -- Group generate
begin
    -- Connect carry-in to C(0)
    C(0) <= Cin;
    
    -- Instantiate 1-bit CLA sum units
    cla_inst: for i in 0 to 3 generate
        bit_adder: entity work.CLA_1Bit
            port map (
                A    => A(i),
                B    => B(i),
                Cin  => C(i),
                S    => S(i),
                P    => P(i),
                G    => G(i),
                Cout => open
            );
    end generate;

    -- Transport Anticipation Unit
    tau_inst: entity work.TAU
        port map (
            P       => P,
            G       => G,
            Cin     => C(0),
            P_group => P_group,
            G_group => G_group,
            C_out   => C(4 downto 1)
        );

    -- Assign the final carry-out to the most significant bit of the sum, in case the sum overflows
    S(4) <= C(4);
    
    -- Final Carry-Out
    Cout <= C(4);
end Behavioral;
