library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Traffic_Light is
    Port (
        clk       : in STD_LOGIC;
        reset     : in STD_LOGIC;
        lights    : out STD_LOGIC_VECTOR (2 downto 0)  -- Red, Yellow, Green
    );
end Traffic_Light;

architecture Behavioral of Traffic_Light is
    type state_type is (RED, GREEN, YELLOW);
    signal state, next_state : state_type;
    signal timer : INTEGER := 0;

    -- Constants for timing (e.g., in clock cycles)
    constant RED_TIME : INTEGER := 50000000;  -- 50 million clock cycles
    constant GREEN_TIME : INTEGER := 50000000;  -- 50 million clock cycles
    constant YELLOW_TIME : INTEGER := 10000000;  -- 10 million clock cycles

begin
    -- FSM process
    process (clk, reset)
    begin
        if reset = '1' then
            state <= RED;
            timer <= 0;
        elsif rising_edge(clk) then
            state <= next_state;
            if timer = 0 then
                timer <= timer + 1;
            else
                timer <= timer + 1;
            end if;
        end if;
    end process;

    -- Next state logic
    process (state, timer)
    begin
        case state is
            when RED =>
                if timer = RED_TIME then
                    next_state <= GREEN;
                    timer <= 0;
                else
                    next_state <= RED;
                end if;
            when GREEN =>
                if timer = GREEN_TIME then
                    next_state <= YELLOW;
                    timer <= 0;
                else
                    next_state <= GREEN;
                end if;
            when YELLOW =>
                if timer = YELLOW_TIME then
                    next_state <= RED;
                    timer <= 0;
                else
                    next_state <= YELLOW;
                end if;
            when others =>
                next_state <= RED;
        end case;
    end process;

    -- Output logic
    process (state)
    begin
        case state is
            when RED =>
                lights <= "100";  -- Red light on
            when GREEN =>
                lights <= "001";  -- Green light on
            when YELLOW =>
                lights <= "010";  -- Yellow light on
            when others =>
                lights <= "000";  -- Default (all lights off)
        end case;
    end process;

end Behavioral;
