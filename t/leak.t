BEGIN { $| = 1; print "1..2\n"; }

# Test that we can load the module
END {print "not ok 1\n" unless $loaded;}
use Want;
$loaded = 1;
print "ok 1\n";

# Test that the RHS is not leaked in an lnoreturn lvalue sub assignment

{
    package Foo;
    our $destroyed = 0;
    sub new {
        my ($package) = @_;
        my $self = {};
        bless $self, $package;
        return $self
    }
    sub DESTROY {
        $destroyed++;
    }
}

package main;
sub foo :lvalue {
    lnoreturn;
    return;
}

foo = Foo->new();

print ($Foo::destroyed ? "ok 2\n" : "not ok 2\n");
