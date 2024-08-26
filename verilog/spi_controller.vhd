library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SPI_Controller is
    Port (
        clk         : in  STD_LOGIC;               -- System clock
        rst         : in  STD_LOGIC;               -- Reset signal
        mosi        : out STD_LOGIC;               -- Master Out Slave In
        miso        : in  STD_LOGIC;               -- Master In Slave Out
        sclk        : out STD_LOGIC;               -- SPI Clock
        cs          : out STD_LOGIC;               -- Chip Select
        data_in     : in  STD_LOGIC_VECTOR(7 downto 0); -- Data to be transmitted
        data_out    : out STD_LOGIC_VECTOR(7 downto 0); -- Received data
        start       : in  STD_LOGIC;               -- Start signal
        done        : out STD_LOGIC                -- Done signal
    );
end SPI_Controller;

architecture Behavioral of SPI_Controller is
    type state_type is (IDLE, TRANSMIT, RECEIVE, DONE); -- Define the states
    signal state, next_state : state_type;               -- State signals
    signal sclk_reg : STD_LOGIC := '0';                  -- SPI clock register
    signal bit_cnt : INTEGER range 0 to 7 := 0;          -- Bit counter
    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0);     -- Shift register for data transmission
    signal received_data : STD_LOGIC_VECTOR(7 downto 0); -- Register for received data

    constant clk_div : INTEGER := 4;                    -- Clock divider for SPI clock generation
    signal clk_cnt : INTEGER range 0 to clk_div-1 := 0;  -- Clock counter

begin
    -- SPI clock generation process
    process(clk, rst)
    begin
        if rst = '1' then
            clk_cnt <= 0;
            sclk_reg <= '0';
        elsif rising_edge(clk) then
            if clk_cnt = clk_div/2-1 then
                sclk_reg <= not sclk_reg; -- Toggle the SPI clock
                clk_cnt <= 0;
            else
                clk_cnt <= clk_cnt + 1;
            end if;
        end if;
    end process;
    sclk <= sclk_reg; -- Assign the SPI clock to the output port

    -- Main FSM process
    process(clk, rst)
    begin
        if rst = '1' then
            state <= IDLE;
            shift_reg <= (others => '0');
            received_data <= (others => '0');
            bit_cnt <= 0;
            cs <= '1'; -- Chip select inactive
            done <= '0';
        elsif rising_edge(clk) then
            state <= next_state;

            case state is
                when IDLE =>
                    done <= '0';
                    cs <= '1'; -- Chip select inactive
                    if start = '1' then
                        shift_reg <= data_in; -- Load data to be transmitted
                        bit_cnt <= 0;
                        cs <= '0'; -- Chip select active
                    end if;

                when TRANSMIT =>
                    if sclk_reg = '0' then
                        mosi <= shift_reg(7); -- Transmit the MSB
                        shift_reg <= shift_reg(6 downto 0) & '0'; -- Shift left
                    end if;
                    if sclk_reg = '1' then
                        received_data <= received_data(6 downto 0) & miso; -- Shift in received data
                        bit_cnt <= bit_cnt + 1;
                        if bit_cnt = 7 then
                            next_state <= DONE; -- Move to DONE state after 8 bits
                        end if;
                    end if;

                when DONE =>
                    cs <= '1'; -- Chip select inactive
                    done <= '1'; -- Indicate that transmission is complete
                    data_out <= received_data; -- Output the received data

                when others =>
                    next_state <= IDLE;
            end case;
        end if;
    end process;

    -- Next state logic
    process(state, start, bit_cnt)
    begin
        case state is
            when IDLE =>
                if start = '1' then
                    next_state <= TRANSMIT;
                else
                    next_state <= IDLE;
                end if;

            when TRANSMIT =>
                if bit_cnt = 7 then
                    next_state <= DONE;
                else
                    next_state <= TRANSMIT;
                end if;

            when DONE =>
                next_state <= IDLE;

            when others =>
                next_state <= IDLE;
        end case;
    end process;
end Behavioral;
