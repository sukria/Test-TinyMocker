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

# basic syntax
mock('Foo::Bar', 'baz', sub { return $_[0] + 1 });
is Foo::Bar::baz(1), 2, "basic syntax";

mock 'Foo::Bar' => method 'baz' => should { "night" };
is Foo::Bar::baz(), "night", "static mocked value";

my $counter = 0;

mock 'Foo::Bar' 
    => method 'baz' 
    => should { $counter++; };

is Foo::Bar::baz(), 0, "dynamic mocked value";
is Foo::Bar::baz(), 1, "dynamic mocked value";

mock('Foo::Bar::baz', sub { return $_[0] + 3 });
is Foo::Bar::baz(1), 4, "2 args syntax";

mock 'Foo::Bar::baz' 
    => should { $_[0] + 2 };
is Foo::Bar::baz(1), 3, "2 args syntax with sugar";



done_testing;
