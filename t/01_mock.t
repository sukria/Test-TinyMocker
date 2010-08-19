use strict;
use warnings;

use Test::More;
use Test::TinyMocker;

{
    package Foo::Bar;
    sub baz { "day" }
}

is Foo::Bar::baz(), "day", "initial value is ok";
mock 'Foo::Bar' => method 'baz' => should { "night" };
is Foo::Bar::baz(), "night", "static mocked value";

my $counter = 0;

mock 'Foo::Bar' 
    => method 'baz' 
    => should { $counter++; };

is Foo::Bar::baz(), 0, "dynamic mocked value";
is Foo::Bar::baz(), 1, "dynamic mocked value";

done_testing;
