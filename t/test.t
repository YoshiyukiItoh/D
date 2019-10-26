#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
use Encode 'encode';
use Data::Dumper;
use Test::More;

use D;

# run test
# $ perl -Mblib test.t 

{
  my $ref_data1 = {
    hira=>"いとう",
    kanji=>"伊藤",
    roma=>"ito"
  };

  my $output;

  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  du($ref_data1);

  like( $output, qr/hira/);
  like( $output, qr/kanji/);
  like( $output, qr/roma/);
  my $em1 = encode("UTF-8",'いとう');
  like( $output, qr/$em1/);
  my $em2 = encode("UTF-8",'伊藤');
  like( $output, qr/$em2/);
  my $em3 = encode("UTF-8",'ito');
  like( $output, qr/$em3/);
}

done_testing;
