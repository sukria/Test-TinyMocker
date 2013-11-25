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
mock('Foo::Bar', 'qux', 1, sub { return $_[0] + 1 });
is Foo::Bar::qux(1), 2, "basic syntax";

mock 'Foo::Bar' => method 'quux' => create 1 => should { "night" };
is Foo::Bar::quux(), "night", "static mocked value";

my $counter = 0;

mock 'Foo::Bar' 
    => method 'garply'
    => create 1
    => should { $counter++; };

is Foo::Bar::garply(), 0, "dynamic mocked value";
is Foo::Bar::garply(), 1, "dynamic mocked value";

mock('Foo::Bar::waldo', 1, sub { return $_[0] + 3 });
is Foo::Bar::waldo(1), 4, "2 args syntax";

mock 'Foo::Bar::fred' 
    => create 1
    => should { $_[0] + 2 };
is Foo::Bar::fred(1), 3, "2 args syntax with sugar";

done_testing;