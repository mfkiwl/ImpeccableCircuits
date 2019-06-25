----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum, Embedded Security
-- AUTHOR:		https://eprint.iacr.org/2018/203
----------------------------------------------------------------------------------
-- Copyright (c) 2019, Anita Aghaie, Amir Moradi, Aein Rezaei Shahmirzadi
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

package functions is

	function GoF_8bit (
		GTable  : STD_LOGIC_VECTOR (2047 DOWNTO 0);
		FTable  : STD_LOGIC_VECTOR (2047 DOWNTO 0))
		return STD_LOGIC_VECTOR;

	function GoF (
		GTable  : STD_LOGIC_VECTOR (63 DOWNTO 0);
		FTable  : STD_LOGIC_VECTOR (63 DOWNTO 0))
		return STD_LOGIC_VECTOR;
		
	function GetDistance (
		Red_size	 : NATURAL;
		LFTable 	 : STD_LOGIC_VECTOR (2047 DOWNTO 0))
		return NATURAL;
		
end Functions;

package body Functions is	

	function HammingWeight (
		input   : STD_LOGIC_VECTOR (15 DOWNTO 0))
		return NATURAL is
		variable res	: NATURAL;
		variable i     : NATURAL;
	begin

		res := 0;
		
		for i in 0 to 15 loop		
			res := res + to_integer( unsigned'( "" & input(i) ));
		end loop;

		return res;
	end HammingWeight;

	function GetDistance (
		Red_size	 : NATURAL;
		LFTable 	 : STD_LOGIC_VECTOR (2047 DOWNTO 0))
		return NATURAL is
		variable i,j  		: NATURAL;
		variable Distance	: NATURAL;
		variable tmp		: NATURAL;
		variable vec1		: STD_LOGIC_VECTOR(15 downto 0);
		variable vec2		: STD_LOGIC_VECTOR(15 downto 0);
		variable res		: STD_LOGIC_VECTOR(15 downto 0);
	begin
	
		Distance := 100;
		
		for i in 0 to 254 loop
			vec1 := std_logic_vector(to_unsigned(i,8)) & LFTable((2047-i*8) downto (2040-i*8));
			for j in i+1 to 255 loop
				vec2 := std_logic_vector(to_unsigned(j,8)) & LFTable((2047-j*8) downto (2040-j*8));
				
				res := vec1 XOR vec2;
				tmp := HammingWeight(res);
				if (tmp < Distance) then
					Distance := tmp;
				end if;	
			end loop;
		end loop;
			
		return Distance;	
	end GetDistance;

	-------------------
	
	function GoF (
		GTable  : STD_LOGIC_VECTOR (63 DOWNTO 0);
		FTable  : STD_LOGIC_VECTOR (63 DOWNTO 0))
		return STD_LOGIC_VECTOR is
		variable ResTable	: STD_LOGIC_VECTOR (63 DOWNTO 0);
		variable Gin   : NATURAL;
	begin
		for i in 0 to 15 loop
			Gin := to_integer(unsigned(FTable((63-i*4)   downto (60-i*4))));
			ResTable((63-i*4) downto (60-i*4)) := GTable((63-Gin*4) downto (60-Gin*4));
		end loop;
	  return ResTable;
	end Gof;
	
	-------------------------------
	function GoF_8bit (
		GTable  : STD_LOGIC_VECTOR (2047 DOWNTO 0);
		FTable  : STD_LOGIC_VECTOR (2047 DOWNTO 0))
		return STD_LOGIC_VECTOR is
		variable ResTable	: STD_LOGIC_VECTOR (2047 DOWNTO 0);
		variable Gin   : NATURAL;
	begin
		for i in 0 to 255 loop
			Gin := to_integer(unsigned(FTable((2047-i*8)   downto (2040-i*8))));
			ResTable((2047-i*8) downto (2040-i*8)) := GTable((2047-Gin*8) downto (2040-Gin*8));
		end loop;
	  return ResTable;
	end GoF_8bit;
	
end functions;

