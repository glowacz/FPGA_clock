library IEEE; 

use IEEE.STD_LOGIC_1164.ALL; 

use IEEE.STD_LOGIC_ARITH.ALL; 

use IEEE.STD_LOGIC_UNSIGNED.ALL; 

 

entity Seven_Segment is 

    Port( clk : in STD_LOGIC; 

          reset : std_logic; 

          btnL: in std_logic; 

          btnR: in std_logic; 

          an : out STD_LOGIC_VECTOR (3 downto 0); 

          seg : out STD_LOGIC_VECTOR (6 downto 0) 

     ); 

end Seven_Segment; 

 

architecture Behavioral of Seven_Segment is 

    signal one_sec_cnt: STD_LOGIC_VECTOR (27 downto 0); 

    signal one_sec_enable: STD_LOGIC; 

    signal number: integer; 

    signal LED_BCD: integer; 

    signal refresh_cnt: STD_LOGIC_VECTOR (19 downto 0); 

    signal LED_activating_cnt: STD_LOGIC_VECTOR (1 downto 0); 

    begin 

        process(LED_BCD) 

        begin 

            case LED_BCD is 

                when 0 => seg <= "1000000"; 

                when 1 => seg <= "1111001"; 

                when 2 => seg <= "0100100"; 

                when 3 => seg <= "0110000"; 

                when 4 => seg <= "0011001"; 

                when 5 => seg <= "0010010"; 

                when 6 => seg <= "0000010"; 

                when 7 => seg <= "1111000"; 

                when 8 => seg <= "0000000"; 

                when 9 => seg <= "0010000"; 

                when others => seg <= "1111111"; 

            end case; 

        end process; 

 

        process(clk, reset) 

        begin 

            if(reset='1') then 

                refresh_cnt <= (others => '0'); 

            elsif((rising_edge(clk))) then 

                refresh_cnt <= refresh_cnt + 1; 

            end if; 

        end process; 

         

        LED_activating_cnt <= refresh_cnt(19 downto 18); 

 

        process(LED_activating_cnt) 

        begin 

            case LED_activating_cnt is 

            when "00"=> 

                an <="0111"; 

                LED_BCD <= (number / 600) mod 6; 

            when "01" => 

                an <= "1011"; 

                LED_BCD  <= (number / 60) mod 10; 

            when "10" => 

                an <= "1101"; 

                LED_BCD <= (number / 10) mod 6; 

            when "11" => 

                an <="1110"; 

                LED_BCD <= number mod 10; 

            end case; 

        end process; 

 

        process(clk, reset, btnR) 

        begin 

            if(rising_edge(clk)) then 

                if(one_sec_cnt>=x"5F5E0FF") then 

                    one_sec_cnt <= (others => '0'); 

                elsif(btnR='1') then 

                    one_sec_cnt <= one_sec_cnt + "0001010"; 

                else 

                    one_sec_cnt <= one_sec_cnt + "0000001"; 

                end if;                

            end if; 

        end process; 

 

        one_sec_enable <= '1' when one_sec_cnt>=x"5F5E0FF" else '0'; 

 

        process(clk, reset, btnL) 

        begin 

            if(reset='1') then 

                number <= 1; 

            elsif (rising_edge(clk)) then 

                if(one_sec_enable='1') then 

                    if(btnL='1') then 

                        number <= number + 60; 

                    else 

                        number <= number + 1; 

                    end if; 

                end if; 

            end if; 

        end process; 

end Behavioral; 