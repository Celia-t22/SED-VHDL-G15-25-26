----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2026 20:36:47
-- Design Name: 
-- Module Name: tb_INPUT_SEN_CNDTNR - Behavioral
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

-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Mon, 19 Jan 2026 19:33:07 GMT
-- Request id : cfwk-fed377c2-696e86f3c4889

library ieee;
use ieee.std_logic_1164.all;

entity tb_INPUT_SEN_CNDTNR is
end tb_INPUT_SEN_CNDTNR;

architecture tb of tb_INPUT_SEN_CNDTNR is

    component INPUT_SEN_CNDTNR
        port (CLK               : in std_logic;
              RESET             : in std_logic;
              S_Puerta          : in std_logic;
              S_Presencia       : in std_logic;
              S_Planta          : in std_logic_vector (3 downto 0);
              S_Puerta_Clean    : out std_logic;
              S_Presencia_Clean : out std_logic;
              S_Planta_Clean    : out std_logic_vector (3 downto 0));
    end component;

    signal CLK               : std_logic;
    signal RESET             : std_logic;
    signal S_Puerta          : std_logic;
    signal S_Presencia       : std_logic;
    signal S_Planta          : std_logic_vector (3 downto 0);
    signal S_Puerta_Clean    : std_logic;
    signal S_Presencia_Clean : std_logic;
    signal S_Planta_Clean    : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 10 ns; -- 100 MHz (Nexys A7)
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : INPUT_SEN_CNDTNR
    port map (CLK               => CLK,
              RESET             => RESET,
              S_Puerta          => S_Puerta,
              S_Presencia       => S_Presencia,
              S_Planta          => S_Planta,
              S_Puerta_Clean    => S_Puerta_Clean,
              S_Presencia_Clean => S_Presencia_Clean,
              S_Planta_Clean    => S_Planta_Clean);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- CLK is the main clock
    CLK <= TbClock;

    stimuli : process
    begin
        -- Init
        S_Puerta    <= '0';
        S_Presencia <= '0';
        S_Planta    <= (others => '0');

        -- Reset generation (activo alto)
        RESET <= '1';
        wait for 50 ns;
        RESET <= '0';
        wait for 50 ns;

        --------------------------------------------------------------------
        -- Estímulos: flanco de SUBIDA (0 -> 1) para generar evento
        -- (si tu EDGEDTCTR es de bajada, mira nota al final)
        --------------------------------------------------------------------

        -- PUERTA: 0->1->0
        S_Puerta <= '1';
        wait for 80 ns;
        S_Puerta <= '0';
        wait for 80 ns;

        -- PRESENCIA: 0->1->0
        S_Presencia <= '1';
        wait for 80 ns;
        S_Presencia <= '0';
        wait for 80 ns;

        -- PLANTA 0
        S_Planta(0) <= '1';
        wait for 80 ns;
        S_Planta(0) <= '0';
        wait for 80 ns;

        -- PLANTA 1
        S_Planta(1) <= '1';
        wait for 80 ns;
        S_Planta(1) <= '0';
        wait for 80 ns;

        -- PLANTA 2
        S_Planta(2) <= '1';
        wait for 80 ns;
        S_Planta(2) <= '0';
        wait for 80 ns;

        -- PLANTA 3
        S_Planta(3) <= '1';
        wait for 80 ns;
        S_Planta(3) <= '0';
        wait for 200 ns;

        -- Stop simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

configuration cfg_tb_INPUT_SEN_CNDTNR of tb_INPUT_SEN_CNDTNR is
    for tb
    end for;
end cfg_tb_INPUT_SEN_CNDTNR;

