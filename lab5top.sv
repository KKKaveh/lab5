// lab5top.sv - top-level module for ELEX 7660 lab 5 to display an image on the LCD
// Robert Trost  
// Feb 3, 2020 - Created
// Feb 7, 2024 - Updated to work with TI Educational BoosterPack

module lab5top (
                input logic FPGA_CLK1_50,  // 50 MHz input clock
                input logic s1,            // S1 pushbutton
                output logic lcd_sda, lcd_scl, lcd_cs, lcd_rs, lcd_rst,  // LCD signals
				output logic red, green, blue // RGB LED signals
				) ;

    logic [7:0] gpio;  // gpio signal from processor
	
    // instantiate processor system here
	 lab5 u0 (
        .clk_clk       (FPGA_CLK1_50), // Connects to 50 MHz input clock
        .gpio_export   (gpio),         // Connects to internal gpio signal
        .reset_reset_n (s1),           // Connects to S1 pushbutton
        .spi_MISO      (),             // Not connected
        .spi_MOSI      (lcd_sda),      // .MOSI
        .spi_SCLK      (lcd_scl),      // .SCLK
        .spi_SS_n      (lcd_cs)        // .SS_n
    );

    // control the display data/command (lcd_rs) with gpio[0] from processor
    assign lcd_rs = gpio[0];
	
    // control active low display reset (lcd_rst) with gpio[1] from processor
    assign lcd_rst = gpio[1];

	// turn off the RGB LED on the BoosterPack
	assign {red, green, blue} = '0;

endmodule