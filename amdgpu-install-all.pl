#!/usr/bin/perl -w
my($url) = "https://repo.radeon.com/amdgpu/#/ubuntu";
my($baseurl) = $url;
$baseurl =~ s/\#.*//g;

my($output) = join("", `curl -sL $baseurl`);
my(@versions) = ();
while (1)
{
	$output =~ s/(\d+\.\d+(\.\d+)?)//;
	if (defined($1))
	{
		push(@versions, $1);
		next;
	}
	last;
}

my %temp_hash = map { $_ => 1 } @versions;
my @unique_versions = keys %temp_hash;

@versions = sort(@unique_versions);
if (scalar(@versions) == 0)
{
	die("No versions avaialable");
}

for $version (@versions)
{
	print "Installing $version ...\n";
	system("./amdgpu-install.sh $version");
}

