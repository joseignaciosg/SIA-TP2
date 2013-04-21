function [lrn_rt, contador] = update_lrn_rate ( lrn_rt, error, prev_error, contador, jump)
	%Updates the learn rate according to learn strategy
	%1 = CONSTANT, does nothing.
	%2 = ANNEALED, exponential decay over time
	%3 = SMART, if error is being consistently reduced, increases learn rate
	%else, learn rate is exponentialy reduced
	%max learn rate is 1/2
    lrn_decay = 0.75;
    lrn_sum = 0.005;
    lrn_type = 3;
    lrn_consist = 3;
	if(lrn_type ==2)
		contador = contador + 1;
		if(contador == 50)
			contador =0;
			lrn_rt = lrn_decay * lrn_rt;
		end
	end
	if(lrn_type == 3)
		if(error > prev_error)
			contador = 0;
			lrn_rt = lrn_decay * lrn_rt;
			if( lrn_rt < 0.02)
				lrn_rt = 0.02;
			end
		elseif( error < prev_error)
			contador = contador + 1;
			if(contador >= lrn_consist)
				lrn_rt = lrn_rt + lrn_sum;
				if(lrn_rt > 0.6)
					lrn_rt = 0.6;
				end
			end
		end

	end

	if(lrn_type == 3 && error > 0.025 && jump == 1 && lrn_rt < 0.05)
		disp "SALTO"
		%error is higher than 1, lrn rate is LOW, local minimum spotted!
		prev_error = Inf;
		lrn_rt = 1;
	else
		prev_error = error;
	end
	
end