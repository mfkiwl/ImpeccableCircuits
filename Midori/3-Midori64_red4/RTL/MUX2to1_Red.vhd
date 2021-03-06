----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum, Embedded Security
-- AUTHOR:		https://eprint.iacr.org/2018/203
----------------------------------------------------------------------------------
-- Copyright (c) 2019, Anita Aghaie, Amir Moradi
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

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MUX2to1_Red IS
	GENERIC (LFTable : STD_LOGIC_VECTOR(63 downto 0));
	PORT ( sel 	: IN  STD_LOGIC_VECTOR(3 downto 0);
			 D0   : IN  STD_LOGIC;
			 D1 	: IN  STD_LOGIC;
			 Q 	: OUT STD_LOGIC);
END MUX2to1_Red;

ARCHITECTURE behavioral OF MUX2to1_Red IS

	signal input          : STD_LOGIC_VECTOR(15 downto 0);
	
	signal Q0, Q1, Q2, Q3, Q4, Q5   : STD_LOGIC;
	signal Q6, Q7, Q8, Q9, Q10, Q11 : STD_LOGIC;
	signal Q12, Q13                 : STD_LOGIC;

	constant LF0			 : NATURAL := to_integer(unsigned(LFTable(63 downto 60)));
	constant LF1			 : NATURAL := to_integer(unsigned(LFTable(59 downto 56)));

BEGIN

	GEN :
	FOR i IN 0 TO 15 GENERATE
		GEN1: 
		IF i=LF0 GENERATE
			input(i) <= D0;
		END GENERATE;

		GEN2: 
		IF i=LF1 GENERATE
			input(i) <= D1;
		END GENERATE;

		GEN3:
		IF (i /= LF0) and (i /= LF1) GENERATE
			input(i) <= '0';
		END GENERATE;
	END GENERATE;

	MUXInst_1: ENTITY work.MUX2to1
	PORT Map (sel(0), input(0), input(1), Q0);

	MUXInst_2: ENTITY work.MUX2to1
	PORT Map (sel(0), input(2), input(3), Q1);
	
	MUXInst_3: ENTITY work.MUX2to1
	PORT Map (sel(0), input(4), input(5), Q2);

	MUXInst_4: ENTITY work.MUX2to1
	PORT Map (sel(0), input(6), input(7), Q3);
	
	MUXInst_5: ENTITY work.MUX2to1
	PORT Map (sel(0), input(8), input(9), Q4);

	MUXInst_6: ENTITY work.MUX2to1
	PORT Map (sel(0), input(10), input(11), Q5);
	
	MUXInst_7: ENTITY work.MUX2to1
	PORT Map (sel(0), input(12), input(13), Q6);

	MUXInst_8: ENTITY work.MUX2to1
	PORT Map (sel(0), input(14), input(15), Q7);

	--------------
	
	MUXInst_9: ENTITY work.MUX2to1
	PORT Map (sel(1), Q0, Q1, Q8);

	MUXInst_10: ENTITY work.MUX2to1
	PORT Map (sel(1), Q2, Q3, Q9);

	MUXInst_11: ENTITY work.MUX2to1
	PORT Map (sel(1), Q4, Q5, Q10);

	MUXInst_12: ENTITY work.MUX2to1
	PORT Map (sel(1), Q6, Q7, Q11);

	---------------
	
	MUXInst_13: ENTITY work.MUX2to1
	PORT Map (sel(2), Q8, Q9, Q12);
	
	MUXInst_14: ENTITY work.MUX2to1
	PORT Map (sel(2), Q10, Q11, Q13);

	---------------
	
	MUXInst_15: ENTITY work.MUX2to1
	PORT Map (sel(3), Q12, Q13, Q);

END;

