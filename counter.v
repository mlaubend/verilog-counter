module counter(clk,button,reset,count);
input clk, button, reset;
wire clean;
output reg [7:0] count;

initial begin
count = 0;
end

debouncer D1(clk,button,clean);

always@(posedge clk)
begin
	if(clean == 1)
		count = count + 1;
	else if(reset == 1)
		count = 0;
end
endmodule


/*module debouncer (clk, button, clean);

// Define 'input', 'output', 'reg' and 'wire' as required
input clk, button;
output reg clean;
parameter delay = 300000;
reg [21:0] delay_count;

initial delay_count = 0;

always @ (posedge clk) begin

if (button == 1)
	begin 
		if (delay_count == delay)
			begin
			delay_count <= delay_count + 1'b1;
			clean <= 1'b1;
			end
		
		else
			begin
				if (delay_count == 22'b11_1111_1111_1111_1111_1111)
					clean <= 1'b0;
				else
					begin
					delay_count <= delay_count + 1'b1;
					clean <= 1'b0;
					end
			end		
	end
else 
	begin
	delay_count <= 0;
	clean <= 0;
	end
end
endmodule*/

module debouncer(clk,button,clean);
input clk,button;
output reg clean;
reg [21:0] delay_count;

always@(posedge clk)
begin
	if (button == 1)
		if (delay_count < 22'b11_1111_1111_1111_1111_1111)
		begin
			delay_count <= delay_count + 1;
			if (delay_count == 300000)
				clean <= 1'b1;
			else
			clean <= 1'b0;
	end
	else 
	begin
	delay_count <= 0;
	clean <= 0;
	end
end
endmodule