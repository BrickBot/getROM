#!/usr/bin/perl

# A hack to get a ROM image using techniques described elsewhere.
# This program requires a special firmware file.
# It also requires a special program to talk to the RCX.

# Kekoa Proudfoot
# 10/3/98

$SEND = "send";
$| = 0;

for ($page = 0; $page < 64; $page++) {
    $cmd = sprintf("$SEND 35 00 00 %02x 00 01", $page);
    do {
	system("$cmd >/dev/null 2>/dev/null");
    } until ($? == 0);
    $cmd = "$SEND 20";
    do {
	open(CMD, "$cmd 2>/dev/null |");
	while (<CMD>) {
	    if (/^([0-9a-f]{4,4}):\s+(([0-9a-f]{2,2}\s+)+)/) {
		$addr = $1;
		@line = split('\s+', $2);
		shift(@line) if (hex($addr) == 0);
		push(@data, @line);
	    }
	}
	close(CMD);
	if ($? == 0) {
	    $count = 0;
	    while (@data) {
		@line = splice(@data, 0, 16);
		$line = uc(join('', @line));
		$sum = hex("13") + $page + $count * 16;
		foreach $byte (@line) {
		    $sum += hex($byte);
		}
		$sum = (~$sum) & 0xff;
		printf("S113%02X%1X0$line%02X\n", $page, $count, $sum);
		$count++;
	    }
	}
    } until ($? == 0);
}
