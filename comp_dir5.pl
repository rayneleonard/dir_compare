#!/usr/bin/perl

use strict;
use warnings;

use File::DirCompare;
use File::Basename;

#USING arguments
#PRINTING DETAILED TEXT REPORT TO FOLDER ON DESKTOP
#would like to print date in output file as well


my $datestring = 0;
$datestring = localtime();
#print "Local date and time $datestring\n"; #works

open (REPORT, ">/home/rayne/Desktop/Reports/report.txt");
print REPORT "Results from directory comparison\t$datestring\n\n";

sub compare_dirs
{
  my ($dir1, $dir2) = @_;
  my $equal = 1;

  File::DirCompare->compare($dir1, $dir2, sub {
    my ($a,$b) = @_;
    $equal = 0; # if the callback was called even once, the dirs are not equal

    if ( !$b )
    {
      printf "File '%s' only exists in dir '%s'.\n", basename($a), dirname($a);
      printf REPORT "File '%s' only exists in dir '%s'.\n\n", basename($a), dirname($a);
    }
    elsif ( !$a ) {
      printf "File '%s' only exists in dir '%s'.\n", basename($b), dirname($b);
      printf REPORT "File '%s' only exists in dir '%s'.\n\n", basename($b), dirname($b);
    }
    else
    {
      printf "File contents for $a and $b are different.\n";
      printf REPORT "File contents for $a and $b are different.\n\n--------\n";
    }
  });

  return $equal;
}

print "Please specify two directory names\n" and exit if (@ARGV < 2);
printf "%s\n", &compare_dirs($ARGV[0], $ARGV[1]) ? 'Test: PASSED' : 'Test: FAILED';
printf REPORT "%s\n", &compare_dirs($ARGV[0], $ARGV[1]) ? 'Test: PASSED' : 'Test: FAILED';
printf REPORT "\n\nSave this file in a new text file\n\n"

#file dircompare looks at file names and contents

#module installed successfully using sudo cpan -i File::DirCompare
