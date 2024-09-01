library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
    signal hours   : unsigned(7 downto 0) := (others => '0');
    signal minutes : unsigned(7 downto 0) := (others => '0');
    signal seconds : unsigned(7 downto 0) := (others => '0');
    signal alarm_time : STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
    signal one_sec_pulse : STD_LOGIC := '0';
begin
    process (clk, reset)
        variable sec_count : unsigned(24 downto 0) := (others => '0');
    begin
        if reset = '1' then
            sec_count := (others => '0');
            one_sec_pulse <= '0';
        elsif rising_edge(clk) then
            if sec_count = 49999999 then
                sec_count := (others => '0');
                one_sec_pulse <= '1';
            else
                sec_count := sec_count + 1;
                one_sec_pulse <= '0';
            end if;
        end if;
    end process;

-- Timekeeping process
    process (clk, reset)
    begin
        if reset = '1' then
            hours   <= (others => '0');
            minutes <= (others => '0');
            seconds <= (others => '0');
        elsif rising_edge(clk) then
            if one_sec_pulse = '1' then
                if seconds = 59 then
                    seconds <= (others => '0');
                    if minutes = 59 then
                        minutes <= (others => '0');
                        if hours = 23 then
                            hours <= (others => '0');
                        else
                            hours <= hours + 1;
                        end if;
                    else
                        minutes <= minutes + 1;
                    end if;
                else
                    seconds <= seconds + 1;
                end if;
            end if;
        end if;
    end process;

-- Alarm process
    process (current_time)
    begin
        if current_time = alarm_time then
            alarm <= '1';
        else
            alarm <= '0';
        end if;
    end process;

    current_time <= std_logic_vector(hours & minutes & seconds);
end Behavioral;
