----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 10:06:14
-- Design Name: 
-- Module Name: Visualizer - Behavioral
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

entity Visualizer is
    Port ( 
        CLK       : in  STD_LOGIC;
        RESET_N   : in  STD_LOGIC;
        
        -- Entradas de datos (Lo que queremos mostrar en cada display)
        -- Conectaremos esto más tarde a la FSM o a los botones
        DIGIT_0   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_1   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_2   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_3   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_4   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_5   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_6   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_7   : in  STD_LOGIC_VECTOR (3 downto 0);
        
        -- Salidas físicas a la placa Nexys A7
        ANODES    : out STD_LOGIC_VECTOR (7 downto 0); -- Qué display se enciende
        SEGMENTS  : out STD_LOGIC_VECTOR (6 downto 0)  -- Qué número se dibuja (CA, CB... CG)
    );
end Visualizer;

architecture Behavioral of Visualizer is

    -- 1. Declaramos los componentes (Los ingredientes)
    component timer
        Port ( clk : in STD_LOGIC; reset_n : in STD_LOGIC; strobe : out STD_LOGIC );
    end component;

    component scanner
        Port ( clk : in STD_LOGIC; reset_n : in STD_LOGIC; ce : in STD_LOGIC; 
               sel : out STD_LOGIC_VECTOR(2 downto 0); anodes : out STD_LOGIC_VECTOR(7 downto 0) );
    end component;

    component muxer
        Port ( sel : in STD_LOGIC_VECTOR(2 downto 0); 
               digit_0, digit_1, digit_2, digit_3, digit_4, digit_5, digit_6, digit_7 : in STD_LOGIC_VECTOR(3 downto 0);
               bcd_out : out STD_LOGIC_VECTOR(3 downto 0) );
    end component;

    component bin2seg
        Port ( binary_in : in STD_LOGIC_VECTOR(3 downto 0); segments : out STD_LOGIC_VECTOR(6 downto 0) );
    end component;

    -- 2. Declaramos los CABLES INTERNOS (Signals)
    signal s_strobe  : STD_LOGIC;                     -- Cable del Timer al Scanner
    signal s_sel     : STD_LOGIC_VECTOR(2 downto 0);  -- Cable del Scanner al Muxer
    signal s_bcd_out : STD_LOGIC_VECTOR(3 downto 0);  -- Cable del Muxer al Bin2Seg

begin

    -- 3. Conectamos todo (Instanciación)
    
    -- El Metrónomo
    Inst_Timer: timer Port Map (
        clk     => CLK,
        reset_n => RESET_N,
        strobe  => s_strobe    -- Sale el pulso hacia el cable interno
    );

    -- El Director de Orquesta
    Inst_Scanner: scanner Port Map (
        clk     => CLK,
        reset_n => RESET_N,
        ce      => s_strobe,   -- Recibe el pulso del Timer
        sel     => s_sel,      -- Manda la orden de selección al cable interno
        anodes  => ANODES      -- Salida directa a la placa
    );

    -- El Guardagujas
    Inst_Muxer: muxer Port Map (
        sel     => s_sel,      -- Recibe la orden del Scanner
        digit_0 => DIGIT_0,    -- Entradas externas
        digit_1 => DIGIT_1,
        digit_2 => DIGIT_2,
        digit_3 => DIGIT_3,
        digit_4 => DIGIT_4,
        digit_5 => DIGIT_5,
        digit_6 => DIGIT_6,
        digit_7 => DIGIT_7,
        bcd_out => s_bcd_out   -- El dato elegido viaja al Bin2Seg
    );

    -- El Traductor
    Inst_Bin2Seg: bin2seg Port Map (
        binary_in => s_bcd_out, -- Recibe el dato del Muxer
        segments  => SEGMENTS   -- Salida directa a la placa
    );

end Behavioral;