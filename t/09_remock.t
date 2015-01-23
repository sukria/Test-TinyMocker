# \author: Armand Leclercq
# \file: 09_remock.t
# \date: Fri 23 Jan 2015 10:39:57 AM CET

use strict;
use warnings;

use Test::More;
use Test::TinyMocker;

{
    package Foo::Bar;
    sub baz { "day" }
}

# original value
is Foo::Bar::baz(), "day", "initial value is ok";

# mock new comportement
mock('Foo::Bar', 'baz', sub { return 'night' });

# unmock
tmp_unmock('Foo::Bar', 'baz');
is Foo::Bar::baz(), "day", "original value";

# remock new comportement
remock('Foo::Bar', 'baz');
is Foo::Bar::baz(), "night", "mocked value";

# unmock
unmock('Foo::Bar::baz');
is Foo::Bar::baz(), "day", "original value";

# remock new comportement
eval { remock('Foo::Bar', 'baz'); };
like( $@, qr{unkown method}, "no recover nuknown method" );

done_testing;
