use strict;
use warnings;

use Test::More;
use Test::TinyMocker;

{
    package MockedPackage;
    sub decorate_me {
        return join(' ', @_);
    }
    sub decorate_me_also {
        return join(' ', reverse @_);
    }
}

is(MockedPackage::decorate_me(qw/one two three/),
   'one two three',
   q{... before mocking});

mock('MockedPackage', 'decorate_me',
     sub {
         my $orig = shift;
         push @_, 'decorate!';
         goto &$orig;
     },
     { is_decorator => 1 });

is(MockedPackage::decorate_me(qw/one two three/),
   'one two three decorate!',
   q{... after mocking});

unmock('MockedPackage', 'decorate_me');

is(MockedPackage::decorate_me(qw/one two three/),
   'one two three',
   q{... back to normal});

mock('MockedPackage', [ qw/decorate_me decorate_me_also/ ],
     sub {
         my $orig = shift;
         push @_, 'decorate!';
         goto &$orig;
     },
     { is_decorator => 1 });

is(MockedPackage::decorate_me(qw/one two three/),
   'one two three decorate!',
   q{... after multiple mocking});

is(MockedPackage::decorate_me_also(qw/one two three/),
   'decorate! three two one',
   q{... after multiple mocking});

done_testing;
