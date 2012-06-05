#!/usr/bin/perl

print "v2.0 raw\n";
while (<>){
	printInstruction($_);
}


sub printInstruction(){
	my ($inst) = @_;
	$num = 0;
	if ($inst =~m/^\s*or\s+\$r([01])(,)?\s+\$r([01])/i){
		#$num = ((opcode | $1) << 4) | ($3 << 3) | funct; 
		$num = ($1 << 4) | ($3 << 3) | 0; 
	}
	elsif ($inst =~m/^\s*xor\s+\$r([01])(,)?\s+\$r([01])/i){
		$num = ($1 << 4) | ($3 << 3) | 1; 
	}
	elsif ($inst =~m/^\s*and\s+\$r([01])(,)?\s+\$r([01])/i){
		$num = ( $1 << 4) | ($3 << 3) | 2; 
	}
	elsif ($inst =~m/^\s*add\s+\$r([01])(,)?\s+\$r([01])/i){
		$num = ($1 << 4) | ($3 << 3) | 3; 
	}
	elsif ($inst =~m/^\s*srl\s+\$r([01])(,)?\s+\$r([01])/i){
		$num = ($1 << 4) | ($3 << 3) | 4; 
	}
	elsif ($inst =~m/^\s*sra\s+\$r([01])(,)?\s+\$r([01])/i){
		$num = ($1 << 4) | ($3 << 3) | 5; 
	}
	elsif ($inst =~m/^\s*not\s+\$r([01])(,)?\s+\$r([01])/i){
		$num = ($1 << 4) | ($3 << 3) | 6; 
	}
	elsif ($inst =~m/^\s*neg\s+\$r([01])(,)?\s+\$r([01])/i){
		$num = ($1 << 4) | ($3 << 3) | 7; 
	}
	elsif ($inst =~m/^\s*disp\s+\$r([01])(,)?\s+(\d+)/i){
		$num = (1 << 5) | ($1 << 4) | ($3 & 15); 
	}
	elsif ($inst =~m/^\s*lui\s+\$r([01])(,)?\s+(\d+)/i){
		$num = (2 << 5) | ($1 << 4) | ($3 & 15); 
	}
	elsif ($inst =~m/^\s*ori\s+\$r([01])(,)?\s+(\d+)/i){
		$num = (3 << 5) | ($1 << 4) | ($3 & 15); 
	}
	elsif ($inst =~m/^\s*lw\s+\$r([01])(,)?\s+(\d+)/i){
		$num = (4 << 5) | ($1 << 4) | ($3 & 15); 
	}
	elsif ($inst =~m/^\s*sw\s+\$r([01])(,)?\s+(\d+)/i){
		$num = (5 << 5) | ($1 << 4) | ($3 & 15); 
	}
	elsif ($inst =~m/^\s*j(ump)?\s+(\d+)/i){
		$num = (6 << 5) | ($2 & 31); 
	}
	elsif ($inst =~m/^\s*beq\s+(-?\d+)/i){
		$num = (7 << 5) | ($1 & 31); 
	}
	printf("%x\n", $num);
}