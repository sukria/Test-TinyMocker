use strict;
use warnings;

use Test::More;
use Test::TinyMocker;

eval { unmock 'Module::Will' => method 'not_exists'  };

like( $@, qr{unkown method}, "no recover nuknown method" );                                                                       

done_testing;
