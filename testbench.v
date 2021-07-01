module test ;
  
  reg clk, rst;
  reg [1:0] coin;
  wire ticket;
  
  vending_machine m (ticket, coin, clk, rst) ;
  
  initial
    begin
      clk = 1'b0;
      $dumpfile("design.vcd");
      $dumpvars (1, test);
      $monitor($time, "  coin = %b,   state = %b,  ticket = %b", coin, m.state, ticket);
      rst = 1'b0; #13 rst = ~rst ; #1 rst = ~rst;
    end
  
  always
    #5 clk = ~clk;
  
  initial
    begin
      #22 coin = 2'd1; #10 coin = 2'd0; #10 coin = 2'd2;
      #20 coin = 2'd2; #10 coin = 2'd1;
      #20 coin = 2'd1; #10 coin = 2'd1; #10 coin = 2'd1;
      #20 coin = 2'd2; #10 coin = 2'd2;
      #20 coin = 2'd2; #10 coin = 2'd0; #10 coin = 2'd1;
      #20 coin = 2'd1; #10 coin = 2'd1; #10 coin = 2'd1;
      #30 $finish;
    end
  
endmodule
