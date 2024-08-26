library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SPI_Controller is
    Port (
        clk     : in STD_LOGIC;
        mosi    : in STD_LOGIC;
        miso    : out STD_LOGIC;
        sclk    : out STD_LOGIC;
        cs      : out STD_LOGIC
    );
end SPI_Controller;

architecture Behavioral of SPI_Controller is
    signal sclk_count : INTEGER := 0;
    signal shift_reg  : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal bit_count  : INTEGER := 0;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            sclk_count <= sclk_count + 1;
            if sclk_count = 2 then
                sclk <= not sclk;
                if sclk = '1'
