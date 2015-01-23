# \author: Armand Leclercq
# \file: 08_tmp_unmock.t
# \date: Fri 23 Jan 2015 10:38:19 AM CET

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

# tmp_unmock
unmock('Foo::Bar', 'baz');
is Foo::Bar::baz(), "day", "original value";

# mock new comportement
mock('Foo::Bar', 'baz', sub { return 'night' });

# tmp_unmock
tmp_unmock('Foo::Bar::baz');
is Foo::Bar::baz(), "day", "original value";

# mock new comportement
mock('Foo::Bar', 'baz', sub { return 'night' });

# tmp_unmock
tmp_unmock 'Foo::Bar' => method 'baz';
is Foo::Bar::baz(), "day", "original value";

done_testing;
