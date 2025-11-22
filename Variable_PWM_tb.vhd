library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Variable_PWM_tb is
end Variable_PWM_tb;

architecture Behavioral of Variable_PWM_tb is

    -- DUT signals
    signal Dutycycle : std_logic_vector(7 downto 0) := (others => '0');
    signal clk       : std_logic := '1';
    signal counter   : std_logic_vector(7 downto 0);
    signal pwmout    : std_logic;

begin

    --------------------------------------------------------------------
    -- DUT instantiation
    --------------------------------------------------------------------
    dut: entity work.Variable_PWM
        port map (
            Dutycycle => Dutycycle,
            clk       => clk,
            counter   => counter,
            pwmout    => pwmout
        );

    --------------------------------------------------------------------
    -- Clock generation (20 ns period, 50% duty cycle)
    --------------------------------------------------------------------
    clk_process : process
    begin
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
    end process;

    --------------------------------------------------------------------
    -- Dutycycle stimulus
    --------------------------------------------------------------------
    stim_proc : process
    begin

        Dutycycle <= x"28";     -- 40
        wait for 2000 ns;


        wait;  -- Equivalent to $finish
    end process;

end Behavioral;
