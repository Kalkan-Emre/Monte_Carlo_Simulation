N=4145;
lambda_number_of_automobiles = 50;
lambda_number_of_trucks = 10;
lambda_weight_of_automobiles = 0.15;
lambda_weight_of_trucks = 0.01;
alfa_weight_of_automobiles = 190;
alfa_weight_of_trucks = 110;


TotalWeight_in_tons=zeros(N,1); 

for k=1:N;
	U_1 = rand; 
	num_of_auto = 0; 
	F_1 = exp(-lambda_number_of_automobiles);
	while (U_1>=F_1);
		num_of_auto=num_of_auto+1;
		temp = lambda_number_of_automobiles;
		F_1 = F_1+exp(-temp)*temp^num_of_auto/gamma(num_of_auto+1);
	end;
	
	U_2 = rand; 
	num_of_trucks = 0; 
	F_2 = exp(-lambda_number_of_trucks);
	while (U_2>=F_2);
		num_of_trucks=num_of_trucks+1;
		temp = lambda_number_of_trucks;
		F_2 = F_2+exp(-temp)*temp^num_of_trucks/gamma(num_of_trucks+1);
	end;
	
	
	weight = 0;
	
	s1 = 800; t1 = 1700; m1 = 0.05;  
	for f=1:num_of_auto; 
		CY1 = m1; 
		F_1 = 0; 
		while (CY1 > F_1); 
			U = rand; 
			V = rand;
			CX1 = s1+(t1-s1)*U; CY1 = m1*V;
			F_1=lambda_weight_of_automobiles^alfa_weight_of_automobiles/gamma(alfa_weight_of_automobiles-1)*CX1^(alfa_weight_of_automobiles-1)*exp(-lambda_weight_of_automobiles*CX1);
		end;
		weight = weight + CX1;	
	end;
	
	s2 = 7000; t2 = 16000; m2 = 0.04;
	for f=1:num_of_trucks; 
		CY2 = m2; 
		F_2 = 0; 
		while (CY2 > F_2); 
			U = rand; 
			V = rand;
			CX2 = s2+(t2-s2)*U; CY2 = m2*V;
			F_2=lambda_weight_of_trucks^alfa_weight_of_trucks/gamma(alfa_weight_of_trucks-1)*CX2^(alfa_weight_of_trucks-1)*exp(-lambda_weight_of_trucks*CX2);
		end;
		weight = weight + CX2;	
	end;
	
	weight_in_tons = weight/1000;
	TotalWeight_in_tons(k) = weight_in_tons;

end;


p_est = mean(TotalWeight_in_tons>200);
expected_weight_in_kilograms = mean(TotalWeight_in_tons)*1000;
std_weight_in_kilograms = std(TotalWeight_in_tons)*1000;
fprintf('Estimated probability = %f\n', p_est);
fprintf('Expected weight = %f kg\n', expected_weight_in_kilograms);
fprintf('Standard deviation = %f kg\n', std_weight_in_kilograms);