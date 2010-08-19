package Test::TinyMocker;

use strict;
use warnings;

use vars qw(@EXPORT);
use base 'Exporter';
our $VERSION = '0.01';

@EXPORT = qw(mock should method);

sub method($) {@_}
sub should(&) {@_}

sub mock {
    {
        no strict 'refs';
        no warnings 'redefine', 'prototype';
        if (@_ == 3) {
            my ($class, $method, $sub) = @_;

            *{"${class}::${method}"} = $sub;
        }
        else {
            my ($method, $sub) = @_;
            *{$method} = $sub;
        }
    }
}

1;
__END__

=head1 NAME

Test::TinyMocker - a very simple tool to mock external modules

=head1 VERSION

Version 0.01



=head1 SYNOPSIS

    use Test::More;
    use Test::TinyMocker;

    mock 'Some::Module'
        => method 'some_method'
        => should {
            return $mocked_value;
        };

    # or 

    mock 'Some::Module::some_method'
        => should {
            return $mocked_value;
        };

    # Some::Module::some_method() will now always return $mocked_value;

=head1 EXPORT

=head2 mock($module, $method, $sub)

This function allows you to overwrite the given method with an arbitrary code
block. This lets you simulate soem kind of behaviour for your tests.

Alternatively, this method can be passed only two arguments, the first one will
be the full path of the method (pcakge name + method name) and the second one
the coderef.

Syntactic sugar is provided (C<method> and C<should>) in order to let you write
sweet mock statements:

    # This:
    mock('Foo::Bar', 'a_method', sub { return 42;});

    # is the same as:
    mock 'Foo::Bar' => method 'a_method' => should { return 42 };

    # or:
    mock 'Foo::Bar::a_method' => should { return 42 };

    # or also:
    mock('Foo::Bar::a_method', sub { return 42;});

=head2 method

Syntactic sugar for mock()

=head2 should

Syntactic sugar for mock()

=head1 AUTHOR

Alexis Sukrieh, C<< <sukria at sukria.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-tinymocker at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-TinyMocker>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::TinyMocker


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-TinyMocker>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-TinyMocker>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-TinyMocker>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-TinyMocker/>

=back


=head1 ACKNOWLEDGEMENTS

This module was inspired by Gugod's blog, after the article published about
mocking in Ruby and Perl: L<http://gugod.org/2009/05/mocking.html>

This module was first part of the test tools provided by Dancer in its own t
directory (previously named C<t::lib::EasyMocker>). A couple of developers asked
me if I could released this module as a real Test:: distribution on CPAN, so
here it is.

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alexis Sukrieh.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
