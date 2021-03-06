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

ENTITY Red_MC IS
	GENERIC ( size 		: POSITIVE;
				 Table 		: STD_LOGIC_VECTOR(63 downto 0);
				 LFTable 	: STD_LOGIC_VECTOR(63 downto 0);
				 LFC			: STD_LOGIC_VECTOR( 3 downto 0));
	PORT ( state  		: IN  STD_LOGIC_VECTOR (4*4-1    DOWNTO 0);
			 result 		: OUT STD_LOGIC_VECTOR (4*size-1 DOWNTO 0));
END Red_MC;

ARCHITECTURE behavioral OF Red_MC IS	
	signal s0, s1, s2, s3    				 	: STD_LOGIC_VECTOR (4-1    DOWNTO 0);
	signal r0, r1, r2, r3     					: STD_LOGIC_VECTOR (size-1 DOWNTO 0);

BEGIN

	s0 <= state(4*4-1   downto  4*3);
	s1 <= state(4*3-1   downto  4*2);
	s2 <= state(4*2-1   downto  4*1);
	s3 <= state(4*1-1   downto  4*0);

	------------------------------------------
	
	MC0: entity work.Red_MixOneColumn
	GENERIC Map ( size, Table, LFTable, LFC)
	PORT Map( s0, s1, s2, s3, r0, r1, r2, r3);

	------------------------------------------
	
	result <= r0 & r1 & r2 & r3;

END behavioral;

