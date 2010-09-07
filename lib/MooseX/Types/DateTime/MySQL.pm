package MooseX::Types::DateTime::MySQL;
use MooseX::Types -declare => [qw/
    MySQLDateTime
    MySQLDate
/];
use MooseX::Types::DateTime qw/ DateTime /;
use MooseX::Types::Moose qw/ Str /;
use DateTime::Format::MySQL;
use namespace::clean;

our $VERSION = '0.002';

subtype MySQLDateTime,
    as Str,
    where { /\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/ };

subtype MySQLDate,
    as Str,
    where { /\d{4}-\d{2}-\d{2}/ };

coerce MySQLDateTime,
    from DateTime,
    via { DateTime::Format::MySQL->format_datetime($_) };

coerce MySQLDate,
    from DateTime,
    via { DateTime::Format::MySQL->format_date($_) };

coerce DateTime,
    from MySQLDateTime,
    via { DateTime::Format::MySQL->parse_datetime($_) };

coerce DateTime,
    from MySQLDate,
    via { DateTime::Format::MySQL->parse_date($_) };

coerce MySQLDateTime,
    from MySQLDate,
    via { $_ . " 00:00:00" };

1;

=head1 NAME

MooseX::Types::DateTime::MySQL - Joins MooseX::Types::DateTime and DateTime::Format::MySQL

=head1 DESCRIPTION

Defines a C<MySQLDateTime> type which will round-trip coerce to the C<DateTime> type
from L<MooseX::Types::DateTime>.

=head1 TYPES

=head2 MySQLDateTime

Coerces to and from C<DateTime>.

=head2 MySQLDate

Coerces to and from C<DateTime> and will coerce to C<MySQLDateTime>.

=head1 BUGS

=over

=item The MySQL datetime detection regex is imperfect as it just looks for C< \d >s, rather than things which are known valid months.

=item Probably more

=back

=head1 AUTHOR

Tomas Doran (t0m) C<<bobtfish@bobtfish.net>>

=head1 COPYRIGHT

Copyright state51.

=head1 LICENSE

Copyright 2009 the above author(s).

This sofware is free software, and is licensed under the same terms as perl itself.

=cut

