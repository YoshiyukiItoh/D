#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
use Encode 'encode';
use Data::Dumper;
use Test::More;

use D;

# $ perl -Mblib test.t 
# run du() test
{
  my $ref_data1 = {
    hira=>"いとう",
    kanji=>"伊藤",
  };

  my $output;

  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  du($ref_data1);

  my $em1 = encode("UTF-8",'いとう');
  like( $output, qr/\s\s\'hira\'\s=>\s\'$em1\',/);
  my $em2 = encode("UTF-8",'伊藤');
  like( $output, qr/\s\s\'kanji\'\s=>\s\'$em2\'/);
}

# run dw() test
{
  my $ref_data2 = {
    hira=>"いとう",
    kanji=>"伊藤",
  };

  my $output;

  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  dw($ref_data2);

  my $em1 = encode("cp932",'いとう');
  like( $output, qr/\s\s\'hira\'\s=>\s\'$em1\',/);
  my $em2 = encode("cp932",'伊藤');
  like( $output, qr/\s\s\'kanji\'\s=>\s\'$em2\'/);
}

# run dn() test
{
  my $ref_data3 = {
    hira=>encode("UTF-8","いとう"),
    kanji=>encode("UTF-8","伊藤"),
  };

  my $output;

  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  dn($ref_data3);

  my $em1 = encode("UTF-8",'いとう');
  like( $output, qr/\s\s\'hira\'\s=>\s\'$em1\',/);
  my $em2 = encode("UTF-8",'伊藤');
  like( $output, qr/\s\s\'kanji\'\s=>\s\'$em2\'/);
}

# run scalar reference test
{
  my $tdata1 = 'いとう';
  my $output;

  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  du(\$tdata1);

  my $em1 = encode("UTF-8",'いとう');
  like( $output, qr/^\\\'$em1\'\sat\s/);
}

# run code reference test
{
  my $sum_ref = sub {
    my ($num1, $num2) = @_;
    my $total = $num1 + $num2;
    return $total;
  };
  my $output;

  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  du($sum_ref);

  like( $output, qr/^sub { "DUMMY" }\sat\s/);
}

done_testing;
