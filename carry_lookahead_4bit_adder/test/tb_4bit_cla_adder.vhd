library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_4Bit_TB is
end CLA_4Bit_TB;

architecture Behavioral of CLA_4Bit_TB is
    -- Signals for inputs and outputs
    signal A, B : std_logic_vector(3 downto 0);
    signal Cin  : std_logic;
    signal S    : std_logic_vector(4 downto 0);
    signal Cout : std_logic;
begin
    -- Instantiate the 4-bit CLA Adder
    uut: entity work.CLA_4Bit
        port map (
            A => A,
            B => B,
            Cin => Cin,
            S => S,
            Cout => Cout
        );

    -- Test process
    process
    begin
        -- Test case 1
        A <= "0001"; -- 1
        B <= "0001"; -- 1
        Cin <= '0';
        wait for 10 ns;
        assert (S = "00010" and Cout = '0') report "Test 1 failed" severity error;

        -- Test case 2
        A <= "0010"; -- 2
        B <= "0011"; -- 3
        Cin <= '0';
        wait for 10 ns;
        assert (S = "00101" and Cout = '0') report "Test 2 failed" severity error;

        -- Test case 3
        A <= "0100"; -- 4
        B <= "0100"; -- 4
        Cin <= '0';
        wait for 10 ns;
        assert (S = "01000" and Cout = '0') report "Test 3 failed" severity error;

        -- Test case 4
        A <= "1111"; -- 15
        B <= "0001"; -- 1
        Cin <= '0';
        wait for 10 ns;
        assert (S = "10000" and Cout = '1') report "Test 4 failed" severity error;
        
        -- Test case 5 (with initial carry-in bit)
        A <= "1111"; -- 15
        B <= "0000"; -- 0
        Cin <= '1';
        wait for 10 ns;
        assert (S = "10000" and Cout = '1') report "Test 5 failed" severity error;

        -- Test case 6
        A <= "1010"; -- 10
        B <= "1010"; -- 10
        Cin <= '0';
        wait for 10 ns;
        assert (S = "10100" and Cout = '1') report "Test 6 failed" severity error;

        report "All tests completed successfully!" severity note;
        wait;
    end process;
end Behavioral;
