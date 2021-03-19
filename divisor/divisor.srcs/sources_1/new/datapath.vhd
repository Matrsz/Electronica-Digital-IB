----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: datapath - datapath_arch                                        --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    Generic (N :integer := 4);
      Port (clk   : in  STD_LOGIC;
            A     : in  STD_LOGIC_VECTOR(N-1 downto 0);
            B     : in  STD_LOGIC_VECTOR(N-1 downto 0);
            op_sig: in  STD_LOGIC;
            start : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(N-1 downto 0);
            R     : out STD_LOGIC_VECTOR(N-1 downto 0);
            done  : out STD_LOGIC); 
end datapath;

architecture datapath_arch of datapath is
    signal zeros : STD_LOGIC_VECTOR(N-2 downto 0) := (others => '0');
    signal A_ext, B_ext : STD_LOGIC_VECTOR(2*N-2 downto 0);
    signal Q_reg : STD_LOGIC_VECTOR(N-2 downto 0);
    signal A_now, A_nxt, B_now, R_now: STD_LOGIC_VECTOR(2*N-2 downto 0);
    signal fb_ctrl : STD_LOGIC;
    signal N_now : STD_LOGIC_VECTOR(N-2 downto 0);
    
begin
    -- La estrategia es de Shift, pero a diferencia de shiftear el dividendo hacia izquierda, shiftea el divisor hacia derecha
    -- Para este motivo el divisor (B) empieza en su estado más significativo, EJ: AAAA/BBBB se alinea según
    --      000AAAA
    --      BBBB000
    A_ext <= zeros & A;
    B_ext <= B & zeros;
    
    -- A se almacena en un registro estático, con la opción de actualizarse en cada ciclo de clock habilitado
    -- La actualización se define más adelante, pero será el valor de A extendido en la inicialización, o el resto de división del paso actual
    Areg: process(clk, op_sig, start)
    begin
        if rising_edge(clk) and (op_sig='1' OR start='1') then
            A_now <=A_nxt;
        end if;
    end process;
    
    -- B se almacena en un shift register (forward), shiftea a derecha en cada ciclo de clock habilitado: BBBB000 -> 0BBBB00 > 00BBBB0 -> 000BBBB

    Breg: entity work.shift_register(forward)
        Generic map (N => 2*N-1)
        Port map (clk    => clk,
                  pll_in => B_ext,
                  load   => start,
                  ena    => op_sig,
                  ser_in => '0',
                  data   => B_now);
    
    -- Q almacena el cociente, notar que ocupa N-1 bits. El último bit no es necesario almacenarlo en el registro por que en este paso terminó la operación
    -- El registro shiftea a izquierda en cada ciclo de clock habilitado: 0 0 0 (q3) -> 0 0 q_3 (q_2) -> 0 q_3 q_2 (q_1) -> q_3 q_2 q_1 (q_0)
    Qreg: entity work.shift_register(reverse)
        Generic map (N => N-1)
        Port map (clk    => clk,
                  load   => start,
                  ena    => op_sig,
                  ser_in => fb_ctrl,
                  data   => Q_reg);
    
    -- Señales de control, fb_ctrl (feedback control) elige los dos comportamientos según la relación entre el registro actual de A y B. 
    -- R_now es el resto de división en este paso
    fb_ctrl <= '0' when unsigned(A_now) < unsigned(B_now) else '1';
    R_now   <= std_logic_vector(unsigned(A_now) - unsigned(B_now)) when fb_ctrl = '1' else A_now;
    
    A_nxt <= A_ext when start   = '1' else R_now;
    
    -- Finalmente hay que contar las iteraciones. Para ahorrar en lógica combinacional en vez de usar un contador binario
    -- uso un registro de desplazamiento que se va llenando de 1s hacia derecha en cada ciclo de clock habilitado : 000 -> 100 -> 110 -> 111
    Ncount:entity work.shift_register(forward)
        Generic map ( N => N-1)
        Port map (clk    => clk,
                  load   => start,
                  ena    => op_sig,
                  ser_in => '1',
                  data   => N_now);

    -- La salida la parte menos significativa del resto, el registro de cociente & el paso actual
    -- Y señal de finalización, que es 1 cuando el datapath no está en inicialización y el 1 llegó al LSB del registro N.
    R    <= R_now(N-1 downto 0);
    Q    <= Q_reg & fb_ctrl;
    done <= N_now(0) and not start;
end datapath_arch;
