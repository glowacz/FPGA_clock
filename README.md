***Functionality Description:***

The program in this repository, when loaded onto an FPGA board, creates a clock on a 7-segment display. The clock functions as a stopwatch, counting minutes and seconds. Used IEEE libraries, multiplexing, button debouncing and rising edge detection. <br />

The program has following functionalities:

* sw[15] - resets the clock when toggled and toggled back.

* btnR - manual adjustment (setting) of the number of seconds. The seconds increment at a rate of 10 increments per second while the button is held down.

* btnL - manual adjustment (setting) of the number of minutes. The minutes increment at a rate of 1 increment per second while the button is held down.

<br />

***System Architecture Description:***

**Ports:**

* clk - input clock signal.
* reset - input reset signal.
* btnL - input signal from the left button.
* btnR - input signal from the right button.
* an - output vector controlling the activation of digits on the display.
* seg - output vector controlling the segments of the display.

**Architecture:**

* signal one_sec_cnt: STD_LOGIC_VECTOR (27 downto 0) - a variable for counting the oscillator cycles of the board; when it reaches 99,999,999 (which is the oscillator frequency - 1), it resets.
* signal one_sec_enable: STD_LOGIC - a variable for incrementing the number of seconds, which is set only when one_sec_cnt is 99,999,999 (one cycle needed to increment the number of seconds).
* signal number: integer - a variable for counting the number of seconds from the start (or from reset).
* signal LED_BCD: integer - an integer variable indicating which digit should be displayed on the currently active segment (this information is derived from the seconds counter number).
* signal refresh_cnt: STD_LOGIC_VECTOR (19 downto 0) - a variable for refreshing the DISP1 display.
* signal LED_activating_cnt: STD_LOGIC_VECTOR (1 downto 0) - a variable used to select the currently active digit (an) and set the appropriate BCD value (LED_BCD) for display.
