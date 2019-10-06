#!/usr/bin/env perl
use warnings;
use strict;
use Data::Dumper;
use Test::More;

use D;

my %data1 = (
  hira=>"いとう",
  kanji=>"伊藤",
  roma=>"ito"
);
my $ref_data1 = \%data1;

D::du($ref_data1);

is $ref_data1->{hira}, "いとう";
is $ref_data1->{kanji}, "伊藤";
is $ref_data1->{roma}, "ito";

done_testing;
