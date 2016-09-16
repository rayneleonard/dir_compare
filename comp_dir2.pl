#!/usr/bin/perl

use strict;
use warnings;

use File::DirCompare;
use File::Basename;

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
    }
    elsif ( !$a ) {
      printf "File '%s' only exists in dir '%s'.\n", basename($b), dirname($b);
    }
    else
    {
      printf "File contents for $a and $b are different.\n";
    }
  });

  return $equal;
}

print "Please specify two directory names\n" and exit if (@ARGV < 2);
printf "%s\n", &compare_dirs($ARGV[0], $ARGV[1]) ? 'Test: PASSED' : 'Test: FAILED';


#this works
#only prints pass or fail; work on making more user friendly and print details
#file dircompare looks at file names and contents

#module installed successfully using sudo cpan -i File::DirCompare
