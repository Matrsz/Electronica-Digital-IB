----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: FSM - FSM_arch/FSM_alt                                          --
-- Revision 0.01 - File Created                                                 --
-- Revision 0.02 - FSM_alt implementation                                       --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    port (clk: in  STD_LOGIC;
          rst: in  STD_LOGIC;
          A: in  STD_LOGIC;
          B: in  STD_LOGIC;
          entr_sig: out STD_LOGIC;
          exit_sig: out STD_LOGIC;
          ctrl: out STD_LOGIC_VECTOR(1 downto 0));
end entity;

architecture FSM_arch of FSM is
    type state_type is (wait_q, entr_q, exit_q);
    signal Q_now, Q_next : state_type;
begin
    -- Memoria sincrónica
    sync: process(clk, rst, A, B)
    begin
        if (rst = '1') then
            Q_now <= wait_q;
        elsif rising_edge(clk) then
            Q_now <= Q_next;
        end if;
    end process;
    -- Lógica combinacional estado siguiente 
    nxt: process(Q_now, A, B)
    begin
        Q_next <= Q_now;
        case Q_now is
            when wait_q => if A='1' AND B='0' then
                              Q_next <= entr_q;
                           elsif A='0' AND B='1' then
                              Q_next <= exit_q;
                           end if;
            when entr_q => if A='1' NAND B='0' then
                              Q_next <= wait_q;
                           end if;
            when exit_q => if A='0' NAND B='1' then
                              Q_next <= wait_q;
                           end if;
        end case;
   end process;
   -- Lógica combinacional salida
   with Q_now select ctrl <= "00" when wait_q,
                             "01" when entr_q,
                             "10" when exit_q;
   entr_sig <= '1' when Q_now=entr_q AND A='1' AND B='1' else '0';
   exit_sig <= '1' when Q_now=exit_q AND A='1' AND B='1' else '0';
end architecture;

architecture FSM_alt of FSM is
    type state_type is (wait_q, entr_x, entr_v, exit_x, exit_v);
    signal Q_now, Q_next : state_type;
begin
    -- Memoria sincrónica
    sync: process(clk, rst, A, B)
    begin
        if (rst = '1') then
            Q_now <= wait_q;
        elsif rising_edge(clk) then
            Q_now <= Q_next;
        end if;
    end process;
    -- Lógica combinacional estado siguiente 
    nxt: process(Q_now, A, B)
    begin
        if A='0' AND B='0' then
            Q_next <= wait_q;
        else
            Q_next <= Q_now;
        end if;
        case Q_now is
            when wait_q => if A='1' AND B='0' then
                              Q_next <= entr_x;
                           elsif A='0' AND B='1' then
                              Q_next <= exit_x;
                           end if;
            when entr_x => if A='0' AND B = '1' then
                              Q_next <= entr_v;
                           end if;
            when entr_v => if A='1' AND B = '1' then
                              Q_next <= entr_x;
                           end if;
            when exit_x => if A='1' AND B = '0' then
                              Q_next <= exit_v;
                           end if;
            when exit_v => if A='1' AND B = '1' then
                              Q_next <= exit_x;
                           end if;
        end case;
   end process;
   -- Lógica combinacional salida
   with Q_now select ctrl <= "ZZ" when wait_q,
                             "00" when entr_x,
                             "01" when entr_v,  
                             "10" when exit_x,
                             "11" when exit_v;  
   entr_sig <= '1' when Q_now = entr_v AND A='0' AND B='0' else '0';
   exit_sig <= '1' when Q_now = exit_v AND A='0' AND B='0' else '0';
end architecture;