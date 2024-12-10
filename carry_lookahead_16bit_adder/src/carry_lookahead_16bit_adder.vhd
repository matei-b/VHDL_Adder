library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Top-level 16-bit CLA Entity
entity CLA_16Bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit input A
        B    : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit input B
        Cin  : in  STD_LOGIC;                     -- Carry-in
        S    : out STD_LOGIC_VECTOR(16 downto 0); -- 17-bit sum output
        Cout : out STD_LOGIC                      -- Carry-out
    );
end CLA_16Bit;

architecture Structural of CLA_16Bit is
    -- Internal signals
    signal P : STD_LOGIC_VECTOR(3 downto 0); -- Propagate signals
    signal G : STD_LOGIC_VECTOR(3 downto 0); -- Generate signals
    signal C : STD_LOGIC_VECTOR(4 downto 0); -- Carry signals between blocks
    signal P_group : STD_LOGIC;              -- Propagate signals from CLA_4Bit blocks
    signal G_group : STD_LOGIC;              -- Generate signals from CLA_4Bit blocks

    -- Carry-out signals from the TAU
    signal TAU_C_out : STD_LOGIC_VECTOR(3 downto 0);
begin
    -- Connect the initial carry-in
    C(0) <= Cin;

    -- Instantiate CLA_4Bit blocks
    cla_inst: for i in 0 to 3 generate
        cla_4bit: entity work.CLA_4Bit
            port map (
                A       => A((4 * i + 3) downto (4 * i)),
                B       => B((4 * i + 3) downto (4 * i)),
                Cin     => C(i),
                S       => S((4 * i + 3) downto (4 * i)),
                P_group => P(i),
                G_group => G(i),
                Cout    => open
            );
    end generate;

    -- Instantiate the TAU
    tau_unit: entity work.TAU
        port map (
            P       => P,
            G       => G,
            Cin     => C(0),
            P_group => P_group,
            G_group => G_group,
            C_out   => TAU_C_out
        );

    -- Connect TAU-generated carries to the CLA_4Bit blocks
    C(1) <= TAU_C_out(0);
    C(2) <= TAU_C_out(1);
    C(3) <= TAU_C_out(2);
    C(4) <= TAU_C_out(3);

    -- Assign the most significant bit of S to the final carry-out
    S(16) <= C(4);

    -- Connect the final carry-out
    Cout <= C(4);

end Structural;
