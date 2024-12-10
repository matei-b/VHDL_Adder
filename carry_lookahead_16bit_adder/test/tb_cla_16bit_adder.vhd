library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_16Bit_tb is
end CLA_16Bit_tb;

architecture Behavioral of CLA_16Bit_tb is
    -- Signals for inputs and outputs
    signal A    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal B    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal Cin  : STD_LOGIC := '0';
    signal S    : STD_LOGIC_VECTOR(16 downto 0); -- 17-bit sum
    signal Cout : STD_LOGIC;

begin
    -- Instantiate the 16-bit CLA Adder
    uut: entity work.CLA_16Bit
        port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            S    => S,
            Cout => Cout
        );

    -- Test process
    process
    begin
        -- Test Case 1
        A <= "0000000000000011"; -- 3
        B <= "0000000000000101"; -- 5
        Cin <= '0';
        wait for 100 ns;
        assert (S = "00000000000001000") report "Test Case 1 Failed" severity error;

        -- Test Case 2
        A <= "0000000000001100"; -- 12
        B <= "0000000000001010"; -- 10
        Cin <= '1';
        wait for 100 ns;
        assert (S = "00000000000010111") report "Test Case 2 Failed" severity error;

        -- Test Case 3
        A <= "1111111111111111"; -- 65535
        B <= "0000000000000001"; -- 1
        Cin <= '0';
        wait for 100 ns;
        assert (S = "10000000000000000") report "Test Case 3 Failed" severity error;

        -- Test Case 4
        A <= "0000000000000000"; -- 0
        B <= "0000111100001111"; -- 3855
        Cin <= '0';
        wait for 100 ns;
        assert (S = "00000111100001111") report "Test Case 4 Failed" severity error;

        report "All tests completed successfully!" severity note;
        wait;
    end process;
end Behavioral;