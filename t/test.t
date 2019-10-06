#!/usr/bin/env perl
use warnings;
use strict;
use Data::Dumper;
use Encode;
use Test::More;

use D;

# utility functions
sub U($) { decode("UTF-8",$_[0]) }
sub u($) { encode("UTF-8",$_[0]) }

my $ref_data1 = {
  hira=>U("いとう"),
  kanji=>U("伊藤"),
  roma=>"ito"
};

D::du($ref_data1);

is $ref_data1->{hira}, U("いとう");
is $ref_data1->{kanji}, U("伊藤");
is $ref_data1->{roma}, "ito";

done_testing;
