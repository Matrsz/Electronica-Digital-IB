----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: shift_register - forward / reverse                              --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

    -- Esta instancia es de un shift register sincrónico de N bits, dos inputs
    -- Input en serie, input en paralelo, habilitación de desplazamiento, reset asincrónico e instrucción de carga paralela
    -- La dirección de despazamiento está determinada por la arquitectura de la instancia
    
entity shift_register is
    Generic (N: integer := 8);
    Port (ser_in: in  STD_LOGIC := '0';
          pll_in: in  STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0'); 
          load  : in  STD_LOGIC := '0';
          clk   : in  STD_LOGIC;
          ena   : in  STD_LOGIC := '1';
          rst   : in  STD_LOGIC := '0';
          data  : out STD_LOGIC_VECTOR(N-1 downto 0));
end shift_register;

    -- La arquitectura forward instancia un registro de desplazamiento hacia derecha
    -- Los bits desplazan hacia derecha en cada iteración y la entrada en serie ocupa el MSB
architecture forward of shift_register is
    signal data_nxt, data_now : STD_LOGIC_VECTOR(N-1 downto 0);
begin
    sync: process(clk, rst)
    begin
        if rst = '1' then 
            data_now <= (others => '0');
        elsif rising_edge(clk) then
            data_now <= data_nxt;
        end if;
    end process; 
    data_nxt <= pll_in                          when load = '1' else
                data_now                        when ena  = '0' else
                ser_in & data_now(N-1 downto 1);     
    data <= data_now;
end architecture;

    -- La arquitectura reverse instancia un registro de desplazamiento hacia izquierda
    -- Los bits desplazan hacia izquierda en cada iteración y la entrada en serie reemplaza el LSB
architecture reverse of shift_register is
    signal data_nxt, data_now : STD_LOGIC_VECTOR(N-1 downto 0);
begin
    sync: process(clk, rst)
    begin
        if rst = '1' then 
            data_now <= (others => '0');
        elsif rising_edge(clk) then
            data_now <= data_nxt;
        end if;
    end process;    
    data_nxt <= pll_in                          when load = '1' else
                data_now                        when ena  = '0' else
                data_now(N-2 downto 0) & ser_in;
    data <= data_now;
end architecture;
