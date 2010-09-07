use strict;
use warnings;

use Test::More;

use MooseX::Types::DateTime qw/ DateTime /;
use MooseX::Types::DateTime::MySQL qw/ MySQLDateTime MySQLDate /;

{
    my $mysql = '2003-01-16 23:12:01';
    ok is_MySQLDateTime($mysql), 'Parses string';
    my $dt = to_DateTime($mysql);
    ok $dt, 'coerce to DateTime';
    is to_MySQLDateTime($dt), $mysql, 'coerce round trip to MySQL string';
}
{
    my $mysql = '2003-01-16';
    ok is_MySQLDate($mysql), 'Parses string';
    my $dt = to_DateTime($mysql);
    ok $dt, 'coerce to DateTime';
    is to_MySQLDate($dt), $mysql,
        'coerce round trip to MySQL string';

    is to_MySQLDateTime($mysql), $mysql . ' 00:00:00',
        'MySQLDate => MySQLDateTime';
}

done_testing;

