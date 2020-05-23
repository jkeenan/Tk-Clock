use strict;
use warnings;
use Tk;
use Tk::Clock;
END { print "Finished!\n"; }

my $rv;
my ($delay, $period, $m, $c) = (0, 300);
unless ($m = eval { MainWindow->new  (-title => "clock") }) {
    exit 0;
    }

$c = $m->Clock (-background => "Black");
print "Clock Widget ", (defined $c ? "defined" : "not defined"), "\n";

print "Delay is 0 ", ($delay == 0 ? "ok" : "not ok"), "\n";
print "Period is $period ", (($period =~ qr/^\d+$/) ? "ok" : "not ok"), "\n";
$delay += $period;
print "First after $delay ", (($delay =~ qr/^\d+$/) ? "ok" : "not ok"), "\n";


$delay += $period;
$c->after ($delay, sub {
    $c->configure (-background => "Purple4");
    $rv = $c->config ({
	useAnalog  => 0,
	useInfo    => 0,
	useDigital => 1,
	useLocale  => ($^O eq "MSWin32" ? "Japanese_Japan.932" : "ja_JP.utf8"),
	timeFont   => "Helvetica 8",
	dateFont   => "Helvetica 8",
	dateFormat => "dddd\nd mmm yyy",
	timeFormat => "",
	});
    print "Purple4 aD dddd\\nd mmm yyy '' ", ($rv ? "ok" : "not ok"), "\n";
    });


$delay += $period;
$c->after ($delay, sub {
    print "XXX: Entering destructors\n";
    $c->destroy;
    print "Destroy Clock ", (!Exists ($c) ?  "ok" : "not ok"), "\n";
    local $@;
    eval {$m->destroy; };
    $@ and warn "Destroy Main FAIL: $@";
});

MainLoop;
