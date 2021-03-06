----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum, Embedded Security
-- AUTHOR:		https://eprint.iacr.org/2018/203
----------------------------------------------------------------------------------
-- Copyright (c) 2019, Amir Moradi
-- All rights reserved.

-- BSD-3-Clause License
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.
--     * Redistributions in binary form must reproduce the above copyright
--       notice, this list of conditions and the following disclaimer in the
--       documentation and/or other materials provided with the distribution.
--     * Neither the name of the copyright holder, their organization nor the
--       names of its contributors may be used to endorse or promote products
--       derived from this software without specific prior written permission.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTERS BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.functions.all;

entity Red_MakeRoundConst is
	GENERIC ( size 		: POSITIVE;
				 LFTable 	: STD_LOGIC_VECTOR(63 downto 0));
    Port ( FSM   						: in   STD_LOGIC_VECTOR (4        downto 0);
			  Red_FSM   				: in   STD_LOGIC_VECTOR (size*2-1 downto 0);
			  Red_RoundConstLeft 	: out  STD_LOGIC_VECTOR (size*4-1 downto 0);
			  Red_RoundConstRight	: out  STD_LOGIC_VECTOR (size*4-1 downto 0));
end Red_MakeRoundConst;

architecture Behavioral of Red_MakeRoundConst is
begin

	GENLeft :
	FOR i IN 0 TO size-1 GENERATE
		Red_RoundConstLeftInst1: ENTITY work.LookUp
		GENERIC Map (size => 5, Table => MakeRedRoundConstLeftTable(i, LFTable))
		PORT Map (FSM, Red_RoundConstLeft(i));
		
		Red_RoundConstLeftInst2: ENTITY work.LookUp
		GENERIC Map (size => 5, Table => MakeRedRoundConstLeftTable(4+i, LFTable))
		PORT Map (FSM, Red_RoundConstLeft(size+i));

		Red_RoundConstLeftInst3: ENTITY work.LookUp
		GENERIC Map (size => 5, Table => MakeRedRoundConstLeftTable(8+i, LFTable))
		PORT Map (FSM, Red_RoundConstLeft(size*2+i));

		Red_RoundConstLeftInst4: ENTITY work.LookUp
		GENERIC Map (size => 5, Table => MakeRedRoundConstLeftTable(12+i, LFTable))
		PORT Map (FSM, Red_RoundConstLeft(size*3+i));
	END GENERATE;
	
	----

	Red_RoundConstRight(size*2-1 downto 0) <= Red_FSM;

	GENRight :
	FOR i IN 0 TO size-1 GENERATE
		Red_RoundConstRightInst3: ENTITY work.LookUp
		GENERIC Map (size => 5, Table => MakeRedRoundConstRightTable(8+i, LFTable))
		PORT Map (FSM, Red_RoundConstRight(size*2+i));

		Red_RoundConstRightInst4: ENTITY work.LookUp
		GENERIC Map (size => 5, Table => MakeRedRoundConstRightTable(12+i, LFTable))
		PORT Map (FSM, Red_RoundConstRight(size*3+i));
	END GENERATE;
	
end Behavioral;

