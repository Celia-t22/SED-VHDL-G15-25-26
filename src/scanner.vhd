----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 09:49:04
-- Design Name: 
-- Module Name: scanner - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necesaria para sumar números (count + 1)

entity scanner is
    Port ( 
        clk     : in  STD_LOGIC;
        reset_n : in  STD_LOGIC;
        ce      : in  STD_LOGIC;                     -- Chip Enable (vendrá del Timer)
        sel     : out STD_LOGIC_VECTOR (2 downto 0); -- Para el Muxer (0 a 7)
        anodes  : out STD_LOGIC_VECTOR (7 downto 0)  -- Para la placa (fisico)
    );
end scanner;

architecture Behavioral of scanner is
    -- Señal interna para llevar la cuenta
    signal count : unsigned(2 downto 0);
begin

    -- 1. Proceso del contador
    process(clk, reset_n)
    begin
        if reset_n = '0' then
            count <= "000"; -- Reset a 0
        elsif rising_edge(clk) then
            if ce = '1' then -- Solo contamos si el Timer nos da permiso
                count <= count + 1;
            end if;
        end if;
    end process;

    -- 2. Conectamos el contador a la salida SEL
    sel <= std_logic_vector(count);

    -- 3. Decodificador para los Ánodos (Activos a nivel BAJO '0')
    process(count)
    begin
        case count is
            when "000" => anodes <= "11111110"; -- Enciende el dígito 0 (derecha)
            when "001" => anodes <= "11111101"; -- Enciende el dígito 1
            when "010" => anodes <= "11111011";
            when "011" => anodes <= "11110111";
            when "100" => anodes <= "11101111";
            when "101" => anodes <= "11011111";
            when "110" => anodes <= "10111111";
            when "111" => anodes <= "01111111"; -- Enciende el dígito 7 (izquierda)
            when others => anodes <= "11111111"; -- Todos apagados por si acaso
        end case;
    end process;

end Behavioral;