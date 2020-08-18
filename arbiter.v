module queue(in0, out0);

    input[1:0] in0;
    input clk;
    output[1:0] out0;

    reg[1:0] q0=2'b10;
    reg[1:0] q1=2'b01;
    reg[1:0] q2=2'b00;
    reg[1:0] q3;
always #2 begin
        if(in0==2'b11) begin 
		
	    q3=q2;
	    q2=q1;
            q1=q0;
            q0=in0;
		
        end else begin	
            	if(q2==2'b11) begin
			q2=in0;
		end else if(q1==2'b11) begin
			q1=in0;	
		end else if(q0==2'b11) begin
			q0=in0;
		end
		
        end
end
    assign out0 = q3;
endmodule



module rangen(input[31:0] count, input[31:0] count1, output[3:0] r1, output[3:0] r2);
 
    reg [3:0] a,r1;
     reg [3:0] b,r2;
      integer j,c,d;
initial begin
    assign c=count;
    assign d=count1;
    assign     r1=a;
    assign r2=b;
   end
always begin
           a={$urandom(c)}%14+1;
           b={$urandom(d)}%14+2;
    for (j=0; a>=b; j=j+1)
    begin
        b={$urandom}%14+2;
    end
           $display("A %d, B: %d",a,b); 
	#2;   

end

endmodule






module arbiter(clk,request_1,request_2,request_3);
    input clk , request_1 , request_2 , request_3 ;
    reg[2:0] request=3'b011 ;
    reg[2:0] grant=3'b000 ;
    reg[3:0] r1_1 , r1_2 , r1_3;
    reg[3:0] r2_1 , r2_2 , r2_3;
    integer i = 1  ;
    reg[9:0] tr1_1,tr1_2,tr1_3,tr2_1,tr2_2,tr2_3;
    wire[1:0] b ;
    reg[1:0] r ,c ;
    integer a ;
    wire[3:0] d,e ;
    initial begin
        r1_1 = d ;
        r2_1 = e ;
       
        r1_2 = d ;
        r2_2 = e ;

        r1_3 = d ;
        r2_3 = e ;
	

	end 
	
    always  begin
        i = i+1 ;

        if(~grant[1] && ~grant[2] && ~grant[0]) begin
            c = 2'b11 ;
            r <= b ;
            if(r==2'b00) begin
                tr2_1 = r2_1 + i ;
                tr1_1 = r1_1 + i ;
                grant[0] = 1 ;
                request[0] = 0 ;
            end
            if(r==2'b01) begin
                tr2_2 = r2_2 + i ;
                tr1_2 = r1_2 + i ;
                grant[1] = 1 ;
                request[1] = 0 ;
            end
            if(r==2'b10) begin
                tr2_3 = r2_3 +i ;
                tr1_3 = r1_3 +i ;
                grant[2] = 1 ;
                request[2] = 0 ;
            end    
        end
        if(tr2_1==i) begin
            r1_1 = d ;
            r2_1 = e ;
            tr2_1=0 ;
            request[0] = 1 ;
            c <= 2'b00 ;
            
        end
        if(tr1_1==i) begin
            grant[0] = 0 ;
            tr1_1 = 0 ;
	    
        end
        if(tr2_2==i) begin
            r1_2 = d ;
            r2_2 = e ;
            tr2_2 =0 ;
            request[1] = 1 ;
            c <= 2'b01 ;
            
        end
        if(tr1_2==i) begin
            grant[1] = 0 ;
            tr1_2 = 0 ;
	    
        end
        if(tr2_3==i) begin
            r1_3 = d ;
            r2_3 = e ;
            tr2_3 =0 ;
            request[2] = 1 ;
            c <= 2'b10 ;
            
        end
        if(tr1_3==i) begin
            grant[2] = 0 ;
            tr1_3 = 0 ;
	    
        end
    #2;
	$display("%d	%d	%d	%d	%d	%d",grant[0],grant[1],grant[2],request[0],request[1],request[2]);
    end
    
	
queue X (c,b) ;
rangen Y ((i*120),(i*30),d,e) ;
endmodule
