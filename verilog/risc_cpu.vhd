library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RISC_CPU is
    Port (
        clk     : in STD_LOGIC;
        reset   : in STD_LOGIC;
        instr   : in STD_LOGIC_VECTOR (31 downto 0);
        result  : out STD_LOGIC_VECTOR (31 downto 0)
    );
end RISC_CPU;

architecture Behavioral of RISC_CPU is
    signal reg_file : STD_LOGIC_VECTOR (31 downto 0);
    signal alu_out  : STD_LOGIC_VECTOR (31 downto 0);
    signal pc       : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

    -- ALU Operations
    function ALU (op1, op2 : STD_LOGIC_VECTOR; op : INTEGER) return STD_LOGIC_VECTOR is
    begin
        case op is
            when 0 => return op1 + op2; -- Addition
            when 1 => return op1 - op2; -- Subtraction
            when others => return (others => '0');
        end case;
    end function;

begin
    process (clk, reset)
    begin
        if reset = '1' then
            reg_file <= (others => '0');
            pc <= (others => '0');
        elsif rising_edge(clk) then
            -- Decode instruction (simplified)
            if instr(31 downto 26) = "000000" then -- ADD
                alu_out <= ALU(reg_file, instr(15 downto 0), 0);
            elsif instr(31 downto 26) = "000001" then -- SUB
                alu_out <= ALU(reg_file, instr(15 downto 0), 1);
            end if;
            reg_file <= alu_out;
            pc <= pc + 1;
        end if;
    end process;

    result <= reg_file;
end Behavioral;
