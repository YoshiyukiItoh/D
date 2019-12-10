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
    hira=>"あいう",
    kana=>"アイウ"
  };

  my $output;
  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  du($ref_data1);
  my $em1 = encode("UTF-8",'あいう');
  my $em2 = encode("UTF-8",'アイウ');
  like( $output, qr/\s\s\'hira\'\s=>\s\'$em1\',/);
  like( $output, qr/\s\s\'kana\'\s=>\s\'$em2\'/);
}

# run dw() test
{
  my $ref_data2 = {
    hira=>"あいう",
    kana=>"アイウ"
  };

  my $output;
  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  dw($ref_data2);

  my $em1 = encode("cp932",'あいう');
  my $em2 = encode("cp932",'アイウ');
  like( $output, qr/\s\s\'hira\'\s=>\s\'$em1\',/);
  like( $output, qr/\s\s\'kana\'\s=>\s\'$em2\'/);
}

# run dn() test
{
  my $ref_data3 = {
    hira=>encode("UTF-8","あいう"),
    kana=>encode("UTF-8","アイウ"),
  };

  my $output;
  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  dn($ref_data3);

  my $em1 = encode("UTF-8",'あいう');
  my $em2 = encode("UTF-8",'アイウ');
  like( $output, qr/\s\s\'hira\'\s=>\s\'$em1\',/);
  like( $output, qr/\s\s\'kana\'\s=>\s\'$em2\'/);
}

# run du test (array reference)
{
  my $ref_data4 = ["あいう", "アイウ"];

  my $output;
  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  du($ref_data4);
  my $em1 = encode("UTF-8",'あいう');
  my $em2 = encode("UTF-8",'アイウ');
  like( $output, qr/\s\s\'$em1\',/);
  like( $output, qr/\s\s\'$em2\'/);
}

# run scalar reference test
{
  my $tdata1 = 'あいう';

  my $output;
  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  du(\$tdata1);

  my $em1 = encode("UTF-8",'あいう');
  like( $output, qr/^\\\'$em1\'\sat\s/);
}

# run code reference test
{
  my $code_ref = sub {
    print "test function.\n";
  };

  my $output;
  local $SIG{__WARN__} = sub {
    $output = shift;
  };

  du($code_ref);

  like( $output, qr/^sub { "DUMMY" }\sat\s/);
}

done_testing;
