function [lrn_rt counter] = update_lrn_rate ( lrn_rt, error, prev_error, counter)
	%Updates the learn rate according to learn strategy
	%1 = CONSTANT, does nothing.
	%2 = ANNEALED, exponential decay over time
	%3 = SMART, if error is being consistently reduced, increases learn rate
	%else, learn rate is exponentialy reduced
	%max learn rate is 1/2
    lrn_decay = 0.75;
    lrn_sum = 0.005;
    lrn_type = 3;
	if(lrn_type == 2)
		counter = counter + 1;
		if( counter == 30)
			counter =0;
			lrn_rt = lrn_decay * lrn_rt;
        end
    end
	if(lrn_type == 3)
		if(error > prev_error)
			counter = 0;
			lrn_rt = lrn_decay * lrn_rt;
			if( lrn_rt < 0.02)
				lrn_rt = 0.02;
            end
		elseif( error <= prev_error)
			counter =counter + 1;
			if(counter > 3)
				lrn_rt = lrn_rt + lrn_sum;
				if(lrn_rt > 0.75)
					lrn_rt = 0.75;
                end
            end
        end
		%check for local minimum
     end
    
    if(lrn_type == 3 && error > 1 && lrn_rt <= 0.05)
		%error is higher than 1, net lrn rate is LOW, local minimum spotted!
		prev_error = Inf;
		lrn_rt = 1;
	else
		prev_error = error;
    end
	
end