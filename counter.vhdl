library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity counter is 
    port(enable,clk,reset: in std_logic; count: out std_logic_vector(2 downto 0); end_bit: out std_logic);
end entity counter;

architecture struct of counter is 
    component JK_FLipFlop is
        port( J: in std_logic; K: in std_logic; clk: in std_logic; enable: in std_logic; Reset: in std_logic; 
                Preset: in std_logic; Q: out std_logic; Qb: out std_logic);
    end component JK_FlipFlop;
    signal Q_out: std_logic_vector(3 downto 0):="0111";
    signal Qb_out: std_logic_vector(3 downto 0):="1000";
    signal change: std_logic:='0';
    begin
        jk0: JK_FlipFlop port map(J=>'1',K=>'1',clk=>clk,enable=>enable,reset=>'0',preset=>(change or reset),Q=>Q_out(0),Qb=>Qb_out(0));
        jk1: JK_FlipFlop port map(J=>Qb_out(0),K=>Qb_out(0),clk=>clk,enable=>enable,reset=>'0',preset=>(change or reset),Q=>Q_out(1),Qb=>Qb_out(1));
        jk2: JK_FlipFlop port map(J=>(Qb_out(1) and Qb_out(0)),K=>(Qb_out(1) and Qb_out(0)),clk=>clk,enable=>enable,reset=>'0',preset=>(change or reset),Q=>Q_out(2),Qb=>Qb_out(2));
        jk3: JK_FlipFlop port map(J=>(Qb_out(1) and Qb_out(0) and Qb_out(2)),K=>(Qb_out(1) and Qb_out(0) and Qb_out(2)),clk=>clk,enable=>enable,reset=>(change or reset),preset=>'0',Q=>Q_out(3),Qb=>Qb_out(3));
        end_bit<=Q_out(3); --1-> completed
        count<=Q_out(2 downto 0);
        change<=Q_out(3);


end architecture struct;