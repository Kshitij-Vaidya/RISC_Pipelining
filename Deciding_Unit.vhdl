library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Deciding_Unit is
		port(	ALU_C_EX, ALU_C_EX_MEM, MEM_out_MEM, ALU_C_MEM_WB, MEM_out_MEM_WB: in std_logic_vector(15 downto 0); -- for RA RB
				Imm9_RR_EX, Imm9_EX_MEM, Imm9_MEM_WB: in std_logic_vector(8 downto 0);
				RB_C_RR_EX: in std_logic_vector(15 downto 0);
				S, S_prime: in std_logic_vector(16 downto 1);
				
				Forward_to_RA_RR, Forward_to_RB_RR, Forward_to_PC_IF: out std_logic_vector(15 downto 0);
				Forward_signal_RA_RR, Forward_signal_RB_RR, Forward_signal_PC_IF: out std_logic);
end entity Deciding_Unit;

architecture struct of Deciding_Unit is

		component MUXM15_81  is
				port (inp0, inp1, inp2, inp3, inp4, inp5, inp6, inp7: in std_logic_vector(15 downto 0); cs: in std_logic_vector(2 downto 0); outp: out std_logic_vector(15 downto 0));
		end component MUXM15_81;
		
		component MUXM15_41  is
				port (inp0, inp1, inp2, inp3: in std_logic_vector(15 downto 0); cs: in std_logic_vector(1 downto 0); outp: out std_logic_vector(15 downto 0));
		end component MuxM15_41;

		component Priority_Encoder_8_3 is
			port (
				SigIn : in std_logic_vector(7 downto 0);
				SigOut : out std_logic_vector(2 downto 0);
				V : out std_logic);
		end component Priority_Encoder_8_3;

		component Priority_Encoder_4_2 is
			port (SigIn : in std_logic_vector(3 downto 0);
				  V: out std_logic;
				  SigOut : out std_logic_vector(1 downto 0));
		  end component Priority_Encoder_4_2;

		signal MUX_sel_RA, MUX_sel_RB: std_logic_vector(2 downto 0);
		signal MUX_sel_PC: std_logic_vector(1 downto 0);

		begin
			
			RA_Encoder: Priority_Encoder_8_3 port map (	SigIn(7) => (S(5) or S(6)), SigIn(6) => S(14), SigIn(5) => (S(7) or S(8)), 
														SigIn(4) => S(15), SigIn(3) => S(12), SigIn(2) => (S(9) or S(10)), 
														SigIn(1) => S(16), SigIn(0) => S(13), SigOut => MUX_sel_RA, V => Forward_signal_RA_RR);

			RA_MUX: MUXM15_81 port map (inp0 => MEM_out_MEM_WB, inp1 => ("0000000" & Imm9_MEM_WB), inp2 => ALU_C_MEM_WB, 
										inp3 => MEM_out_MEM, inp4 => ("0000000" & Imm9_EX_MEM), 
										inp5 => ALU_C_EX_MEM, inp6 => ("0000000" & Imm9_RR_EX), inp7 => ALU_C_EX,
										cs => MUX_sel_RA, outp => Forward_to_RA_RR
										);
			
			-- Finishes forwardding logic to RA

			RB_Encoder: Priority_Encoder_8_3 port map (	SigIn(7) => (S_prime(5) or S_prime(6)), SigIn(6) => S_prime(14), 
														SigIn(5) => (S_prime(7) or S_prime(8)), SigIn(4) => S_prime(15), 
														SigIn(3) => S_prime(12), SigIn(2) => (S_prime(9) or S_prime(10)), 
														SigIn(1) => S_prime(16), SigIn(0) => S_prime(13), 
														SigOut => MUX_sel_RB, V => Forward_signal_RB_RR);

			RB_MUX: MUXM15_81 port map (inp0 => MEM_out_MEM_WB, inp1 => ("0000000" & Imm9_MEM_WB), inp2 => ALU_C_MEM_WB, 
										inp3 => MEM_out_MEM, inp4 => ("0000000" & Imm9_EX_MEM), 
										inp5 => ALU_C_EX_MEM, inp6 => ("0000000" & Imm9_RR_EX), inp7 => ALU_C_EX,
										cs => MUX_sel_RB, outp => Forward_to_RB_RR
										);
			
			-- Finishes forwarding logic to RB

			PC_encoder: Priority_Encoder_4_2 port map ( SigIn(3) => S(2), SigIn(2) => S(1), SigIn(1) => S(4),
														SigIn(0) => S(3), SigOut => MUX_sel_PC, V => Forward_signal_PC_IF);

			PC_MUX: MUXM15_41 port map (inp0 => MEM_out_MEM, inp1 => ("0000000" & Imm9_RR_EX), inp2 => RB_C_RR_EX,
										inp3 => ALU_C_EX, cs => MUX_sel_PC, outp => Forward_to_PC_IF);
										
			-- Finishes forwarding logic to PC/R0
			
end architecture;