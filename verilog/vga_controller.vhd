library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGA_Controller is
    Port (
        clk     : in STD_LOGIC;
        hsync   : out STD_LOGIC;
        vsync   : out STD_LOGIC;
        red     : out STD_LOGIC_VECTOR (3 downto 0);
        green   : out STD_LOGIC_VECTOR (3 downto 0);
        blue    : out STD_LOGIC_VECTOR (3 downto 0)
    );
end VGA_Controller;

architecture Behavioral of VGA_Controller is
    signal h_count : INTEGER := 0;
    signal v_count : INTEGER := 0;
    constant H_SYNC_CYCLES : INTEGER := 96;
    constant H_BACK_PORCH : INTEGER := 48;
    constant H_ACTIVE : INTEGER := 640;
    constant H_FRONT_PORCH : INTEGER := 16;
    constant H_TOTAL : INTEGER := H_SYNC_CYCLES + H_BACK_PORCH + H_ACTIVE + H_FRONT_PORCH;
    
    constant V_SYNC_CYCLES : INTEGER := 2;
    constant V_BACK_PORCH : INTEGER := 33;
    constant V_ACTIVE : INTEGER := 480;
    constant V_FRONT_PORCH : INTEGER := 10;
    constant V_TOTAL : INTEGER := V_SYNC_CYCLES + V_BACK_PORCH + V_ACTIVE + V_FRONT_PORCH;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if h_count = H_TOTAL - 1 then
                h_count <= 0;
                if v_count = V_TOTAL - 1 then
                    v_count <= 0;
                else
                    v_count <= v_count + 1;
                end if;
            else
                h_count <= h_count + 1;
            end if;

            -- Horizontal Sync Pulse
            if h_count < H_SYNC_CYCLES then
                hsync <= '0';
            else
                hsync <= '1';
            end if;

            -- Vertical Sync Pulse
            if v_count < V_SYNC_CYCLES then
                vsync <= '0';
            else
                vsync <= '1';
            end if;

            -- Color Output (simple color pattern)
            if h_count < H_ACTIVE and v_count < V_ACTIVE then
                red   <= "1111";
                green <= "0000";
                blue  <= "0000";
            else
                red   <= "0000";
                green <= "0000";
                blue  <= "0000";
            end if;
        end if;
    end process;
end Behavioral;
