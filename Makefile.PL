use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::TinyMocker',
    AUTHOR              => q{Alexis Sukrieh <sukria@sukria.net>},
    VERSION_FROM        => 'lib/Test/TinyMocker.pm',
    ABSTRACT_FROM       => 'lib/Test/TinyMocker.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-TinyMocker-*' },
);
