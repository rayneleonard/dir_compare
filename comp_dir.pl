#!/usr/bin/perl

use strict;
use warnings;
use File::Find;
use List::MoreUtils qw(uniq);

#NOT USING THIS ONE


my (%files1, %files2);
my ($dir1, $dir2) = @ARGV;

find( sub { -f && $files1{$_} = $File::Find::name }, $dir1);
find( sub { -f && $files2{$_} = $File::Find::name }, $dir2);

my @all = uniq(keys %files1, keys %files2);

for my $file (@all) {
    my $result;
    if ($files1{$file} && $files2{$file}) { # file exists in both dirs
        $result = qx(/usr/bin/diff -q $files1{$file} $files2{$file});
        # ... etc
    } elsif ($files1{$file}) {              # file only exists in dir1
    } else {                                # file only exists in dir2
    }
}

#complilation errors: can't modify -f in scalar assignment at line 11
#can't modify logical and (&&) in scalar assignment at line 11
#aborted due to complilation errors
