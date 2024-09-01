library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Traffic_Light is
    Port (
        clk       : in STD_LOGIC;
        reset     : in STD_LOGIC;
        lights    : out STD_LOGIC_VECTOR (2 downto 0)
    );
end Traffic_Light;

architecture Behavioral of Traffic_Light is
    type state_type is (RED, GREEN, YELLOW);
    signal state : state_type := RED;
    signal counter : INTEGER := 0;

    constant RED_TIME : INTEGER := 50000000;   
    constant GREEN_TIME : INTEGER := 50000000; 
    constant YELLOW_TIME : INTEGER := 10000000; 

begin
    process (clk, reset)
    begin
        if reset = '1' then
            state <= RED;
            counter <= 0;
        elsif rising_edge(clk) then
            case state is
                when RED =>
                    if counter = RED_TIME then
                        state <= GREEN;
                        counter <= 0;
                    else
                        counter <= counter + 1;
                    end if;
                when GREEN =>
                    if counter = GREEN_TIME then
                        state <= YELLOW;
                        counter <= 0;
                    else
                        counter <= counter + 1;
                    end if;
                when YELLOW =>
                    if counter = YELLOW_TIME then
                        state <= RED;
                        counter <= 0;
                    else
                        counter <= counter + 1;
                    end if;
            end case;
        end if;
    end process;

    lights <= "100" when state = RED else
              "001" when state = GREEN else
              "010" when state = YELLOW else
              "000";

end Behavioral;
