library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Variable_PWM is
    Port (
        Dutycycle : in  STD_LOGIC_VECTOR(7 downto 0);
        clk       : in  STD_LOGIC;
        counter   : out STD_LOGIC_VECTOR(7 downto 0);
        pwmout    : out STD_LOGIC
    );
end Variable_PWM;

architecture Behavioral of Variable_PWM is

    signal counter_reg : unsigned(7 downto 0) := (others => '0');
    signal pwm_reg     : std_logic := '0';

begin

    -- expose internal counter
    counter <= std_logic_vector(counter_reg);
    pwmout  <= pwm_reg;

    ----------------------------------------------------
    -- Counter process (0..99)
    ----------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if counter_reg < 99 then
                counter_reg <= counter_reg + 1;
            else
                counter_reg <= (others => '0');
            end if;
        end if;
    end process;

    ----------------------------------------------------
    -- PWM logic
    ----------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if counter_reg < unsigned(Dutycycle) then
                pwm_reg <= '1';

            elsif counter_reg = 99 then
                pwm_reg <= '1';

            else
                pwm_reg <= '0';
            end if;
        end if;
    end process;

end Behavioral;
