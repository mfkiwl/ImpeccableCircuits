----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum, Embedded Security
-- AUTHOR:		https://doi.org/10.13154/tosc.v2019.i1.5-45 
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

entity StateUpdateBit is
	 Generic ( 
		withDec 		: integer;
		BitNumber 	: integer);
    Port ( FSM       	: in  STD_LOGIC_VECTOR (7 downto 0);
			  EncDec			: in  STD_LOGIC;
           FSMUpdateBit : out STD_LOGIC);
end StateUpdateBit;

architecture Behavioral of StateUpdateBit is
begin

	GenwithoutDec: IF withDec = 0 GENERATE
		Gen0: IF BitNumber = 0 GENERATE
			FSMUpdateBit <= FSM(1) WHEN FSM(3) = '1' ELSE FSM(0);
		END GENERATE;	
		
		Gen1: IF BitNumber = 1 GENERATE
			FSMUpdateBit <= FSM(2) WHEN FSM(3) = '1' ELSE FSM(1);
		END GENERATE;	
		
		Gen2: IF BitNumber = 2 GENERATE
			FSMUpdateBit <= (FSM(0) XOR FSM(1)) WHEN FSM(3) = '1' ELSE FSM(2);
		END GENERATE;	

		Gen3: IF BitNumber = 3 GENERATE
			FSMUpdateBit <= NOT FSM(3);
		END GENERATE;	
		
		------
		
		Gen4: IF BitNumber = 4 GENERATE
			FSMUpdateBit <= FSM(5) WHEN FSM(3) = '1' ELSE FSM(4);
		END GENERATE;	
		
		Gen5: IF BitNumber = 5 GENERATE
			FSMUpdateBit <= FSM(6) WHEN FSM(3) = '1' ELSE FSM(5);
		END GENERATE;	
		
		Gen6: IF BitNumber = 6 GENERATE
			FSMUpdateBit <= FSM(7) WHEN FSM(3) = '1' ELSE FSM(6);
		END GENERATE;	
		
		Gen7: IF BitNumber = 7 GENERATE
			FSMUpdateBit <= (FSM(4) XOR FSM(5)) WHEN FSM(3) = '1' ELSE FSM(7);
		END GENERATE;	
	END GENERATE;

	---------------------------------------------------------

	GenwithDec: IF withDec /= 0 GENERATE
		Gen0: IF BitNumber = 0 GENERATE
			FSMUpdateBit <= FSM(0) WHEN FSM(3) = '0' ELSE FSM(1) WHEN EncDec = '0' ELSE (FSM(0) XOR FSM(2));
		END GENERATE;	
		
		Gen1: IF BitNumber = 1 GENERATE
			FSMUpdateBit <= FSM(1) WHEN FSM(3) = '0' ELSE FSM(2) WHEN EncDec = '0' ELSE FSM(0);
		END GENERATE;	
		
		Gen2: IF BitNumber = 2 GENERATE
			FSMUpdateBit <= FSM(2) WHEN FSM(3) = '0' ELSE (FSM(0) XOR FSM(1)) WHEN EncDec = '0' ELSE FSM(1);
		END GENERATE;	
		
		Gen3: IF BitNumber = 3 GENERATE
			FSMUpdateBit <= NOT FSM(3);
		END GENERATE;	
		
		------
		
		Gen4: IF BitNumber = 4 GENERATE
			FSMUpdateBit <= FSM(4) WHEN FSM(3) = '0' ELSE FSM(5) WHEN EncDec = '0' ELSE (FSM(4) XOR FSM(7));
		END GENERATE;	
		
		Gen5: IF BitNumber = 5 GENERATE
			FSMUpdateBit <= FSM(5) WHEN FSM(3) = '0' ELSE FSM(6) WHEN EncDec = '0' ELSE FSM(4);
		END GENERATE;	
		
		Gen6: IF BitNumber = 6 GENERATE
			FSMUpdateBit <= FSM(6) WHEN FSM(3) = '0' ELSE FSM(7) WHEN EncDec = '0' ELSE FSM(5);
		END GENERATE;	
		
		Gen7: IF BitNumber = 7 GENERATE
			FSMUpdateBit <= FSM(7) WHEN FSM(3) = '0' ELSE (FSM(4) XOR FSM(5)) WHEN EncDec = '0' ELSE FSM(6);
		END GENERATE;	
	END GENERATE;
	
end Behavioral;

