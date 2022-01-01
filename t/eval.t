#! /usr/bin/perl
use warnings;
use strict;

use Test::More tests => 4;
use Want;

sub func {
    my $want = want('LIST');
    return $want ? 1 : 2;
}

sub func_eval {
    foreach (1) {
        my $res;
        $res = eval 'my $var1 = func(); $var1';
        diag "exception: $@" if $@;
        is($res, 2, "want() inside eval (scalar)");
        $res = eval 'my ($var1) = func(); $var1';
        diag "exception: $@" if $@;
        is($res, 1, "want() inside eval (list)");
        $res = eval 'func()';
        diag "exception: $@" if $@;
        is($res, 2, "want() in eval (scalar as eval value)");
        ($res) = eval 'func()';
        diag "exception: $@" if $@;
        is($res, 1, "want() in eval (list as eval value)");
    }
    return 1;
}

func_eval();
