use strict;
use warnings;

use Test::More;

use MooseX::Types::DateTime qw/ DateTime /;
use MooseX::Types::DateTime::MySQL qw/ MySQLDateTime /;

my $mysql = '2003-01-16 23:12:01';
ok is_MySQLDateTime($mysql), 'Parses string';
my $dt = to_DateTime($mysql);
ok $dt, 'coerce to DateTime';
is to_MySQLDateTime($dt), $mysql, 'coerce round trip to MySQL string';

done_testing;
