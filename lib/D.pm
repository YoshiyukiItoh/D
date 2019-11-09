package D;

use 5.008007;
use strict;
use warnings;

use Data::Dumper;
use Data::Recursive::Encode;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(du dw);

our $VERSION = '0.01';

# Encode data to UTF-8 and dump it to STDERR using warn function adn Data::Dumper.
sub du {
  my $ref_data = \(@_);
  $ref_data = Data::Recursive::Encode->encode_utf8($ref_data);
  my $ret = Dumper $ref_data;
  warn "$ret\n";
}

# Encode data to cp932 and dump it to STDERR using warn function adn Data::Dumper.
sub dw {
  my $ref_data = \(@_);
  $ref_data = Data::Recursive::Encode->encode("cp932",$ref_data);
  my $ret = Dumper $ref_data;
  warn "$ret\n";
}

1;

=encoding utf8

=head1 NAME

D - Provides utility functions to encode data and dump it to STDERR.

=head1 SYNOPSIS
  
  use utf8;
  
  # Export du and dw functions
  use D;
  
  # Reference data that contains decoded strings
  my $data = [{name => 'あ'}, {name => 'い'}];
  
  # Encode strings to UTF-8 in data with Data::Recursive::Encode and dump it to STDERR using warn function and Data::Dumper.
  du $data;
  
  # Encode strings to cp932 in data with Data::Recursive::Encode and dump it to STDERR using warn function and Data::Dumper.
  dw $data;

=head1 DESCRIPTION

D module provides utility functions to encode data and dump it to STDERR.

=head1 FEATURES

=over 2

=item * Export C<du> and C<dw> functions. These function names are consist of two characters. Don't conflict debug command 'p'.

=item * C<du> is a short name of "dump UTF-8"

=item * C<dw> is a short name of "dump Windows cp932"

=item * Can wirte dump operation by onliner: useD;du $data; useD;dw $data;

=item * Use Data::Recursive::Encode to encode data

=item * Use Data::Dumper::Dumper function to dump data

=item * Use warn function to print STDERR

=back

=head1 EXPORT

Export C<du> and C<dw> functions.

=head1 FUNCTIONS

=head2 du

  du $data;

Encode strings to UTF-8 in data with L<Data::Recursive::Encode> and dump it to STDERR using warn function and L<Data::Dumper>.

=head2 dw

Encode strings to cp932 in data with L<Data::Recursive::Encode> and dump it to STDERR using warn function and L<Data::Dumper>.

=head1 Bug Report

L<https://github.com/YoshiyukiItoh/D>

=head1 SEE ALSO

L<Data::Dumper>, L<Data::Recursive::Encode>

=head1 AUTHOR

yoshiyuki ito, E<lt>yoshiyuki.ito.biz@gmail.comE<gt>

Yuki Kimoto, E<lt>kimoto.yuki@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2019 by yoshi, Yuki Kimoto

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.08.7 or,
at your option, any later version of Perl 5 you may have available.


=cut
