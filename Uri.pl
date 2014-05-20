#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper qw(Dumper);

sub create_sentence {
	my @list = @_;
	my $string = "";

	foreach (@list) {
		if ($string eq "") {
			$string = $_;
		} else {
			$string = "$string $_";
		}
	}
	parse_command($string);
}

sub parse_command {
	my $string = $_[0];
	my $res;
	my @matches;

	if ($string =~ /(what is).*(date)/) {
		$res = `date +'%m/%d/%Y'`;
		print "The current date is " . $res;
	} elsif ($string =~ /(what is).*(time)/) {
		$res = `date +'%r'`;
		print "The current time is " . $res;
	} elsif ($string =~ /(extract|untar)/) {
		@matches = $string =~ /(untar|extract)\s(.*)/;
		print "Extracting $matches[1] into current directory...\n";
		$res = `tar -zxvf $matches[1]`;
		print "Extraction complete!\n";
	}
}

create_sentence(@ARGV);
