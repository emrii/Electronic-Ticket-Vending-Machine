module vending_machine (ticket, coin, clk, rst) ;

  output reg ticket;
  input clk, rst;
  input [1:0] coin;

  reg [1:0] state;

  parameter PENNY = 2'd0, NICKEL = 2'd1, DIME = 2'd2 ; //coins 
  parameter S0 = 2'd0, S1 = 2'd1, S2 = 2'd2, S3 = 2'd3; //states of the machine

  
  always @ (posedge rst or negedge ticket) //machine is reset after each ticket is dispensed
    begin
      state <= S0;
      ticket = 1'b0;
      #0 $display("Enter the coins, only nickels and dimes accepted.");
    end

  
  
  always @ (posedge clk)
    case (state)
      S0 : case (coin)
        NICKEL : state <= S1;
        DIME : state <= S2;
        PENNY : begin
          state <= S0;
          $display("Invalid coin");
        end
      endcase
      S1 : case (coin)
        NICKEL : state <= S2;
        DIME : begin
          state <= S3;
          ticket <= 1'b1;
        end
        PENNY : begin
          state <= S1;
          $display("Invalid coin");
        end
      endcase
      S2 : case (coin)
        NICKEL : begin
          state <= S3;
          ticket <= 1'b1;
        end
        DIME : begin
          state <= S3;
          ticket <= 1'b1;
        end
        PENNY : begin
          state <=S2;
          $display("Invalid coin");
        end
      endcase
      S3 : begin
        $display("Collect your ticket, extra money will not be refunded.");
        ticket = 1'b0;
      end
    endcase
  
endmodule
