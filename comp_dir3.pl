#!/usr/bin/perl

use strict;
use warnings;

use File::DirCompare;
use File::Basename;

#no arguments; directories shouldn't change. UNFINISHED.

# $dir1 = /home/rayne/dir1;
# $dir2 = /home/rayne/dir2;

sub compare_dirs
{

    $dir1 = '/home/rayne/dir1';
    $dir2 = '/home/rayne/dir2';

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

print "Please specify two directory names\n"# and exit if (@ARGV < 2);
printf "%s\n", &compare_dirs('/home/rayne/dir1', '/home/rayne/dir2') ? 'Test: PASSED' : 'Test: FAILED';

#all print functions work; gives detail on what doesn't match

#file dircompare looks at file names and contents

#module installed successfully using sudo cpan -i File::DirCompare
