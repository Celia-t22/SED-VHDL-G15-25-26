library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity scanner is
    Port ( 
        clk     : in  STD_LOGIC;
        reset_n : in  STD_LOGIC;
        ce      : in  STD_LOGIC;
        sel     : out STD_LOGIC_VECTOR (2 downto 0);
        anodes  : out STD_LOGIC_VECTOR (7 downto 0)
    );
end scanner;

architecture Behavioral of scanner is
    signal count     : unsigned(2 downto 0) := (others => '0');
    signal sel_r     : std_logic_vector(2 downto 0) := (others => '0');
    signal anodes_r  : std_logic_vector(7 downto 0) := (others => '1');
begin

    process(clk, reset_n)
    begin
        if reset_n = '0' then
            count    <= (others => '0');
            sel_r    <= "000";
            anodes_r <= "11111111";
        elsif rising_edge(clk) then

            if ce = '1' then
                count <= count + 1;
            end if;

            sel_r <= std_logic_vector(count);

            case to_integer(count) is
                when 0 => anodes_r <= "11111110";
                when 1 => anodes_r <= "11111101";
                when 2 => anodes_r <= "11111011";
                when 3 => anodes_r <= "11110111";
                when 4 => anodes_r <= "11101111";
                when 5 => anodes_r <= "11011111";
                when 6 => anodes_r <= "10111111";
                when 7 => anodes_r <= "01111111";
                when others => anodes_r <= "11111111";
            end case;

        end if;
    end process;

    sel    <= sel_r;
    anodes <= anodes_r;

end Behavioral;


