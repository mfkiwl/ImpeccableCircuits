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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_Midori64Enc IS
END test_Midori64Enc;
 
ARCHITECTURE behavior OF test_Midori64Enc IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Midori64Enc
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         Plaintext : IN  std_logic_vector(63 downto 0);
         Key : IN  std_logic_vector(127 downto 0);
         Ciphertext : OUT  std_logic_vector(63 downto 0);
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal Plaintext : std_logic_vector(63 downto 0) := (others => '0');
   signal Key : std_logic_vector(127 downto 0) := (others => '0');

 	--Outputs
   signal Ciphertext : std_logic_vector(63 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Midori64Enc PORT MAP (
          clk => clk,
          rst => rst,
          Plaintext => Plaintext,
          Key => Key,
          Ciphertext => Ciphertext,
          done => done
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for clk_period*1;

		Plaintext 	<= (others => '0');
		Key 			<= (others => '0');
		
		rst			<= '1';

      wait for clk_period*1;
		
		rst			<= '0';

		wait until done='1'; 
		wait for clk_period*0.5;

		if (Ciphertext = x"3c9cceda2bbd449a") then
			report "---------- Passed ----------";
		else
			report "---------- Failed ----------";
		end if;

		wait for clk_period*5;

		Plaintext 	<= x"42c20fd3b586879e";
		Key 			<= x"687ded3b3c85b3f35b1009863e2a8cbf";
		
		rst			<= '1';  
		
		wait for clk_period*1;
		
		rst			<= '0';

		wait until done='1';
		wait for clk_period*0.5;

		if (Ciphertext = x"66bcdc6270d901cd") then
			report "---------- Passed ----------";
		else
			report "---------- Failed ----------";
		end if;

		wait for clk_period*5;

		Plaintext 	<= (others => '0');
		Key 			<= x"2b7e151628aed2a6abf7158809cf4f3c";
		
		rst			<= '1';  
		
		wait for clk_period*1;
		
		rst			<= '0';

		wait until done='1';
		wait for clk_period*0.5;

		if (Ciphertext = x"1104f12cf2d42a76") then
			report "---------- Passed ----------";
		else
			report "---------- Failed ----------";
		end if;

      wait;
   end process;

END;