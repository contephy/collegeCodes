library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Digital_Clock is
    Port (
        clk         : in STD_LOGIC;
        reset       : in STD_LOGIC;
        alarm_set   : in STD_LOGIC;
        current_time: out STD_LOGIC_VECTOR (23 downto 0);
        alarm       : out STD_LOGIC
    );
end Digital_Clock;

architecture Behavioral of Digital_Clock is
    signal hours   : INTEGER := 0;
    signal minutes : INTEGER := 0;
    signal seconds : INTEGER := 0;
    signal alarm_time : STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
begin
    process (clk, reset)
    begin
        if reset = '1' then
            hours   <= 0;
            minutes <= 0;
            seconds <= 0;
        elsif rising_edge(clk) then
            seconds <= seconds + 1;
            if seconds = 60 then
                seconds <= 0;
                minutes <= minutes + 1;
                if minutes = 60 then
                    minutes <= 0;
                    hours <= hours + 1;
                    if hours = 24 then
                        hours <= 0;
                    end if;
                end if;
            end if;
        end if;
    end process;

    process (current_time)
    begin
        if current_time = alarm_time then
            alarm <= '1';
        else
            alarm <= '0';
        end if;
    end process;

    current_time <= STD_LOGIC_VECTOR(to_unsigned(hours, 8) & to_unsigned(minutes, 8) & to_unsigned(seconds, 8));
end Behavioral;
