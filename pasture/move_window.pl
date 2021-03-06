#!/usr/bin/env perl

use FindBin qw($Bin);
use lib qq($Bin/../perl5/lib/perl5);
use Modern::Perl;
use System::Command;

my $cmd_str   = q{zenity --list --text "Select Window" --column "Title"};
my $wmctrl_fh = System::Command->new(q{wmctrl -l})->stdout();

while (<$wmctrl_fh>) {
  my ($id, $desktop, $host, @title) = split(/\s+/);
  my $title = join(' ', @title);
  $cmd_str .= qq[ "$title"];
}
$wmctrl_fh->close();

my $zenity_fh = System::Command->new($cmd_str)->stdout();
my $window    = <$zenity_fh>;
$zenity_fh->close();

if ($window) {
  chomp($window);
  System::Command->new(qq{wmctrl -r '$window' -e 1,0,0,-1,-1});
  System::Command->new(qq{wmctrl -R '$window'});
}
