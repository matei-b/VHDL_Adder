library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TAU is
    Port (
        P      : in  STD_LOGIC_VECTOR(3 downto 0); -- Propagate signals
        G      : in  STD_LOGIC_VECTOR(3 downto 0); -- Generate signals
        Cin    : in  STD_LOGIC;                    -- Carry-in
        P_group: out STD_LOGIC;                    -- Group propagate
        G_group: out STD_LOGIC;                    -- Group generate
        C_out  : buffer STD_LOGIC_VECTOR(4 downto 1)  -- Carry outputs
    );
end TAU;

architecture Behavioral of TAU is
begin
    -- Group Propagate
    P_group <= P(3) and P(2) and P(1) and P(0);

    -- Group Generate
    G_group <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0));

    -- Carry Signals
    C_out(1) <= G(0) or (P(0) and Cin);
    C_out(2) <= G(1) or (P(1) and C_out(1));
    C_out(3) <= G(2) or (P(2) and C_out(2));
    C_out(4) <= G(3) or (P(3) and C_out(3));
end Behavioral;
